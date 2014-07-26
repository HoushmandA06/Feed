Feed
====

##Progress Log

###**A: Planning**
*Completed Wednesday July 23* |  *1 hour spent* 
- 1 hour reviewing materials, docs provided 

Issues/Comments:
- Sent planning email to Blake and team July 23,


###**B: The Basics - Hour 2 - 5**
*STARTED Thursday July 24 - STOPPED Saturday July 26* | *5 hours spent*
- Build basic UI elements of a login screen (view controller with nav) which pushes to a comment view (a simple tableviewcontroller)
- Run a GET test to see if I can communicate with web API ((https://bfapp-bfsharing.rhcloud.com/test)
- Run a POST for login (https://bfapp-bfsharing.rhcloud.com/login) 

Issues/Comments sorted by file:
- RootViewController.swift (the login screen)
-*Completed basic login screen with Username, PW, and Submit, which then pushes to a TVC (comment feed)
*Need to make the transition to TVC subsequent to successful login (need a completion handler)
*Skipped the GET, went straight to POST for login; login successful for Test1,2,3 etc

- CommentsViewTVC
--- Built vasic TVC with ability to post local comments built; placeholder buttons built for Logout, Post, Pull; note: Post only inserts text to local feed at the moment
--- there are comments sprinkled throughout to denote further work required most of these are related to TBD's re: API calls
--- Using built-in "tableviewcell" for now; project really needs a custom table view cell class (file) in order to handle multiple elements within cell (i.e. comment, date, image, time, etc); if time permits, build custom TVCell

*Chief unresolved issues from this work element: a) logout, b) nav completion handler, and c) custome cell*



Will Begin Below Tuesday at BlueFletch Office
###C: API Linkage -  Hour 5-14 (have not started)
- Work down the list of API calls (GET comments, GET users, POST comments, etc) as best I can 
- I envision needing the most assistance with this task and have budgeted most of my time here accordingly

###D: UICleanup - Hour 14 - 15 (have not started)
- if time remains, clean up UI, make pretty, test for bugs



