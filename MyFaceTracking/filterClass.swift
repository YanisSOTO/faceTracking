//
//  filterClass.swift
//  MyFaceTracking
//
//  Created by Soto Yanis on 20/04/2016.
//  Copyright © 2016 Soto Yanis. All rights reserved.
//

import UIKit

class Filter {
    
    var eyeLeftView = UIImageView()
    var eyeRightView = UIImageView()

    
    func drawHearthLeft(points: [CGPoint]) -> UIImageView {
        let image = UIImage(named: "coeur.png")
        
        eyeLeftView.image = image
        let centerEye = CGPointMake((points[0].x + points[5].x) / 2, (points[0].y + points[5].y) / 2)
        let eyeCornerDist = sqrt(pow(points[0].x - points[5].x, 2) + pow(points[0].y - points[5].y, 2))
        let eyeWidth = 2.0 * eyeCornerDist
        let eyeHeight = (eyeLeftView.image!.size.height / eyeLeftView.image!.size.width) * eyeWidth
        eyeLeftView.transform = CGAffineTransformIdentity
        eyeLeftView.frame = CGRectMake(centerEye.x - eyeWidth / 2, centerEye.y - eyeWidth / 2, eyeWidth, eyeHeight)
        eyeLeftView.hidden = false
        setAnchorPoint(CGPointMake(0.5, 1.0), forView: eyeLeftView)
        let angle = atan2(points[5].y - points[0].y, points[5].x - points[0].x)
        eyeLeftView.transform = CGAffineTransformMakeRotation(angle)
        return (eyeLeftView)
    }
    
    
    func drawHearthRight(points: [CGPoint]) -> UIImageView {
        let image = UIImage(named: "coeur.png")
        
        eyeRightView.image = image
        let centerEye = CGPointMake((points[0].x + points[5].x) / 2, (points[0].y + points[5].y) / 2)
        let eyeCornerDist = sqrt(pow(points[0].x - points[5].x, 2) + pow(points[0].y - points[5].y, 2))
        let eyeWidth = 2.0 * eyeCornerDist
        let eyeHeight = (eyeRightView.image!.size.height / eyeRightView.image!.size.width) * eyeWidth
        eyeRightView.transform = CGAffineTransformIdentity
        eyeRightView.frame = CGRectMake(centerEye.x - eyeWidth / 2, centerEye.y - eyeWidth / 2, eyeWidth, eyeHeight)
        eyeRightView.hidden = false
        setAnchorPoint(CGPointMake(0.5, 1.0), forView: eyeRightView)
        let angle = atan2(points[5].y - points[0].y, points[5].x - points[0].x)
        eyeRightView.transform = CGAffineTransformMakeRotation(angle)
        
        return (eyeRightView)
    }
    
    
    func setAnchorPoint(anchorPoint: CGPoint, forView view: UIView) {
        var newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y)
        newPoint = CGPointApplyAffineTransform(newPoint, view.transform)
        oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform)
        var position = view.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        position.y -= oldPoint.y
        position.y += newPoint.y
        view.layer.position = position
        view.layer.anchorPoint = anchorPoint
    }

}
