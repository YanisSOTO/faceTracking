//
//  filterClass.swift
//  MyFaceTracking
//
//  Created by Soto Yanis on 20/04/2016.
//  Copyright © 2016 Soto Yanis. All rights reserved.
//

import UIKit
import SwiftGifOrigin


class Filter {
    var eye = ["left": UIImageView(),
               "right": UIImageView()]
    var noseDogView = UIImageView()
    var tongueDogView = UIImageView()
    var waterFallView = UIImageView()
    
    let processPoint = ProcessPoints()
    
    /** HEART **/
    
    func drawHeart(points: [CGPoint], side: String) -> UIImageView {
        if (side == "left") {
            let image = UIImage(named: "coeur.png")
            eye[side]!.image = image
        } else {
            let image = UIImage(named: "coeur.png")
             eye[side]!.image = image
        }

        let centerEye = processPoint.processCenter(points[0], point2: points[5])
        let eyeCornerDist = processPoint.processCornerDist(points[0], point2: points[5])
        let eyeWidth = 2.0 * eyeCornerDist
        let eyeHeight = (eye[side]!.image!.size.height / eye[side]!.image!.size.width) * eyeWidth
        
        eye[side]!.transform = CGAffineTransformIdentity
        eye[side]!.frame = CGRectMake(centerEye.x - eyeWidth / 2, centerEye.y - eyeWidth / 2, eyeWidth, eyeHeight)
        eye[side]!.hidden = false
        processPoint.setAnchorPoint(CGPointMake(0.5, 1.0), forView:  eye[side]!)
        eye[side]!.transform = CGAffineTransformMakeRotation(processPoint.processAngle(points[0], point2: points[5]))
    
        return ( eye[side]!)
    }
    
    /** NOSE DOG **/
    
    func drawDogNose(points: [CGPoint]) -> UIImageView {
        if (noseDogView.image == nil) {
            let image = UIImage(named: "noseDog.png")
            noseDogView.image = image
        }
        
        let centerNose = processPoint.processCenter(points[0], point2: points[6])
        let noseCornerDist = processPoint.processCornerDist(points[0], point2: points[6])
        let noseWidth = 2.0 * noseCornerDist
        let noseHeight = (noseDogView.image!.size.height / noseDogView.image!.size.width) * noseWidth
        
        noseDogView.transform = CGAffineTransformIdentity
        noseDogView.frame = CGRectMake(centerNose.x - noseWidth / 2, (centerNose.y - noseWidth / 2) + 30, noseWidth, noseHeight)
        noseDogView.hidden = false
        processPoint.setAnchorPoint(CGPointMake(0.5, 1.0), forView: noseDogView)
        noseDogView.transform = CGAffineTransformMakeRotation(processPoint.processAngle(points[0], point2: points[6]))
        
        return (noseDogView)
    }
    
    /** TONGUE DOG **/
    
    func drawDogTongue(points: [CGPoint]) -> UIImageView {
        if (tongueDogView.image == nil) {
            let image = UIImage(named: "tongueDog.png")
            tongueDogView.image = image
        }
        
        let center = processPoint.processCenter(points[0], point2: points[7])
        let cornerDist = processPoint.processCornerDist(points[0], point2: points[7])
        let width = 2.0 * cornerDist
        let height = (tongueDogView.image!.size.height / tongueDogView.image!.size.width) * width
        
        tongueDogView.transform = CGAffineTransformIdentity
        tongueDogView.frame = CGRectMake(center.x - width / 2, center.y, width, height)
        tongueDogView.hidden = false
        processPoint.setAnchorPoint(CGPointMake(0.5, 1.0), forView: tongueDogView)
        tongueDogView.transform = CGAffineTransformMakeRotation(processPoint.processAngle(points[0], point2: points[6]))
        
        return (tongueDogView)
    }
    
    /** WATERFALL **/
    
    func drawWaterFall(points: [CGPoint]) -> UIImageView {
        
        if (waterFallView.image == nil) {
            let image = UIImage.gifWithName("waterFall")
            waterFallView.image = image
        }
        
        let center = processPoint.processCenter(points[0], point2: points[7])
        let cornerDist = processPoint.processCornerDist(points[0], point2: points[7])
        let width = 2.0 * cornerDist
        let height = (waterFallView.image!.size.height / waterFallView.image!.size.width) * width
        
        
        waterFallView.transform = CGAffineTransformIdentity
        waterFallView.frame = CGRectMake(center.x - width / 2, center.y, width, height)
        waterFallView.hidden = false
        processPoint.setAnchorPoint(CGPointMake(0.5, 1.0), forView: waterFallView)
        waterFallView.transform = CGAffineTransformMakeRotation(processPoint.processAngle(points[0], point2: points[6]))
        
        return (waterFallView)
    }

}
