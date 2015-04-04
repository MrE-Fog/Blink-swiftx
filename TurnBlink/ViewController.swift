//
//  ViewController.swift
//  TurnBlink
//
//  Created by Sergey Yuryev on 02/04/15.
//  Copyright (c) 2015 snyuryev. All rights reserved.
//

let kStatusKey : String = "status"
let kStatusURLString : String = "http://salty.local:8888/status"
let kLightURLString : String = "http://salty.local:8888/light"

import UIKit

class ViewController: UIViewController {

    private var status: Bool = false
    
    lazy private var activityIndicator : CustomActivityIndicatorView = {
        let image : UIImage = UIImage(named: "loading")!
        return CustomActivityIndicatorView(image: image)
    }()
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var turnButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        preload()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func turn(sender: AnyObject) {
        let url = NSURL(string: kLightURLString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in

            self.status = !self.status
            
            dispatch_async(dispatch_get_main_queue(), {
                self.changeStatus(self.status)
            });
        }
        
        task.resume()
    }
    
    func preload () {
        addLoadingIndicator()
        
        showLoadingIndicator()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.status = self.getStatus()
            dispatch_async(dispatch_get_main_queue(), {
                self.changeStatus(self.status)
                self.hideLoadingIndicator()
            });
        });
    }
    
    func addLoadingIndicator () {
        self.view.addSubview(activityIndicator)

        activityIndicator.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        var constX = NSLayoutConstraint(item: activityIndicator, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0)
        view.addConstraint(constX)
        
        var constY = NSLayoutConstraint(item: activityIndicator, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0)
        view.addConstraint(constY)
        
        var constW = NSLayoutConstraint(item: activityIndicator, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 28)
        activityIndicator.addConstraint(constW)

        var constH = NSLayoutConstraint(item: activityIndicator, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 28)
        activityIndicator.addConstraint(constH)
    }
    
    func showLoadingIndicator () {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.loadingView.hidden = false
        })
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator () {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.loadingView.hidden = true
        })
        activityIndicator.stopAnimating()
    }
    
    func getStatus () -> Bool {
        var url: NSURL = NSURL(string: kStatusURLString)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        var error: NSErrorPointer = nil
        var dataVal: NSData =  NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error:nil)!
        var err: NSError

        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        if let status = jsonResult[kStatusKey] as? String {
            return status.toBool()
        }
        
        return false
    }
    
    func changeStatus (status: Bool) {
        // On
        if (status) {
            view.backgroundColor = UIColor.whiteColor()
            turnButton.setImage(UIImage(named:"light-bulb-10.png"), forState: .Normal)
        }
        // Off
        else {
            view.backgroundColor = UIColor.blackColor()
            turnButton.setImage(UIImage(named:"light-bulb-10-2.png"), forState: .Normal)
        }
    }

}

