//
//  CommentFeedTVC.swift
//  Feed
//
//  Created by Ali Houshmand on 7/23/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

import UIKit


class CommentFeedTVC: UITableViewController, UITextFieldDelegate {

// to post new comments
    var inputField = UITextField(frame: CGRectMake(10, 10, 160, 40))
    
// array of "new posts" with test entries -- do I need to make it mutable? NOPE.  var auto mutable
    var newPosts = ["Hello World","Another Sample Entry"]
    var userLabel = UILabel()
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        self.navigationController.navigationBarHidden = false

        
        
        self.view.backgroundColor = UIColor.whiteColor()
        
// to logout, action should a) "pop" view and b) clear URLSession
        
        var logout = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: "logOut")
        // didnt need to use Selector -- swift knows!
        self.navigationItem.leftBarButtonItem = logout
        
        userLabel.frame = CGRectMake(width/2-50, -3, 150, 50)
        var rootVC = self.navigationController.viewControllers[0] as RootViewController
        userLabel.text = "User: \(rootVC.inputUser.text)"
        
        self.navigationController.view.addSubview(userLabel)
        
// creating a header for the inputField
        var inputForm = UIView(frame: CGRectMake(0, 0, 320, 60))
        inputField.delegate = self
        inputField.placeholder = "New Input"
        inputField.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        inputForm.addSubview(inputField)
        self.tableView.tableHeaderView = inputForm

        
// post Button  
        
        var postComment = UIButton(frame: CGRectMake(inputField.frame.width+5, 10, 90, 40))
        postComment.setTitle("Post", forState: UIControlState.Normal)
        postComment.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        postComment.addTarget(self, action:Selector("postNew"), forControlEvents: UIControlEvents.TouchUpInside)
        inputForm.addSubview(postComment)
        
    
// pull Button -- this will need to pull comments from Feed, for now creating placeholder UI
        
        var pullComment = UIButton(frame: CGRectMake(inputField.frame.width+92, 10, 90, 40))
        pullComment.setTitle("Pull", forState: UIControlState.Normal)
        pullComment.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
        pullComment.addTarget(self, action:Selector("pullNew"), forControlEvents: UIControlEvents.TouchUpInside)
        inputForm.addSubview(pullComment)
        
// want the ability to delete posts, for now, it will delete local, not server side!
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
// added below to resign keyboard w/o having to submit
        var tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("tapScreen"))
        self.view.addGestureRecognizer(tap)
        self.navigationController.view.addGestureRecognizer(tap)
        
        
    }

    
    func tapScreen()
    {
        
        inputField.resignFirstResponder()
        
    }
    
    


    // CODE FOR POSTING POSTS
    
    func postNew()
    {
        
        if inputField.text == "" {
            
            return
            
            // need a way for user to cancel without entering anything (tapscreen gesture resign keyboard for example); will add if time permits
        
        }
        
        newPosts.insert(inputField.text, atIndex: 0) 

        // will need to insert code to post to Feed server; below documentation from API doc:
        
        var rootVC = self.navigationController.viewControllers[0] as RootViewController
       
        var request = NSMutableURLRequest(URL: NSURL(string: "https://bfapp-bfsharing.rhcloud.com/post"))
        
        rootVC.session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "POST"
        
        var params = ["username":rootVC.inputUser.text, "postText":inputField.text] as Dictionary
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = rootVC.session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
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

            }
            
            
            })
        
        task.resume()
        
        inputField.text = ""
        
        self.tableView.reloadData()
        
        inputField.resignFirstResponder()

        
    }
    
    
    // CODE FOR PULLING POSTS
    
    func pullNew()
    {
        
        println("pull selected")
       
        
            //request URL
            var urlPath = "https://bfapp-bfsharing.rhcloud.com/feed"
        
            var url: NSURL = NSURL(string: urlPath)
            var session = NSURLSession.sharedSession()
        
        
            // if i wanted to add a param for asOfDt, do I need to create a "request" class?  Consequently, would task = session.dataTaskWithRequest instead of URL?  dataTaskWithURL not built to pass param / serialized JSON
        
            var task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
                println("Task completed")
                if(error) {
                    // If there is an error in the web request, print it to the console
                    println(error.localizedDescription)
                }
                var err: NSError?
                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSArray  // changed from NSDictionary to NSArray since JSON data is an array of dictionaries
                if(err?) {
                    // If there is an error parsing JSON, print it to the console
                    println("JSON Error \(err!.localizedDescription)")
                }
                
                    println("jsonresult: \(jsonResult)")
                
                    println("count: \(jsonResult.count)")
                
               // need to enumerate jsonResult to pull "postText"
                
                
                
                
                
                // parsedJSON["boards"]![0]
                
                dispatch_async(dispatch_get_main_queue(), {


                //  self.newPosts.insert(jsonResult[0]["postText"], atIndex: 0)
                
                
                    })
                })
        
            task.resume()


        self.tableView.reloadData()
        
    }
    
    
    func logOut()
    
    {
        
        println("logout selected")
        
        // will need to insert code to a) pop view back to root and b) clear URL session
        // pop view code to go back to login
    
        self.navigationController.popViewControllerAnimated(true)
        
        var rootVC = self.navigationController.viewControllers[0] as RootViewController
        
        rootVC.session = nil
        
        rootVC.inputUser.text = nil
        
        rootVC.inputPW.text = nil
        
        rootVC.navigationController.navigationBarHidden = true
        
        userLabel.text = nil
    
        // below not working as intended, keyboard appears in RVC when popping back to root
        rootVC.view.endEditing(true)
        
    }
    
    
    
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!)
    {
        
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            newPosts.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
        }
    }
    
    override func tableView(tableView: UITableView!, moveRowAtIndexPath sourceIndexPath: NSIndexPath!, toIndexPath destinationIndexPath: NSIndexPath!)
    {
        
        var movedItem = newPosts[sourceIndexPath.row]
        newPosts.removeAtIndex(sourceIndexPath.row)
        newPosts.insert(movedItem, atIndex: destinationIndexPath.row)
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        postNew()
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return newPosts.count
        
       
        
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        
        // no dequeue reseusablecellwithidentifier=cell, is it still dequeue'ing?  no need to test cell == nil, init cell
        
        // will need to build a custome cell class to handle multiple items in cell (text, date, image, etc); build if time permits
        
        var cell = UITableViewCell()
        
        cell.textLabel.text = self.newPosts[indexPath.row]
        
        cell.backgroundColor = UIColor(white: 0.90, alpha: 1.0)
        
        // hardcoded avatar to test placement of default imageview that comes with UITableViewCellDefault style
        cell.imageView.image = UIImage(named: "007306d.jpg")
        
        return cell
        
        
        
    }

    
    override func prefersStatusBarHidden() -> Bool {return true}


  
}
