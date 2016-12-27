//
//  MainViewController.swift
//  Layout
//
//  Created by dshs_student on 2016. 10. 6..
//  Copyright © 2016년 DGSW. All rights reserved.
//

import UIKit

var listTitles = ["나르샤캠프 iOS반 어플 마무리"]
var listContents = ["나르샤 캠프 12월 초까지 프로젝트 끝내기"]
var listDeadLines = ["09:00"]
var listDeadLinesForBackGround = ["201612310900"]
var listCheck = [false]
var listImage = Array<UIImage>()
var listView = Array<UIView>()

class MainViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    
    var searchController:UISearchController!
    
    let noDataLabel = UILabel()
    var whiteRoundedView : UIView!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var flag = false;
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTitles.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1",forIndexPath: indexPath) as! ListTableViewCell
        cell.listTitle.text = listTitles[indexPath.row]
        cell.listDeadLine.text = listDeadLines[indexPath.row]
        if (listCheck[indexPath.row] == true){
            cell.listCheck.text = "완료"
        }
        else{
            cell.listCheck.text = "미완료"
        }
        if flag == false {
            for(var i = 0; i < listView.count; i+=1){
                listView[i].removeFromSuperview()
            }
            listView.removeAll()
            flag = true
        }
        
        whiteRoundedView = UIView(frame: CGRectMake(10, 8, self.view.frame.size.width - 20, 45))
        
        whiteRoundedView.layer.backgroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1.0, 1.0, 1.0, 0.7])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSizeMake(-1, 1)
        whiteRoundedView.layer.shadowOpacity = 0.1
        
        listView.append(whiteRoundedView)
        
        cell.contentView.addSubview(whiteRoundedView!)
        cell.contentView.sendSubviewToBack(whiteRoundedView!)
        cell.contentView.backgroundColor = UIColor.clearColor()
        cell.backgroundColor = UIColor.clearColor()
        /*cell.backgroundColor = UIColor.whiteColor()
         cell.layer.borderWidth = 1
         cell.layer.borderColor = UIColor.clearColor().CGColor
         cell.layer.cornerRadius = 8
         cell.clipsToBounds = true*/
        return cell
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            KOSessionTask.storyPostNoteTaskWithContent("저는 \(listDeadLines[indexPath.row])까지 할 일이였던 \(listTitles[indexPath.row])을(를) 취소하였습니다.", permission: KOStoryPostPermission.OnlyMe, sharable: false, androidExecParam: nil, iosExecParam: nil, completionHandler: nil)
            
            deleteNotification(indexPath.row)
            
            listTitles.removeAtIndex(indexPath.row)
            listContents.removeAtIndex(indexPath.row)
            listDeadLines.removeAtIndex(indexPath.row)
            listImage.removeAtIndex(indexPath.row)
            listCheck.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        }
    }
    
    func deleteNotification(row:Int) {
        let app:UIApplication = UIApplication.sharedApplication()
        
        for oneEvent in app.scheduledLocalNotifications! {
            let notification = oneEvent as UILocalNotification
            let userInfoCurrent = notification.userInfo! as! [String:AnyObject]
            let uid = userInfoCurrent["UUID"]! as! String
            if uid == "\(listTitles[row])\(listDeadLines[row])" {
                //Cancelling local notification
                app.cancelLocalNotification(notification)
                break;
            }
        }
    }
    
    
    //    func Alert(){
    //        let Now = NSDate()
    //        let formatter = NSDateFormatter()
    //        formatter.dateFormat = "yyyyMMddHHmm"
    //        let NTime = formatter.stringFromDate(Now)
    //
    //        let app = UIApplication.sharedApplication()
    //        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert], categories: nil)
    //        app.registerUserNotificationSettings(notificationSettings)
    //        let alertTime = NSDate().dateByAddingTimeInterval(0)
    //        let notifyAlarm = UILocalNotification()
    //
    //        notifyAlarm.fireDate = alertTime
    //        notifyAlarm.timeZone = NSTimeZone.defaultTimeZone()
    //        notifyAlarm.alertBody = "Alert"
    //
    //        for item in listDeadLinesForBackGround{
    //            if (NTime >= item){
    //                app.scheduleLocalNotification(notifyAlarm)
    //            }
    //        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImageView(image: UIImage(named: "wallpapaer.jpg"))
        listImage.append(UIImage(named: "listImageTempPlace.png")!)
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        self.navigationController?.navigationBar.hidden = false
        self.navigationItem.hidesBackButton = true
        
        mainTableView.tableFooterView = UIView(frame: CGRectZero)
        mainTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        mainTableView.backgroundView = image
        //        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(MainViewController.Alert), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        flag = false
        mainTableView.reloadData()
    }
    
    //<DetailViewPart>
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "sgDetail"{
            let cell = sender as! UITableViewCell
            let indexPath = self.mainTableView.indexPathForCell(cell)
            let detailView = segue.destinationViewController as!
            DetailViewController
            
            detailView.cur = indexPath!.row
        }
    }
    //<DetailViewPart/>
}




