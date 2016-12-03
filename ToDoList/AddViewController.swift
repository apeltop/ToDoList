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
    
    @IBOutlet weak var AddDoneButton: UIBarButtonItem!
    @IBOutlet weak var current_time: UILabel!
    @IBOutlet weak var Selection_time: UILabel!
    
    @IBOutlet weak var Title_text: UITextField!
    @IBOutlet weak var to_do: UITextField!
    @IBOutlet weak var Selection_Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func DTPicker(sender: UIDatePicker) {
        let datePickerView = sender
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd(EEE) HH:mm"
        Selection_time.text = formatter.stringFromDate(datePickerView.date)
    }
    
    func updateTime(){
        let date = NSDate()
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd(EEE) HH:mm"
        current_time.text = "현재 시간: " + formatter.stringFromDate(date)
    }
    
    @IBAction func AddDoe(sender: UIButton) {
        listTitles.append(Title_text.text!)
        listContents.append(to_do.text!)
        listDeadLines.append(Selection_time.text! + "까지")
        
        //        listImages.append()
        
        Title_text.text = ""
        to_do.text = ""
        current_time.text = ""
        self.navigationController?.popViewControllerAnimated(true)
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
