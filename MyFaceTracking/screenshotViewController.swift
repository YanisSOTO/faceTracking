//
//  screenshotViewController.swift
//  MyFaceTracking
//
//  Created by Soto Yanis on 28/04/2016.
//  Copyright © 2016 Soto Yanis. All rights reserved.
//

import UIKit

class screenshotViewController: UIViewController {

    @IBOutlet var screenshotView: UIImageView!
    var toPass = UIImage()
    
    override func viewDidLoad() {
        self.screenshotView.image = self.toPass
        super.viewDidLoad()
    }
    
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
}