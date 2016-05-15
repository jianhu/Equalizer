//
//  main.swift
//  Equalizer
//
//  Created by Jian Hu on 16/5/14.
//  Copyright © 2016年 DataYP. All rights reserved.
//

import Foundation

let imageSet = findTargetImageSets()

imageSet.forEach {correctName(imageSet: $0)}
