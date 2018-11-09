//
//  AppDelegate.swift
//  Todoey
//
//  Created by Activelink on 04/11/2018.
//  Copyright © 2018 Ann Adaya. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//**** This is the place that gets called when your app gets loaded up so it doesnt matter if the rest of your app is gonna crash -- this is the first thing that happens and this happens before the viewdidload inside the firstViewController or the initial viewcontroller. ***1 --- This will print out or happens at the moment when your app first loads up
      /* because we will no longer needed this, we will comment it out because this is just to test the timing of our backend
        print("didFinishLaunchingWithOptions")
       */
        
    //here we're gonna write a little bit of code in order to print our the path for our userDefault file.
      
        //dont worry so much about this line, we are just using this to print and prove taht our data has been saved somewhere even though its not showing up. And as long as our app launches, we can see in our console the file path, and we can use that file path to go into our finder and try and locate this peerless file that stores our data --- MacintoshHD > Users > username > library > developer >coresimulator > devices > filenamenumbersFromTheConsole which is the deviceid -- and it identifies our device uniquely so that it could be all simulated device or it could be a physical device -- so in our example this id corresponds to our current simulator > data > containers > data > application > ID again that refers to this unique ID of our Todoey App that we've launch earlier on where we save our data. (E50...) so here's our app sandbox, and once youve gotten here youre going to look inside > library > preferences > and now finally, you get to your plist (com.londoappbrewery.Todoey.plist) and if we double click on it, it will open by default inside Xcode and youll see that we ahve this key that we used earlier on where we said save it under the key todolistarray (forkey: "TodoListArray") and the value is an array -- so swift is clever enough to figure out that our item the data type was an array data type if we exapnd this, we can see our updated items including the last one we added that is not showing in our UI application which in fact was saved, so why is it not showing up in our tableview? well its because we havent used it to retrieve the data -- so all we need to do in order to retreive our data is we can go into viewdidload and we can set our 
//        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        
        return true
    }

//**** And the next thing that gets called is this one which is applicationwillresignactive -- and this tends to get triggered when say something happens to the phone while the app is open -- i.e in the foreground. Like if the user receives a call. This is the method where you can do something to prevent the use of losing data. For example, say if they were filling in a form in your app and in the middle of it they get a call. And if it will be really annoying if by the time they get back to the app, the app actually been terminated -- and they've lost all of their data.
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

//***2 --- And then the next thing is if we press the home button your application goes into the background -- similarly if we double click the home button and go to a different app, your applicationa lso enters the background because its no longer the thing you ee on the screen
    
//*** Now this is another one that we're going to look at today --- this applicationdidenterbackground and this happens when your app disappears off the screen. Like when you press the home button, or when you open up a different app, its like a deck of card, there's another card that's being placed on top of the deck, so your app is no longer visible and its entered the background.
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

//***3 --- and the next thing is how the application gets terminated, this can happen bcause the operating system triggers it because it needs to reclaim those resources that precious memory or the user might trigger themselves by force quitting your app.
    
//*** Now the other one that is super important is the application will terminate -- and this is the point where basically your app is going to be terminated. Now this can be user triggered or it cn be system triggered--- so say if the user has pressed the home button to quit your app and they decide to go into a different app--- if this app happens to be a really resource intensive app say a game like hot stone or something then it might reclaim a lot of the resources that are being hogged by your app. Even though its in the background it might still have proceses that are running and is using up the precios memory of the iphone --- so in those cases when the resources gets reclaimed from your app then it goes from being in the background to being terminated or assassinated basically by the operating system.
    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate")
    }


}

