//
//  RootViewController.swift
//  Feed
//
//  Created by Ali Houshmand on 7/23/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

import UIKit


let width = UIScreen.mainScreen().bounds.size.width
let height = UIScreen.mainScreen().bounds.size.height



class RootViewController: UIViewController, UITextFieldDelegate {
    

    var inputUser = UITextField(frame: CGRectMake(10, 100, width - 20, 40))
    var inputPW = UITextField(frame: CGRectMake(10, 150, width - 20, 40))
    var session = NSURLSession.sharedSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var titleImage = UIImageView(image: UIImage(named: "normallogoweb.png"))
        titleImage.frame = CGRectMake(width/2-50, self.navigationController.navigationBar.frame.height+6, 100, 40)
        self.view.addSubview(titleImage)
        
        self.navigationController.navigationBarHidden = true
        
        // custom colors sampled from BlueFletch Logo website using DevBox
        // [UIColor colorWithRed:0.431f green:0.788f blue:0.922f alpha:1.0f]
        // [UIColor colorWithRed:0.431f green:0.788f blue:0.922f alpha:1.0f]
        // [UIColor colorWithRed:0.133f green:0.196f blue:0.459f alpha:1.0f]
        
// setting up input textfields
        
        inputUser.backgroundColor = UIColor(red: 0.431, green: 0.788, blue: 0.922, alpha: 0.9)
        inputUser.placeholder = "username"
        inputUser.layer.cornerRadius = 4
        inputUser.leftView = UIView(frame:CGRectMake(0, 0, 10, 0))
        inputUser.leftViewMode = UITextFieldViewMode.Always
        inputUser.delegate = self
        inputUser.resignFirstResponder()
        
        inputPW.backgroundColor = UIColor(red: 0.431, green: 0.788, blue: 0.922, alpha: 0.9)
        inputPW.secureTextEntry = true
        inputPW.layer.cornerRadius = 4
        inputPW.leftView = UIView(frame:CGRectMake(0, 0, 10, 0))
        inputPW.leftViewMode = UITextFieldViewMode.Always
        inputPW.placeholder = "password"
        inputPW.delegate = self
        inputPW.resignFirstResponder()
    
        var login = UIButton(frame: CGRectMake(10,200,width - 20,40))
        login.backgroundColor = UIColor(red: 0.133, green: 0.196, blue: 0.459, alpha: 1.0)
        login.layer.cornerRadius = 4
        login.setTitle("submit", forState: UIControlState.Normal)
        login.addTarget(self, action:Selector("submit"), forControlEvents: UIControlEvents.TouchUpInside)

   
        // added below to resign keyboard w/o having to submit
        var tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("tapScreen"))
        self.view.addGestureRecognizer(tap)
    
        
        self.view.addSubview(login)
        self.view.addSubview(inputUser)
        self.view.addSubview(inputPW)
        
    }

    
    func tapScreen()
    {
    
        inputUser.resignFirstResponder()
        inputPW.resignFirstResponder()
    
    }
    
    
    
    func submit()
    {
        if (inputUser.text == "" || inputPW.text == "") {
            
            println("missing field info")
            
            // LOOKS LIKE BELOW DEPRECATED FOR iOS8, USE UIALERTCONTROLLER IF TIME PERMITS
            var alertView = UIAlertView();
            alertView.addButtonWithTitle("Try Again");
            alertView.title = "Error";
            alertView.message = "Missing Field Info";
            alertView.show();
        
            return
            
        }
        

// code for a) POST login to API and if successful, then b) push to TVC (comment view)
        
        // a) POST
        
            // got the snippet below from reading this tutorial http://jamesonquave.com/blog/making-a-post-request-in-swift/
        

        var request = NSMutableURLRequest(URL: NSURL(string: "https://bfapp-bfsharing.rhcloud.com/login"))
        
        // made session global, to be used in TVC when making addl API calls
        session = NSURLSession.sharedSession()
    
        request.HTTPMethod = "POST"
        
        var params = ["username":inputUser.text, "password":inputPW.text] as Dictionary // dont need "as Dictionary" swift recognizes as dictionary once key/value pairs entered, var mutable by default also
        
    
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as NSDictionary
            
            if(err) {
                println(err!.localizedDescription)
            }
            else {

                println("Success")
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    // app crashed until I put dispatch block to get nav push on main queue
                    
                    let commentsView : CommentFeedTVC = CommentFeedTVC(style: UITableViewStyle.Plain)
                    self.navigationController.pushViewController(commentsView, animated: false)
                    
                    
                    })
                
            }
   

            })
        
        task.resume()
        

 
    }
    
    

    
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        textField.resignFirstResponder()
        return true
   
    
    
    }
    
    
    
    override func prefersStatusBarHidden() -> Bool {return true}
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}
