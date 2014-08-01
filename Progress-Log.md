Feed
====

##Progress Log

###**A: Planning**
*Completed Wednesday July 23* |  *1 hour spent* 
> 1 hour reviewing materials, docs provided 

####Issues/Comments:
 * Sent planning email to Blake and team July 23; no further issues

###**B: The Basics - Hour 2 - 5**
*STARTED Thursday July 24 - STOPPED Saturday July 26* | *5 hours spent*
> * Build basic UI elements of a login screen (view controller with nav) which pushes to a comment view (a simple tableviewcontroller)
> * Run a GET test to see if I can communicate with web API ((https://bfapp-bfsharing.rhcloud.com/test)
> * Run a POST for login (https://bfapp-bfsharing.rhcloud.com/login) 

####Issues/Comments sorted by file:
AppDelegate.swift
 * Code written to launch to RVC with a navcontroller

RootViewController.swift (the login screen)
 * Completed basic login screen with Username, PW, and Submit, which then pushes to a TVC (comment feed)
 * Need to make the transition to TVC subsequent to successful login (need a completion handler)
 * Skipped the GET, went straight to POST for login; login successful for Test1,2,3 etc; will need "logout" code in TVC
 * Since init'ng with nav, RVC displays navbar, but is not needed until next View; will hide "navbar" from RootViewController at clean-up stage

CommentsViewTVC.swift (feed view)
 * Built basic TVC with ability to post local comments; placeholder buttons built for Logout, Post, Pull; note: Post only inserts text to local feed at the moment
 * added ability to edit / swipe delete entries but this only works locally 
 * There are comments sprinkled throughout to denote further work required most of these are related to TBD's re: API calls
 * Using built-in "tableviewcell" with in tableviewcontroller class for now; project really needs a custom table view cell class (file) in order to handle multiple elements within cell (i.e. comment, date, image, time, etc); if time permits, build custom TVCell

#####*Chief open items from this work element: a) logout, b) nav completion handler, and c) custom cell*


###C: API Linkage -  Hour 5-14 


> * Work down the list of API calls (GET comments, GET users, POST comments, etc) as best I can 
> * I envision needing the most assistance with this task and have budgeted most of my time here accordingly

*STARTED Tuesday July 29* | *3 hours spent*

####Issues/Comments sorted by file:
RootViewController.swift
* fixed a) logout and b) nav completion handler (open items from Part B)

CommentsViewTVC.swift
* started work on post new comments to feed, successful post sent to feed
* started work on pulling feed thread, App crashing, left as open item

#####*Chief open items from this work element: fix pull feed function*

*STARTED Tuesday July 31* | *5 hours spent*

CommentsViewTVC.swift
* researched app crash and JSON / API calls
* able to get download feed and displayed in console
* worked on getting jsonResult into TVC

#####*Chief open items from this work element: get pulled data into TVC*

###D: UICleanup - Hour 14 - 15 
> * if time remains, clean up UI, make pretty, test for bugs

*STARTED Tuesday July 31* | *1 hours spent*

* added a tapscreen gesture recognizer to dismiss keyboard
* used most of the time to research further how to load the jsonResult into TVC

#####*Chief open items from this work element: unable to get pulled feed data into TVC*

