//
//  DetailFullImageViewController.swift
//  ToDoList
//
//  Created by dshs_student on 2016. 12. 26..
//  Copyright © 2016년 DGSW_TEACHER. All rights reserved.
//

import UIKit

class DetailFullImageViewController: UIViewController {
    
    var cur = 0
    @IBOutlet weak var chooseFullImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(listImage[cur] != UIImage(named: "listImageTempPlace.png")){
            chooseFullImage.image = listImage[cur]
        }
        else{
            chooseFullImage.image = captureImage
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func LoadFullImage(Index: Int){
        cur = Index
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
