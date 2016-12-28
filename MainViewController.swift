//
//  MainViewController.swift
//  Layout
//
//  Created by dshs_student on 2016. 10. 6..
//  Copyright © 2016년 DGSW. All rights reserved.
//

import UIKit

var listHeader = ["2016년 12월 30일"]

var listSections = [0]

var listTitles = ["나르샤캠프 iOS반 어플 마무리"]
var listContents = ["나르샤 캠프 12월 초까지 프로젝트 끝내기"]
var listDeadLines = ["09:00"]
var listRealDeadLines = ["2016-12-30(금) 09:00까지"]
var listDeadLinesForBackGround = ["201612300900"]
var listCheck = [false]
var listImage = Array<UIImage>()
var listView = Array<UIView>()
var listNSDate = Array<NSDate>()

/*
 "abcde"[0] === "a"
 "abcde"[0...2] === "abc"
 "abcde"[2..<4] === "cd"
 */
extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = startIndex.advancedBy(r.startIndex)
        let end = start.advancedBy(r.endIndex - r.startIndex)
        return self[Range(start ..< end)]
    }
}

class MainViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    var checked:UIImage = UIImage(named: "com.png")!
    var notChecked:UIImage = UIImage(named: "notCom.png")!
    var searchController:UISearchController!
    
    var curDate:String?
    let noDataLabel = UILabel()
    var whiteRoundedView : UIView!
    var temp:Int = 0
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var flag = false;
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return listHeader.count
    }
    
/*    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }*/
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        /*let vw = UIView()
        vw.backgroundColor = UIColor.redColor()
        let label = UILabel()
        
        label.text = "   오늘"
        
        label.textColor = UIColor.whiteColor()
        
        return label*/
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        
        let label: UILabel = UILabel()
        
        let text = listHeader[section][6...listHeader[section].characters.count-1]
        
        print(text)
        
        label.text = text
        label.frame = CGRect(x: 10, y: 2, width: 100, height: 35)
        label.textColor = UIColor.whiteColor()
        view.addSubview(label)
        
        return view
    }
    
    
/*    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 5))
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: 150, height: 50))
        label.text = "오늘"
        label.textColor = UIColor.whiteColor()
        
        
        
        view.addSubview(label)
        
        return view
    }*/
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var ct = 0
        for(var i = 0; i < listSections.count; i+=1){
            if(listSections[i] == section){
                ct+=1
            }
        }
        return ct
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1",forIndexPath: indexPath) as! ListTableViewCell
        var row = 0
        
        for(var i = 0; i < listSections.count; i+=1){
            if listSections[i] < indexPath.section {
                row+=1
            }
        }
        
        row = row+indexPath.row
        cell.listTitle.text = listTitles[row]
        cell.listDeadLine.text = listDeadLines[row]
        if (listCheck[row] == true){
            cell.checkImg.setImage(checked, forState: .Normal)
            cell.checkImg.tag = temp
            temp+=1
            cell.checkImg.userInteractionEnabled = false
        }
        else{
            cell.checkImg.setImage(notChecked, forState: .Normal)
            cell.checkImg.tag = temp
            temp+=1
        }
        /*if flag == false {
            for(var i = 0; i < listView.count; i+=1){
                listView[i].removeFromSuperview()
            }
            listView.removeAll()
            flag = true
        }*/
        if row < listView.count{
            listView[row].removeFromSuperview()
        }
        
        if temp == listTitles.count {
            temp = 0
            flag = false
        }
        
        whiteRoundedView = UIView(frame: CGRectMake(10, 8, self.view.frame.size.width - 20, 45))
        
        whiteRoundedView.layer.backgroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1.0, 1.0, 1.0, 0.8])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSizeMake(-1, 1)
        whiteRoundedView.layer.shadowOpacity = 0.1
        
        if row < listView.count {
            listView[row] = whiteRoundedView
        } else {
            listView.append(whiteRoundedView)
        }
        
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
            if uid == "\(listTitles[row])\(listRealDeadLines[row])" {
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
        mainTableView.sectionHeaderHeight = 30
        
        let nsdate = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyyMMddHHmm"
        let date = formatter.dateFromString(listDeadLinesForBackGround[0])
        
        formatter.dateFormat = "YYYY년 MM월 dd일"
        curDate = formatter.stringFromDate(nsdate)
        listNSDate.append(date!)
        listView.append(UIView())
        //        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(MainViewController.Alert), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        flag = false
        mainTableView.reloadData()
        temp = 0
    }
    
    //<DetailViewPart>
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if segue.identifier == "sgDetail"{
            let cell = sender as! ListTableViewCell
            let indexPath = self.mainTableView.indexPathForCell(cell)
            let detailView = segue.destinationViewController as!
            DetailViewController
            var row = 0
            
            for(var i = 0; i < listSections.count; i+=1){
                if listSections[i] < indexPath?.section {
                    row+=1
                }
            }
            
            detailView.cur = row+(indexPath?.row)!
        }
        else if segue.identifier == "Main2QRReaderSegue"{
            let dest = segue.destinationViewController as! QRCodeReaderViewController
            dest.cur = sender?.tag
        }
    }
    //<DetailViewPart/>
}




