//
//  LoginViewController.swift
//  ToDoList
//
//  Created by dshs_student on 2016. 11. 30..
//  Copyright © 2016년 DGSW_TEACHER. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = true
        // Do any additional setup after loading the view.
        
        /*int xMargin = 30;
         int marginBottom = 25;
         CGFloat btnWidth = self.view.frame.size.width - xMargin * 2;
         int btnHeight = 42;
         
         UIButton* kakaoLoginButton
         = [[KOLoginButton alloc] initWithFrame:CGRectMake(xMargin, self.view.frame.size.height-btnHeight-marginBottom, btnWidth, btnHeight)];
         kakaoLoginButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
         
         [self.view addSubview:kakaoLoginButton];*/
        
    }
    
    @IBAction func kakao(sender: AnyObject) {
        let session = KOSession.sharedSession()
        
        if let s = session {
            if s.isOpen() {
                s.close()
            }
            s.openWithCompletionHandler({(error) in
                
                if error == nil{
                    if s.isOpen(){
                        self.performSegueWithIdentifier("Login2MainSegue", sender: self)
                    }
                    else{
                        
                    }
                }
            })
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
     // MARK: - Navigatio
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
