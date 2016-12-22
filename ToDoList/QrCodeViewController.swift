//
//  QrCodeViewController.swift
//  ToDoList
//
//  Created by dshs_student on 2016. 12. 22..
//  Copyright © 2016년 DGSW_TEACHER. All rights reserved.
//

import UIKit

class QrCodeViewController: UIViewController {

    @IBOutlet weak var qrImage: UIImageView!
    
    var qrCodeImage:CIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if qrCodeImage == nil {
            let data = "김대용".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            
            filter!.setValue(data, forKey: "inputMessage")
            filter!.setValue("Q", forKey: "inputCorrectionLevel")
            
            qrCodeImage = filter!.outputImage
            qrImage.image = UIImage(CIImage: qrCodeImage!)
            //displayQRCodeImage()
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func displayQRCodeImage() {
        let scaleX = qrImage.frame.size.width / qrCodeImage.extent.size.width
        let scaleY = qrImage.frame.size.height / qrCodeImage.extent.size.height
        
        let transformedImage = qrCodeImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        
        qrImage.image = UIImage(CIImage: transformedImage)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
