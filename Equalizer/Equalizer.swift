//
//  Equalizer.swift
//  Equalizer
//
//  Created by Jian Hu on 16/5/14.
//  Copyright © 2016年 DataYP. All rights reserved.
//

import Foundation


struct ImageSet {
    
    // File path to `.imageset` directory
    let path: String
    
    // Image set name
    let name: String
    
    // Dictionay of ``Contents.json`
    let content: Dictionary<String, AnyObject>
    
    // Check if imageset name matching file name
    func nameMatching() -> Bool{
        let images = content["images"] as! [[String:String]]
        for image in images{
            guard let fileName = image["filename"] else {
                continue
            }
            if !(fileName.hasPrefix("\(name)@")){
                print(fileName, "---", name)

                return false
            }
        }
        
        return true
    }
}

func findTargetImageSets() -> [ImageSet] {
    
    var tagetImageSets:[ImageSet] = []
    let path = Path.current
    
    for child in try! path.children() {
        if(!child.isDirectory){
            continue
        }
        if child.path.hasSuffix(".imageset") {
            let imageSet = ImageSet(path: child.path, name: child.lastComponentWithoutExtension, content: readContent(Path("\(child.path)/Contents.json")))
            if !imageSet.nameMatching() {
                tagetImageSets.append(imageSet)
            }
        }else {
            try! child.chdir{
                tagetImageSets.appendContentsOf(findTargetImageSets())
            }
        }
    }
    
    return tagetImageSets
}

func readContent(path: Path) -> [String:AnyObject] {
    
    let content = try! NSJSONSerialization.JSONObjectWithData(try! path.read(), options: .AllowFragments)
    
    return content as! [String : AnyObject]
}

func correctName(imageSet imageSet: ImageSet) {
    var content = imageSet.content
    let contentPath = Path("\(imageSet.path)/Contents.json")
    let imageSetName = imageSet.name
    
    var images = content["images"] as! [[String:String]]
    for (idx, image) in images.enumerate(){
        guard let fileName = image["filename"] else {
            continue
        }
        
        let scale = image["scale"]
        var separator = "@"
        if scale == "1x" {
            separator = "."
        }
        let components = fileName.componentsSeparatedByString(separator)
        if components.count != 2 {
            continue
        }
        let correctFileName = "\(imageSetName)\(separator)\(components[1])"
        
        // change image name
        let srcFilePath = Path("\(imageSet.path)/\(fileName)")
        let destFilePath = Path("\(imageSet.path)/\(correctFileName)")
        try! srcFilePath.move(destFilePath)
        
        var mutImage = image
        mutImage["filename"] = correctFileName
        
        images[idx] = mutImage
    }
    
    content["images"] = images
    
    // write back content.json
    try! contentPath.delete()
    let data = try! NSJSONSerialization.dataWithJSONObject(content, options: .PrettyPrinted)
    try! contentPath.write(data)
}

