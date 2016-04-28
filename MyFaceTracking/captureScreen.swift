//
//  captureScreen.swift
//  MyFaceTracking
//
//  Created by Soto Yanis on 28/04/2016.
//  Copyright © 2016 Soto Yanis. All rights reserved.
//

import UIKit


func captureScreen() -> UIImage {
    var window: UIWindow? = UIApplication.sharedApplication().keyWindow
    window = UIApplication.sharedApplication().windows[0]
    UIGraphicsBeginImageContextWithOptions(window!.frame.size, window!.opaque, 0.0)
    window!.layer.renderInContext(UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image;
}