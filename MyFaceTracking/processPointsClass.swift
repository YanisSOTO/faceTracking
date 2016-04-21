//
//  processPoints.swift
//  MyFaceTracking
//
//  Created by Soto Yanis on 21/04/2016.
//  Copyright © 2016 Soto Yanis. All rights reserved.
//

import UIKit


class ProcessPoints {

    func processCenter(point1: CGPoint, point2: CGPoint) -> CGPoint {
        let center = CGPointMake((point1.x + point2.x) / 2, (point1.y + point2.y) / 2)
        return (center)
    }

       func processCornerDist(point1: CGPoint, point2: CGPoint) -> CGFloat {
        let cornerDist = sqrt(pow(point1.x - point2.x, 2) + pow(point1.y - point2.y, 2))
        return (cornerDist)
    }
    
    func processAngle(point1: CGPoint, point2: CGPoint) -> CGFloat {
        let angle = atan2(point2.y - point1.y, point2.x - point1.x)
        return (angle)
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