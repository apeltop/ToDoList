//
//  AppDelegate.swift
//  ToDoList
//
//  Created by DGSW_TEACHER on 2016. 11. 5..
//  Copyright © 2016년 DGSW_TEACHER. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var NowTime = ""
    var window: UIWindow?
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        if(KOSession.isKakaoAccountLoginCallback(url)){
            return KOSession.handleOpenURL(url)
        }
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        if(KOSession.isKakaoAccountLoginCallback(url)){
            return KOSession.handleOpenURL(url)
        }
        return true
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
        
        var navigationBarAppearance = UINavigationBar.appearance()
        
        navigationBarAppearance.barTintColor = UIColor(red: CGFloat(55.0/255.0), green: CGFloat(157.0/255.0), blue: CGFloat(174.0/255.0), alpha: 0.7)
        navigationBarAppearance.tintColor = UIColor.whiteColor()
        
        navigationBarAppearance.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        // Override point for customization after application launch.
//        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        return true
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        KOSessionTask.storyPostTaskWithContent("\(notification.userInfo!["Title"]!)를 \(notification.userInfo!["SelectTime"]!)까지 미완료하였습니다.", permission: .OnlyMe, imageUrl: nil, androidExecParam: nil, iosExecParam: nil, completionHandler: nil)
        
        for (var i = 0; i < listTitles.count; i+=1){
            if listRealDeadLines[i] == "\(notification.userInfo!["SelectTime"]!)까지" {
                listCheck[i] = -1
                break;
            }
        }
        NSNotificationCenter.defaultCenter().postNotificationName("updateRoot", object: nil)
    }
    
//    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
////        let date = NSDate()
////        let formatter = NSDateFormatter()
////        let time = formatter.stringFromDate(date)
////        print(time)
//        //print("Background fetch executed \"Debug ->Simulate Background Fetch\"!!!")
//        //completionHandler(UIBackgroundFetchResult.NewData)
//    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        KOSession.handleDidBecomeActive()
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Split view
}
