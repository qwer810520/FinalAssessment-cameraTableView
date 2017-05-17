//
//  AddPhotoViewController.swift
//  FinalAssessment-5
//
//  Created by 楷岷 張 on 2017/5/17.
//  Copyright © 2017年 楷岷 張. All rights reserved.
//

import UIKit
import CoreData

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var showCameraPhoto: UIImageView!
    @IBOutlet weak var InputText: UITextField!
    @IBOutlet weak var scrollViewSet: UIScrollView!
    var addPhoto:PhotoMo?
    var image:UIImage?
    var saveSwitch = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
        
        InputText.delegate = self
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if saveSwitch == true {
            if let name = InputText.text {
                if let photo = image {
                    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                        addPhoto = PhotoMo(context: appDelegate.persistentContainer.viewContext)
                        addPhoto?.name = name
                        if let imageData = UIImageJPEGRepresentation(photo, 0.5) {
                            addPhoto?.photo = NSData(data: imageData)
                        }
                        appDelegate.saveContext()
                    }
                }
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == InputText {
        scrollViewSet.setContentOffset(CGPoint(x: 0, y: 250), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == InputText {
            scrollViewSet.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == InputText {
        textField.resignFirstResponder()
        }
        
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let picture = info[UIImagePickerControllerOriginalImage] as? UIImage {
            showCameraPhoto.image = picture
            image = picture
            saveSwitch = true
        }
        dismiss(animated: true, completion: nil)
    }
    

}
