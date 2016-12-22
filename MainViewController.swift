//
//  MainViewController.swift
//  Layout
//
//  Created by dshs_student on 2016. 10. 6..
//  Copyright © 2016년 DGSW. All rights reserved.
//

import UIKit

var listTitles = ["나르샤캠프 iOS반 어플 마무리짓기"]
var listContents = ["나르샤 캠프 12월 초까지 프로젝트 끝내기"]
var listDeadLines = ["2016-12-31(Fri) 09:00까지"]
var listDeadLinesForBackGround = ["201612310900"]

class MainViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    
    var searchController:UISearchController!
    
    let noDataLabel = UILabel()
    
    @IBAction func Search(sender: AnyObject) {
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        presentViewController(searchController, animated: true, completion: nil)
    }
    @IBOutlet weak var mainTableView: UITableView!
    
    
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
        cell.listImageView = nil
        return cell
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            KOSessionTask.storyPostNoteTaskWithContent("저는 \(listDeadLines[indexPath.row])까지 할 일이였던 \(listTitles[indexPath.row])을(를) 취소하였습니다.", permission: KOStoryPostPermission.OnlyMe, sharable: false, androidExecParam: nil, iosExecParam: nil, completionHandler: nil)
            
            listTitles.removeAtIndex(indexPath.row)
            listContents.removeAtIndex(indexPath.row)
            listDeadLines.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        }
    }
    
    func Alert(){
        let Now = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyyMMddHHmm"
        let NTime = formatter.stringFromDate(Now)
        print(NTime)
        
        let app = UIApplication.sharedApplication()
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert], categories: nil)
        app.registerUserNotificationSettings(notificationSettings)
        let alertTime = NSDate().dateByAddingTimeInterval(0)
        let notifyAlarm = UILocalNotification()
        
        notifyAlarm.fireDate = alertTime
        notifyAlarm.timeZone = NSTimeZone.defaultTimeZone()
        notifyAlarm.alertBody = "Alert"
        
        for item in listDeadLinesForBackGround{
            if (NTime >= item){
                app.scheduleLocalNotification(notifyAlarm)
                print(item)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.dataSource = self
        mainTableView.delegate = self
        self.navigationController?.navigationBar.hidden = false
        self.navigationItem.hidesBackButton = true
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(MainViewController.Alert), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
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
            
            detailView.receiveMainTitle(listTitles[(indexPath?.row)!])
            detailView.receiveDetailContent(listContents[(indexPath?.row)!])
            detailView.receiveDeadLine(listDeadLines[(indexPath?.row)!])
            
            detailView.cur = indexPath!.row
        }
    }
    //<DetailViewPart/>
}




