//
//  main.swift
//  Equalizer
//
//  Created by Jian Hu on 16/5/14.
//  Copyright © 2016年 DataYP. All rights reserved.
//

import Foundation

Path.current = "Path to check"

// correct image file name, same with
// name of imageset
let imageSet = findTargetImageSets()
imageSet.forEach {correctName(imageSet: $0)}

print("-------ImageSets With Dirty Name------")
print(imageSet.map{ $0.name }.joinWithSeparator("\n"))
print("\n\n\n Correcting Name Ends")

// to find all imagesets not referenced
// in source code
let allImageSet = findAllImageSets()
let loners = listLoners(allImageSet)

print("---------------Loner--------------")
print(loners.joinWithSeparator("\n"))
print("\n\n\n Finding Loner Ends")

