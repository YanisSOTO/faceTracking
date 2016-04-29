//
//  screenshotViewController.swift
//  MyFaceTracking
//
//  Created by Soto Yanis on 28/04/2016.
//  Copyright © 2016 Soto Yanis. All rights reserved.
//

import UIKit

class screenshotViewController: UIViewController {

    /* Core */
    @IBOutlet var screenshotView: UIImageView!
    var originalScreenshot = UIImageView()
    var toPass = UIImage()
    
    
    /* Draw part */
    var lastPoint:CGPoint!
    var isSwiping:Bool!
    var red:CGFloat!
    var green:CGFloat!
    var blue:CGFloat!
    
    /* Button */
    @IBOutlet var redButton: UIButton!
    @IBOutlet var blueButton: UIButton!
    @IBOutlet var greenButton: UIButton!
    @IBOutlet var yellowButton: UIButton!
    @IBOutlet var pinkButton: UIButton!
    
    override func viewDidLoad() {
        self.screenshotView.image = self.toPass
        super.viewDidLoad()
        originalScreenshot.image = toPass
        
        
        redButton.backgroundColor = UIColor.redColor()
        blueButton.backgroundColor = UIColor.blueColor()
        greenButton.backgroundColor = UIColor.greenColor()
        yellowButton.backgroundColor = UIColor.yellowColor()
        pinkButton.backgroundColor = UIColor.blackColor()
        
        red   = (0.0/255.0)
        green = (0.0/255.0)
        blue  = (0.0/255.0)
        
        redButton.layer.cornerRadius = 0.441 * redButton.bounds.size.width
        blueButton.layer.cornerRadius = 0.441 * blueButton.bounds.size.width
        greenButton.layer.cornerRadius = 0.441 * greenButton.bounds.size.width
        yellowButton.layer.cornerRadius = 0.441 * yellowButton.bounds.size.width
        pinkButton.layer.cornerRadius = 0.441 * pinkButton.bounds.size.width
        
    }
    /* Saving image */
    @IBAction func savePhoto(sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(screenshotView.image!, self, #selector(screenshotViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
        if error == nil {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    /* Sharing image */
    @IBAction func shareAction(sender: UIButton) {
        let myShare = "My photo"
        let image = screenshotView.image
        
        let shareVC: UIActivityViewController = UIActivityViewController(activityItems: [(image)!, myShare], applicationActivities: nil)
        self.presentViewController(shareVC, animated: true, completion: nil)

    }
    
    
    /* Draw on image */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        isSwiping = false
        if let touch = touches.first{
            lastPoint = touch.locationInView(screenshotView)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?){
        isSwiping = true;
        if let touch = touches.first{
            let currentPoint = touch.locationInView(screenshotView)
            UIGraphicsBeginImageContext(self.screenshotView.frame.size)
            self.screenshotView.image?.drawInRect(CGRectMake(0, 0, self.screenshotView.frame.size.width, self.screenshotView.frame.size.height))
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y)
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y)
            CGContextSetLineCap(UIGraphicsGetCurrentContext(),CGLineCap.Round)
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 9.0)
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(),red, green, blue, 1.0)
            CGContextStrokePath(UIGraphicsGetCurrentContext())
            self.screenshotView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?){
        if(!isSwiping) {
            // This is a single touch, draw a point
            UIGraphicsBeginImageContext(self.screenshotView.frame.size)
            self.screenshotView.image?.drawInRect(CGRectMake(0, 0, self.screenshotView.frame.size.width, self.screenshotView.frame.size.height))
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), CGLineCap.Round)
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 9.0)
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0)
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y)
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y)
            CGContextStrokePath(UIGraphicsGetCurrentContext())
            self.screenshotView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
    }

    @IBAction func undoAction(sender: UIButton) {
        screenshotView.image = originalScreenshot.image
    }
    
    
    /* BUtton color action */
    
    @IBAction func redAction(sender: UIButton) {
        red   = (255.0/255.0)
        green = (0.0/255.0)
        blue  = (0.0/255.0)
    }
    
    @IBAction func blueAction(sender: UIButton) {
        red   = (0.0/255.0)
        green = (0.0/255.0)
        blue  = (255.0/255.0)
    }
    
    @IBAction func greenAction(sender: UIButton) {
        red   = (0.0/255.0)
        green = (255.0/255.0)
        blue  = (0.0/255.0)
    }
    
    @IBAction func yellowAction(sender: UIButton) {
        red   = (255.0/255.0)
        green = (255.0/255.0)
        blue  = (0.0/255.0)
    }
  
    
    @IBAction func pinkAction(sender: UIButton) {
        red   = (0.0/255.0)
        green = (0.0/255.0)
        blue  = (0.0/255.0)
    }
}