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
    
// array of "new posts" with test entries -- do I need to make it mutable?
    var newPosts = ["Hello World","Another Sample Entry"]


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
 
// to logout, right now there is no "selector" to a) "pop" view and b) clear URLSession (need to build)
        
        var logout = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: "logOut")
            // didnt need to use Selector -- swift knows!
        
        self.navigationItem.leftBarButtonItem = logout
        
        
// creating a header for the inputField
        var inputForm = UIView(frame: CGRectMake(0, 0, 320, 60))
        inputField.delegate = self
        inputField.placeholder = "New Input"
        inputField.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        inputForm.addSubview(inputField)
        self.tableView.tableHeaderView = inputForm

        
// post Button -- this will need to post locally and push to Feed server, for now creating UI and func for local post
        
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
        

    }

    
    func postNew()
    {
        
        if inputField.text == "" {
            
            return
            
            // need a way for user to cancel without entering anything (tapscreen gesture resign keyboard for example); will add if time permits
            

        }
        
        newPosts.insert(inputField.text, atIndex: 0) // really odd using conv methods like this
        
        inputField.text = ""
        
        self.tableView.reloadData()
        
        inputField.resignFirstResponder()
        
        println(inputField.text)
        
        // will need to insert code to post comments to Feed server
        
    }
    
    func pullNew()
    {
        
        println("pull selected")
        // will need to insert code to a) pull comments from Feed server and b) fill out TVC / reload data
        
    }
    
    
    func logOut()
    
    {
        
        
        println("logout selected")
        
        // will need to insert code to a) pop view back to root and b) clear URL session
        
        // pop view code to go back to login
        
        self.navigationController.popViewControllerAnimated(true)

    
        
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
        
        // newPosts will need to include posts pulled from Feed from other users, will need to modify array accordingly for full functionality
        
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        
        // no dequeue reseusablecellwithidentifier=cell, is it still dequeue'ing?  no need to test cell == nil, init cell
        
        // will need to build a custome cell class to handle multiple items in cell (text, date, image, etc); build if time permits
        
        var cell = UITableViewCell()
        cell.textLabel.text = self.newPosts[indexPath.row]
        cell.backgroundColor = UIColor(white: 0.90, alpha: 1.0)
        return cell
        
        
        
    }

    
    override func prefersStatusBarHidden() -> Bool {return true}


  
}
