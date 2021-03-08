//
//  ViewController.swift
//  CapturePhoto
//
//  Created by Enamul Haque on 8/3/21.
//

import UIKit
import MobileCoreServices
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
}
