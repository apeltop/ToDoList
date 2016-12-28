//
//  DetailViewController.swift
//  ToDoList
//
//  Created by dshs_student on 2016. 11. 18..
//  Copyright © 2016년 DGSW_TEACHER. All rights reserved.
//

import UIKit
import MobileCoreServices

var captureImage: UIImage!
class DetailViewController: UIViewController,UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var cur = 0
    var receiveMainTitle = ""
    var receiveDetailContent = ""
    var receiveDeadLine = ""
    var receivedContants = ""
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var flagImageSave = false
    
    @IBOutlet weak var chooseImage: UIImageView!
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
        
        MainTitleField.text = listTitles[cur]
        DetailContentField.text = listContents[cur]
        DeadLineLabel.text = listRealDeadLines[cur]
        chooseImage.image = listImage[cur]
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
            
            chooseImage.image = captureImage
            listImage[cur] = captureImage
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
    
    @IBAction func FixDone(sender: UIBarButtonItem) {
        listTitles[cur] = MainTitleField.text!
        listContents[cur] = DetailContentField.text!
        KOSessionTask.storyPostNoteTaskWithContent("저는 \(listTitles[cur])를 \(MainTitleField.text!)로 고쳤습니다.", permission: KOStoryPostPermission.OnlyMe, sharable: false, androidExecParam: nil, iosExecParam: nil, completionHandler: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "DetailNacta"){
            let dest = segue.destinationViewController as! QRCodeReaderViewController
            dest.cur = cur
        }
        else if(segue.identifier == "sgDetailViewImage"){
            let detailFull = segue.destinationViewController as! DetailFullImageViewController
            detailFull.LoadFullImage(cur)
        }
    }
}

