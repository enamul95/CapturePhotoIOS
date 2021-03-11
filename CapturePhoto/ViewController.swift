//
//  ViewController.swift
//  CapturePhoto
//
//  Created by Enamul Haque on 8/3/21.
//

import UIKit
import MobileCoreServices
import Alamofire
class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var buttonCapture: UIButton!
    @IBOutlet weak var buttonGalary: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.backgroundColor = .secondarySystemBackground
        
        buttonCapture.backgroundColor  = .systemBlue
        buttonCapture.setTitle("Capture Photo", for: .normal)
        buttonCapture.setTitleColor(.white, for: .normal)
        
        buttonGalary.backgroundColor  = .systemBlue
        buttonGalary.setTitle("Galary", for: .normal)
        buttonGalary.setTitleColor(.white, for: .normal)
    }
    @IBAction func btnUploadImage(_ sender: Any) {
      callsendImageAPI()
    }
    
    @IBAction func btnCapturePhoto(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        //for camera front
        // picker.cameraDevice = .front
        picker.delegate = self
        picker.allowsEditing = false
        //for live photo
        picker.mediaTypes = [kUTTypeLivePhoto as String, kUTTypeImage as String]
        present(picker, animated: true)
    }
    
    @IBAction func btnPhotoGalary(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension ViewController :UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        imageView.image = image
    }
    
    func uploadImage(){
            
      /*  let image = UIImage.init(named: "myImage")
        let imgData = image!.jpegData(compressionQuality: 0.2)!

         let parameters = ["name": ""] //Optional for extra parameter
        
        AF.upload(<#T##fileURL: URL##URL#>, to: <#T##URLConvertible#>)
        
            AF.request("http://202.40.191.226:8084/self-onboarding-app/", method: .post, parameters:parameters).response { response in
                if let data = response.data {
                    do{
                      print(data)
                    }catch let err{
                     print("Print --->",err)
                     
                    }
                }
            }
        */
        }
    
    func callsendImageAPI(){
       
        let param: [String:Any] = [
            "name":"Enamul"
        ]
     
        
        var image  = imageView.image
        let imageData = image!.jpegData(compressionQuality: 0.50)
        print(image, imageData!)
        
        //back
        var back = UIImage()
        back = UIImage(named: "qr_icon")!
        let imageDataBack = back.jpegData(compressionQuality: 0.50)
        print(back, imageDataBack!)
        
        AF.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData!, withName: "front", fileName: "front", mimeType: "image/png")
            multipartFormData.append(imageDataBack!, withName: "back", fileName: "back", mimeType: "image/png")
            for (key, value) in param {
                multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
            }
            
        },to: URL.init(string: "http://202.40.191.226:8084/self-onboarding-app/TestApi")!, usingThreshold: UInt64.init(), method: .post).response{ response in
            
           print("resposse ----")
             
            
      }
    }


}
