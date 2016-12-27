//
//  AddViewController.swift
//  ToDoList
//
//  Created by dshs_student on 2016. 11. 19..
//  Copyright © 2016년 DGSW_TEACHER. All rights reserved.
//

import UIKit


class AddViewController: UIViewController {
    let timeSelector: Selector = #selector(AddViewController.updateTime)
    
    let interval = 1.0
    var count = 0
    
    var SelectionTime = ""
    var CurrentTime  = ""
    var Result = 0
    
    var curDate:NSDate?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var AddDoneButton: UIBarButtonItem!
    @IBOutlet weak var current_time: UILabel!
    @IBOutlet weak var Selection_time: UILabel!
    
    @IBOutlet weak var Title_text: UITextField!
    @IBOutlet weak var to_do: UITextField!
    @IBOutlet weak var Selection_Label: UILabel!
    
    func addNotification() {
        NSLog("addNoti called")
        
        // 1st notification
        let notification = UILocalNotification()
        notification.alertBody = "\(Title_text.text!)의 기간이 만료되었습니다."
        notification.alertAction = "open"
        notification.timeZone = NSTimeZone.systemTimeZone()
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.fireDate = datePicker.date
        notification.userInfo = ["UUID": "\(Title_text.text!)\(Selection_time.text!)까지", "Title": Title_text.text!, "SelectTime": Selection_time.text!, "Row": listTitles.count]
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        // debug
        print(UIApplication.sharedApplication().scheduledLocalNotifications)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        
        NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        
        view.addGestureRecognizer(tap)
    }
    
    func hideKeyboard(){
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func DTPicker(sender: UIDatePicker) {
        let datePickerView = sender
        
        let nowDate = NSDate()
        let curDate = datePickerView.date
        
        Result = Int(curDate.timeIntervalSinceDate(nowDate))
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd(EEE) HH:mm"
        Selection_time.text = formatter.stringFromDate(datePickerView.date)
        
        formatter.dateFormat = "yyyyMMddHHmm"
        listDeadLinesForBackGround.append(formatter.stringFromDate(datePickerView.date))
    }
    
    func updateTime(){
        let date = NSDate()
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd(EEE) HH:mm"
        curDate = date
    }
    
    func warringAlert (alertTitle: String, alertMessage: String, actionTitle: String) {
        let TitleTempAlert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let TitleTempAction = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.Default, handler: nil)
        TitleTempAlert.addAction(TitleTempAction)
        presentViewController(TitleTempAlert, animated: true, completion: nil)
    }
    
    @IBAction func AddDoe(sender: UIButton) {
        
        if(Title_text.text == "")
        {
            warringAlert("Warring", alertMessage: "제목을 입력하세요.", actionTitle: "확인")
        }
            
        else if(Selection_time.text == "")
        {
            warringAlert("Warring", alertMessage: "시간을 선택 하세요.", actionTitle: "확인")
        }
            
        else{
            print(Result)
            if(Result <= 0){
                warringAlert("Warring", alertMessage: "시간이 맞지 않습니다.", actionTitle: "확인")
            }
            
            addDoList()
            
            KOSessionTask.storyPostNoteTaskWithContent("저는 \(Selection_time.text!)까지 \(Title_text.text!)을(를) 할 것임을 약속합니다.", permission: KOStoryPostPermission.OnlyMe, sharable: false, androidExecParam: nil, iosExecParam: nil, completionHandler: nil)
            
            addNotification()
            
            Title_text.text = ""
            to_do.text = ""
            current_time.text = ""
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func addDoList(){
        let pickedDate = datePicker.date
        let formatter = NSDateFormatter()
        formatter.dateFormat = "YYYY년 MM월 dd일"
        let selDate = formatter.stringFromDate(datePicker.date)
        print(selDate)
        formatter.dateFormat = "HH:mm"
        let dead = formatter.stringFromDate(datePicker.date)
        listDeadLines.append(dead)
        formatter.dateFormat = "YYYY년 MM월 dd일"
        var sect = -1
        var whr = listNSDate.count
        
        for(var i = 0; i < listHeader.count; i+=1){
            if listHeader[i] == selDate {
                sect = i
            }
        }
        
        for(var i = 0; i < listNSDate.count; i+=1){
            if pickedDate.compare(listNSDate[i]) == NSComparisonResult.OrderedAscending {
                whr = i
                break;
            }
        }
        
        if(sect == -1){
            sect = listHeader.count
            for(var i = 0; i < listHeader.count; i+=1){
                let nsdate = formatter.dateFromString(listHeader[i])
                if pickedDate.compare(nsdate!) == NSComparisonResult.OrderedAscending {
                    sect = i;
                    break;
                }
            }
            
            
            for(var i = 0; i < listSections.count; i+=1){
                if listSections[i] > sect {
                    listSections[i] -= 1
                }
                else{
                    listSections[i] += 1
                }
            }
            listHeader.insert(selDate, atIndex: sect)
        }
        
        listSections.insert(sect, atIndex: whr)
        listTitles.insert(Title_text.text!, atIndex: whr)
        listContents.insert(to_do.text!, atIndex: whr)
        listRealDeadLines.insert(Selection_time.text! + "까지", atIndex: whr)
        listImage.insert(UIImage(named: "listImageTempPlace.png")!, atIndex: whr)
        listCheck.insert(false, atIndex: whr)
        listDeadLines.insert(dead, atIndex: whr)
        listNSDate.insert(pickedDate, atIndex: whr)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
