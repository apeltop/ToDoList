//
//  MainViewController.swift
//  Layout
//
//  Created by dshs_student on 2016. 10. 6..
//  Copyright © 2016년 DGSW. All rights reserved.
//

import UIKit

var listHeader: [String] = ["2016년 12월 30일"]

var listSections: [Int] = Array<Int>()

var listTitles: [String] = ["나르샤캠프 iOS반 어플 마무리"]
var listContents: [String] = ["나르샤 캠프 12월 초까지 프로젝트 끝내기"]
var listDeadLines: [String] = ["09:00"]
var listRealDeadLines: [String] = ["2016-12-30(금) 09:00까지"]
var listCheck: [Bool] = [false]
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
        if listHeader.count == 0 {
            return 1
        }
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
        if listHeader.count != 0 {
            var text = listHeader[section][6...listHeader[section].characters.count-1]
            
            print(text)
            
            if (listHeader[section] == curDate){
                text = "오늘"
            }
            
            label.text = text
            label.frame = CGRect(x: 10, y: 2, width: 100, height: 35)
            label.textColor = UIColor.whiteColor()
            view.addSubview(label)
        }
        
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
        
        whiteRoundedView.layer.backgroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1.0, 1.0, 1.0, 1.0])
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
            
            var row = 0
            for(var i = 0; i < listSections.count; i+=1){
                if listSections[i] < indexPath.section {
                    row+=1
                }
            }
            
            row = row+indexPath.row
            
            deleteNotification(row)
            
            listTitles.removeAtIndex(row)
            listContents.removeAtIndex(row)
            listDeadLines.removeAtIndex(row)
            listImage.removeAtIndex(row)
            listCheck.removeAtIndex(row)
            listRealDeadLines.removeAtIndex(row)
            listView[indexPath.row].removeFromSuperview()
            listView.removeAtIndex(row)
            listNSDate.removeAtIndex(row)
            
            var tf = true
            let rsec = listSections[row]
            listSections.removeAtIndex(row)
            
            for(var i = 0; i < listSections.count; i+=1){
                if listSections[i] == rsec {
                    tf = false;
                    break;
                }
            }
            
            mainTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
            let seconds = 0.3
            let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                
                if tf == true {
                    for(var i = 0; i < listSections.count; i+=1){
                        if rsec < listSections[i] {
                            listSections[i] -= 1
                        }
                    }
                    listHeader.removeAtIndex(rsec)
                    self.mainTableView.reloadData()
                }
            })
            
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
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(55.0/255.0), green: CGFloat(157.0/255.0), blue: CGFloat(174.0/255.0), alpha: 0.7)
        
        let image = UIImageView(image: UIImage(named: "wallpapaer.jpg"))
        listImage.append(UIImage(named: "listImageTempPlace.png")!)
        
        let nsdate = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd(EEE) HH:mm까지"
        let date = formatter.dateFromString(listRealDeadLines[0])
        
        formatter.dateFormat = "YYYY년 MM월 dd일"
        curDate = formatter.stringFromDate(nsdate)
        listNSDate.append(date!)
        listView.append(UIView())
        listSections.append(0)
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        self.navigationController?.navigationBar.hidden = false
        self.navigationItem.hidesBackButton = true
        
        mainTableView.tableFooterView = UIView(frame: CGRectZero)
        mainTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        mainTableView.backgroundView = image
        mainTableView.sectionHeaderHeight = 30
        

        //        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(MainViewController.Alert), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(animated: Bool) {

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




