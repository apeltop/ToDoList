//
//  DetailViewController.swift
//  ToDoList
//
//  Created by dshs_student on 2016. 11. 18..
//  Copyright © 2016년 DGSW_TEACHER. All rights reserved.
//

import UIKit
import MobileCoreServices

class DetailViewController: UIViewController,UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var cur = 0
    var receiveMainTitle = ""
    var receiveDetailContent = ""
    var receiveDeadLine = ""
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var flagImageSave = false
    var captureImage: UIImage!
    
    @IBOutlet weak var MainTitleField: UITextField!
    @IBOutlet weak var DetailContentField: UITextField!
    @IBOutlet weak var DeadLineLabel: UILabel!
    
    @IBOutlet weak var DoneButton: UIBarButtonItem!
    
    @IBOutlet weak var AddFile: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        // Do any additional setup after loading the view.
        MainTitleField.text = receiveMainTitle
        DetailContentField.text = receiveDetailContent
        DeadLineLabel.text = receiveDeadLine
        
        view.addGestureRecognizer(tap)
        MainTitleField.delegate = self
        DetailContentField.delegate = self
    }
    
    func myAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnLoadImageFromLibrary(sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)){
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .PhotoLibrary
            
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            presentViewController(imagePicker, animated: true, completion: nil)
        }
            
        else{
            myAlert("Photo album inaccessable", message: "Application cannot access the photo album.")
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        if mediaType.isEqualToString(kUTTypeImage as NSString as String){
            captureImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            if flagImageSave{
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
    func hideKeyboard(){
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /////////////////
    func receiveMainTitle(itemTitle: String)
    {
        receiveMainTitle = itemTitle
    }
    
    func receiveDetailContent(itemContent: String)
    {
        receiveDetailContent = itemContent
    }
    
    func receiveDeadLine(itemDeadLine: String)
    {
        receiveDeadLine = "제출 기한: " + itemDeadLine
    }
    
    @IBAction func FixDone(sender: UIBarButtonItem) {
        listTitles[cur] = MainTitleField.text!
        listContents[cur] = DetailContentField.text!
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
