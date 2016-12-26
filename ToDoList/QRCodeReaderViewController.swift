//
//  QRCodeReaderViewController.swift
//  ToDoList
//
//  Created by dshs_student on 2016. 12. 23..
//  Copyright © 2016년 DGSW_TEACHER. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet var vw: UIView!
    
    var objCaptureSession:AVCaptureSession?
    var objCaptureVideoPreviewLayer:AVCaptureVideoPreviewLayer?
    var vwQRCodeReader:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configVideoCapture()
        self.addVideoPreviewLayer()
        self.initializeQRView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func KOPosting(contents: String){
        KOSessionTask.storyPostTaskWithContent("\(contents)에게서 완료하였습니다!", permission: KOStoryPostPermission.OnlyMe, imageUrl: nil, androidExecParam: nil, iosExecParam: nil, completionHandler: nil)
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        if metadataObjects == nil || metadataObjects.count == 0 {
            vwQRCodeReader?.frame = CGRectZero
            
            return
        }
        
        let objMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if objMetadataMachineReadableCodeObject.type == AVMetadataObjectTypeQRCode {
            let objBarCode = objCaptureVideoPreviewLayer?.transformedMetadataObjectForMetadataObject(objMetadataMachineReadableCodeObject as! AVMetadataMachineReadableCodeObject)
            vwQRCodeReader?.frame = objBarCode!.bounds
            
            if objMetadataMachineReadableCodeObject.stringValue != nil {
                print(objMetadataMachineReadableCodeObject.stringValue)
                let alert: UIAlertController = UIAlertController(title: "발견", message: "\(objMetadataMachineReadableCodeObject.stringValue)님이 검사 맡을 사람이 맞는가요?", preferredStyle: .Alert)
                let okAction: UIAlertAction = UIAlertAction(title: "네", style: .Default, handler: {(alert:UIAlertAction!) -> Void in
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyBoard.instantiateViewControllerWithIdentifier("Detail") as! DetailViewController
                    
                    vc.receivedContants = objMetadataMachineReadableCodeObject.stringValue
                    
                    
                    let main:UIAlertController = UIAlertController(title: "확인", message: "\(vc.receivedContants)님에게 검사를 성공적으로 받았습니다.", preferredStyle: .Alert)
                    let action:UIAlertAction = UIAlertAction(title: "예", style: .Default, handler: {(alert:UIAlertAction!) -> Void in
                        
                        self.KOPosting(objMetadataMachineReadableCodeObject.stringValue)
                        self.navigationController?.popViewControllerAnimated(true)
                    })
                    
                    main.addAction(action)
                    self.presentViewController(main, animated: true, completion: nil)
                    
                })
                let noAction: UIAlertAction = UIAlertAction(title: "아니요", style: .Default, handler: {(alert:UIAlertAction!) -> Void in
                    self.objCaptureSession?.startRunning()
                })
                alert.addAction(okAction)
                alert.addAction(noAction)
                self.presentViewController(alert, animated: true, completion: nil)
                objCaptureSession?.stopRunning()
            }
        }
    }
    
    func configVideoCapture(){
        let objCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error:NSError?
        let objCaptureDeviceInput:AnyObject!
        
        do{
            objCaptureDeviceInput = try AVCaptureDeviceInput(device: objCaptureDevice) as AVCaptureDeviceInput
        } catch let error1 as NSError{
            error = error1
            objCaptureDeviceInput = nil
        }
        
        if error != nil {
            let alert: UIAlertController = UIAlertController(title: "에러", message: "휴대폰이 이 어플리케이션을 지원하지 않습니다!", preferredStyle: .Alert)
            
            let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        objCaptureSession = AVCaptureSession()
        objCaptureSession?.addInput(objCaptureDeviceInput as! AVCaptureInput)
        
        let objCaptureMetadataOutput = AVCaptureMetadataOutput()
        objCaptureSession?.addOutput(objCaptureMetadataOutput)
        objCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        objCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
    }
    
    func initializeQRView()
    {
        vwQRCodeReader = UIView()
        vwQRCodeReader?.layer.borderColor = UIColor.redColor().CGColor
        vwQRCodeReader?.layer.borderWidth = 5
        
        self.view.addSubview(vwQRCodeReader!)
        self.view.bringSubviewToFront(vwQRCodeReader!)
    }
    
    func addVideoPreviewLayer(){
        objCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: objCaptureSession)
        objCaptureVideoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        objCaptureVideoPreviewLayer?.frame = view.layer.bounds
        self.view.layer.addSublayer(objCaptureVideoPreviewLayer!)
        objCaptureSession?.startRunning()
        
        self.view.bringSubviewToFront(vw)
    }
    
    
}
