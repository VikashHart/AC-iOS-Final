//
//  UploadView.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class NewPostView: UIView {
    
    lazy var captionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Insert caption here"
        textField.textAlignment = .left
        textField.autocapitalizationType = .sentences
        textField.autocorrectionType = .yes
        textField.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var selectImageButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
        button.backgroundColor = .lightGray
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    public func setImage(image: UIImage?) {
        let buttonImage = image ?? #imageLiteral(resourceName: "placeholder")
        selectImageButton.setImage(buttonImage, for: .normal)
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupImageButton()
        setupCaptionTextField()
        
    }
    
    private func setupImageButton() {
        addSubview(selectImageButton)
        selectImageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectImageButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            selectImageButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            selectImageButton.heightAnchor.constraint(equalTo: selectImageButton.widthAnchor, multiplier: 1),
            selectImageButton.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    
    private func setupCaptionTextField() {
        addSubview(captionTextField)
        captionTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            captionTextField.topAnchor.constraint(equalTo: selectImageButton.bottomAnchor, constant: 5),
            captionTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            captionTextField.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            captionTextField.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ])
    }
}
