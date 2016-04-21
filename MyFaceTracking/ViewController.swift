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
    
    /* State filter */
    var stateFilter = 0
    
    /* View for Filter */
    var leftEyeView = UIImageView()
    var rightEyeView = UIImageView()
    var noseDogView = UIImageView()
    /* End */
    
    /* Boutlet from MainStoryBoard */
    @IBOutlet var faceTrackerContainerView: UIView!
    @IBOutlet var swapButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    /* End */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton()
        
       // let gifos = UIImage.gifWithName("giphy")
        //testIM.image = gifos
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
            switch self.stateFilter {
            case 0:
                leftEyeView = filter.drawHearthLeft(points.leftEye)
                self.view.addSubview(leftEyeView)
                rightEyeView = filter.drawHearthRight(points.rightEye)
                self.view.addSubview(rightEyeView)
            case 1:
                hideAllView()
                noseDogView = filter.drawDogNose(points.nose)
                self.view.addSubview(noseDogView)
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
    }
    
    /* Simple Swap camera */
    @IBAction func swapAction(sender: UIButton) {
        faceTrackerViewController!.swapCamera()
    }
    
    
    /* Create Button and fill it && Action button */
    func createButton() {
        let imageArray = fillImageArray()
        for index in 0..<2 {
            let frame1 = CGRect(x: (self.view.frame.size.width / 2) + CGFloat(index * 70), y: 0, width: 55, height: 55 )
            let button = UIButton(frame: frame1)
            button.setImage(imageArray[index], forState: .Normal)
            button.tag = index
            button.addTarget(parentViewController, action: #selector(ViewController.buttonClicked(_:)), forControlEvents: .TouchUpInside)
            self.scrollView.addSubview(button)
        }
        self.scrollView.contentSize = CGSizeMake(600, 0) //Have to change it Later
    }
    
    func buttonClicked(sender:UIButton)
    {
        let tag = sender.tag
        switch tag {
        case 0:
            self.stateFilter = 0
        case 1:
            self.stateFilter = 1
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