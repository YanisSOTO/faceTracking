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
    if imageArray[2] == nil {
        imageArray[2] = UIImage(named: "rainbowButton.png")
    }
    if imageArray[3] == nil {
        imageArray[3] = UIImage(named: "fireButton.png")
    }
    if imageArray[4] == nil {
        imageArray[4] = UIImage(named: "beardButton.png")
    }
    return (imageArray)
}