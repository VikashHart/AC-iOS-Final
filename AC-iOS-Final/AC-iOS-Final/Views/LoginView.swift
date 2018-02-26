//
//  LoginView.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    lazy var imageView: UIImageView = {
        let tv = UIImageView()
        tv.image = #imageLiteral(resourceName: "meatly_logo")
        tv.contentMode = .scaleAspectFit
        return tv
    }()
    
    lazy var emailLoginTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        textField.placeholder = "Email Address"
        textField.text = "vikashhart@ac.c4q.nyc" //FIX: remove, only for testing
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        let myColor : UIColor = UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )
        textField.layer.borderColor = myColor.cgColor
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        textField.placeholder = "Password"
        textField.text = "123456"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.purple.cgColor
        textField.isSecureTextEntry = true // this helps to obscure the user's password with *******
        textField.textColor = .black
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.backgroundColor = .cyan
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var createNewAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.backgroundColor = .cyan
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password?", for: UIControlState.normal)
        button.setTitleColor(UIColor.blue, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.medium)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupImageView()
        setupEmailTextField()
        setupPasswordTextField()
        setupForgotPassword()
        setupLoginButton()
        setupNewAccountButton()
        
        
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    
    private func setupEmailTextField() {
        addSubview(emailLoginTextField)
        emailLoginTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        emailLoginTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
        emailLoginTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
        emailLoginTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func setupPasswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailLoginTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: emailLoginTextField.widthAnchor, multiplier: 1)
            ])
    }
    
    private func setupForgotPassword() {
        addSubview(forgotPasswordButton)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            forgotPasswordButton.widthAnchor.constraint(equalTo: emailLoginTextField.widthAnchor, multiplier: 1)
            ])
    }
    
    private func setupLoginButton() {
        addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 10),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6)
            ])
    }
    
    private func setupNewAccountButton() {
        addSubview(createNewAccountButton)
        createNewAccountButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createNewAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            createNewAccountButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            createNewAccountButton.widthAnchor.constraint(equalTo: loginButton.widthAnchor, multiplier: 1)
            ])
    }
}
