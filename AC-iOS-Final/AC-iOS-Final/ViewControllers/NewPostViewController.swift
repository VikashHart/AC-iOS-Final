//
//  UploadViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import AVFoundation
import Toucan
import Alamofire

class NewPostViewController: UIViewController {

    // MARK: import Views
    private let newpost = NewPostView()
    
    // MARK: Properties
    private var currentUser = AuthUserService.getCurrentUser()
    private var postImage: UIImage!
    private var gesture: UIGestureRecognizer!
    private let imagePicker = UIImagePickerController()
    private var authService = AuthUserService()
    
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(newpost)
        configureNavBar()
        newpost.captionTextField.delegate = self
        imagePicker.delegate = self
        newpost.selectImageButton.addTarget(self, action: #selector(changePostImage), for: UIControlEvents.allTouchEvents)
    }
    
    private func configureNavBar() {
        self.navigationItem.title = "Upload"
        let postBarItem = UIBarButtonItem(title: "Post", style: UIBarButtonItemStyle.plain, target: self, action: #selector(addPost))
        navigationItem.rightBarButtonItem = postBarItem
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func cancelPost() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func addPost() {
        if !NetworkReachabilityManager()!.isReachable {
            self.showAlert(title: "No Network", message: "No Network detected. Please check connection.")
            return
        }
        let newCaption = newpost.captionTextField.text!
        if newCaption.isEmpty == false {
            DBService.manager.addPosts(caption: newpost.captionTextField.text ?? "", postImageStr: "no image", image: postImage ?? #imageLiteral(resourceName: "placeholder"))
            self.tabBarController?.selectedIndex = 0
        } else {
            showAlert(title: "Caption needed", message: "Please add caption")
        }
    }
    
    @objc private func changePostImage() {
        let alertController = UIAlertController(title: "Add Image", message: nil , preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let existingPhotoAction = UIAlertAction(title: "Choose Existing Photo", style: .default) { (alertAction) in
            self.launchCameraFunctions(type: UIImagePickerControllerSourceType.photoLibrary)
        }
        let newPhotoAction = UIAlertAction(title: "Take New Photo", style: .default) { (alertAction) in
            self.launchCameraFunctions(type: UIImagePickerControllerSourceType.camera)
        }
        alertController.addAction(existingPhotoAction)
        alertController.addAction(newPhotoAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        newpost.captionTextField.resignFirstResponder()
    }
    
    //Camera Functions
    private func launchCameraFunctions(type: UIImagePickerControllerSourceType){
        if UIImagePickerController.isSourceTypeAvailable(type){
            imagePicker.sourceType = type
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
}


// MARK: Camera
//MARK: UIImagePickerController Delegate & NavigationController Delegate
extension NewPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage else { print("image is nil"); return }
        
        // resize the image
        let sizeOfImage: CGSize = CGSize(width: 300, height: 300)
        let toucanImage = Toucan.Resize.resizeImage(editedImage, size: sizeOfImage)
        self.postImage = toucanImage
        self.newpost.selectImageButton.setImage(postImage, for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension NewPostViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textField = newpost.captionTextField
        textField.resignFirstResponder()
        return true
    }
}
