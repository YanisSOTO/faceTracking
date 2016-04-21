//
//  ViewController.swift
//  MyFaceTracking
//
//  Created by Soto Yanis on 15/04/2016.
//  Copyright © 2016 Soto Yanis. All rights reserved.
//

import UIKit
import FaceTracker
import SwiftGifOrigin


class ViewController: UIViewController, FaceTrackerViewControllerDelegate, UIScrollViewDelegate {
    /* FaceTrackerProtocol */
    weak var faceTrackerViewController: FaceTrackerViewController?
    
    let filter = Filter()
    
    @IBOutlet var test: UIImageView!
    /* State filter */
    var stateFilter = 0
    
    /* View for Filter */
    var leftEyeView = UIImageView()
    var rightEyeView = UIImageView()
    var noseDogView = UIImageView()
    var tongueDogView = UIImageView()
    var waterFallView = UIImageView()
    /* End */
    
    /* Boutlet from MainStoryBoard */
    @IBOutlet var faceTrackerContainerView: UIView!
    @IBOutlet var swapButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    /* End */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        faceTrackerViewController!.startTracking { () -> Void in
        }
    }
    
       
    func faceTrackerDidUpdate(points: FacePoints?) {
        if let points = points {
            hideAllView()
            switch self.stateFilter {
            case 0:
                leftEyeView = filter.drawHeart(points.leftEye, side: "left")
                self.view.addSubview(leftEyeView)
                rightEyeView = filter.drawHeart(points.rightEye, side: "right")
                self.view.addSubview(rightEyeView)
            case 1:
                noseDogView = filter.drawDogNose(points.nose)
                self.view.addSubview(noseDogView)
                if ((points.outerMouth[10].y - points.outerMouth[2].y) > 60) {
                    tongueDogView = filter.drawDogTongue(points.outerMouth)
                    self.view.addSubview(tongueDogView)
                }
            case 2:
                if ((points.outerMouth[10].y - points.outerMouth[2].y) > 60) {
                    waterFallView = filter.drawWaterFall(points.outerMouth)
                    self.view.addSubview(waterFallView)
                }

            default:
                print("No state")
            }
        }
        else {
            hideAllView()
        }
    }
    
    
    func hideAllView() {
        leftEyeView.hidden = true
        rightEyeView.hidden = true
        noseDogView.hidden = true
        tongueDogView.hidden = true
        waterFallView.hidden = true
    }
    
    /* Simple Swap camera */
    @IBAction func swapAction(sender: UIButton) {
        faceTrackerViewController!.swapCamera()
    }
    
    
    /* Create Button and fill it && Action button */
    func createButton() {
        let imageArray = fillImageArray()
        var lastButtonWidth: CGFloat = 0

        
        for index in 0..<4 {
            let frame1 = CGRect(x: ((self.view.frame.size.width / 2) - 27.5) + CGFloat(index * 70), y: 0, width: 55, height: 55 )
            let button = UIButton(frame: frame1)
            button.setImage(imageArray[index], forState: .Normal)
            button.tag = index
            button.addTarget(parentViewController, action: #selector(ViewController.buttonClicked(_:)), forControlEvents: .TouchUpInside)
            self.scrollView.addSubview(button)
            lastButtonWidth = frame1.origin.x
        }
        self.scrollView.contentSize = CGSizeMake(lastButtonWidth + 55, 0)
    }
    
    func buttonClicked(sender:UIButton)
    {
        let tag = sender.tag
        switch tag {
        case 0:
            self.stateFilter = 0
        case 1:
            self.stateFilter = 1
        case 2:
            self.stateFilter = 2
        default:
            print("No button selected")
        }
    }
    
    
    /* Segue */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "faceTrackerEmbed") {
            faceTrackerViewController = segue.destinationViewController as? FaceTrackerViewController
            faceTrackerViewController!.delegate = self
        }
    }
}