//
//  AppDelegate.swift
//  ToDoList
//
//  Created by DGSW_TEACHER on 2016. 11. 5..
//  Copyright © 2016년 DGSW_TEACHER. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        return true
    }
    
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        let date = NSDate()
        let formatter = NSDateFormatter()
        let time = formatter.stringFromDate(date)
        print(time)
        //print("Background fetch executed \"Debug ->Simulate Background Fetch\"!!!")
        //completionHandler(UIBackgroundFetchResult.NewData)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        let now=NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd(EEE)"
        dateFormatter.locale = NSLocale(localeIdentifier: "ko_KR")
        dateFormatter.stringFromDate(now)
        //selecttime
        func DTPicker(sender:UIDatePicker)
        {
            
            let formatter = NSDateFormatter()
            formatter.dateFormat="yyyy-MM-dd(EEE)"
        }
        
        
        
        
        
        
        let app = UIApplication.sharedApplication()
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert], categories: nil)
        app.registerUserNotificationSettings(notificationSettings)
        let alertTime = NSDate().dateByAddingTimeInterval(15)
        let notifyAlarm = UILocalNotification()
        
      //  notifyAlarm.repeatInterval = NSCalendarUnit.Second
        //timeZone = NSTimeZone.defaultTimeZone()
        
        notifyAlarm.fireDate = alertTime
        notifyAlarm.timeZone = NSTimeZone.defaultTimeZone()
        notifyAlarm.alertBody = "alert"
        app.scheduleLocalNotification(notifyAlarm)
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Split view
}
