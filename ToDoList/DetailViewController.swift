//
//  DetailViewController.swift
//  ToDoList
//
//  Created by dshs_student on 2016. 11. 18..
//  Copyright © 2016년 DGSW_TEACHER. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var receiveMainTitle = ""
    var receiveDetailContent = ""
    var receiveDeadLine = ""
    
    
    @IBOutlet weak var MainTitleLabel: UILabel!
    @IBOutlet weak var DetailContentsLabel: UILabel!
    @IBOutlet weak var DeadLineLabel: UILabel!
    
    @IBOutlet weak var AddFile: UIButton!
    
    @IBOutlet weak var Fix: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        MainTitleLabel.text = receiveMainTitle
        DetailContentsLabel.text = receiveDetailContent
        DeadLineLabel.text = receiveDeadLine
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /////////////////
    func receiveMainTitle(itemTitle: String)
    {
        receiveMainTitle = itemTitle
        print(itemTitle)
    }
    
    func receiveDetailContent(itemContent: String)
    {
        receiveDetailContent = itemContent
        print(itemContent)
    }
    
    func receiveDeadLine(itemDeadLine: String)
    {
        receiveDeadLine = "제출 기한: " + itemDeadLine
        print(itemDeadLine)
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
