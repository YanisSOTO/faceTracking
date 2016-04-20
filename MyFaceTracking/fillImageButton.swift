//
//  fillImageButton.swift
//  MyFaceTracking
//
//  Created by Soto Yanis on 20/04/2016.
//  Copyright © 2016 Soto Yanis. All rights reserved.
//

import UIKit


func fillImageArray () -> [Int: UIImage] {
    var imageArray = [Int: UIImage]()
    
    if imageArray[0] == nil {
        imageArray[0] = UIImage(named: "loveButton.png")
    }
    if imageArray[1] == nil {
        imageArray[1] = UIImage(named: "dogButton.png")
    }
    return (imageArray)
}