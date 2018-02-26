//
//  ViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q  on 2/22/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    private var authUserService = AuthUserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authUserService.delegate = self
        self.view.backgroundColor = UIColor(displayP3Red: 50/255, green: 25/255, blue: 170/255, alpha: 1)
        view.addSubview(loginView)
        loginView.loginButton.addTarget(self, action: #selector(userLoginAccount), for: .touchUpInside)
        loginView.forgotPasswordButton.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
        loginView.createNewAccountButton.addTarget(self, action: #selector(createNewAccount), for: .touchUpInside)
    }
    
    @objc private func userLoginAccount() {
        print("user login button pressed")
        guard let passwordText = loginView.passwordTextField.text else {print("password is nil"); return}
        guard !passwordText.isEmpty else {print("password field is empty"); return}
        if passwordText.contains(" ") {
            showAlert(title: "Come on, really!? No spaces allowed!", message: nil)
            return
        }
        authUserService.signIn(email: loginView.emailLoginTextField.text!, password: passwordText)
    }
    
    @objc private func createNewAccount() {
        print("create new account button pressed")
        guard let emailText = loginView.emailLoginTextField.text else {print("email is nil"); return}
        guard !emailText.isEmpty else {print("email field is empty"); return}
        guard let passwordText = loginView.passwordTextField.text else {print("password is nil"); return}
        guard !passwordText.isEmpty else {print("password field is empty"); return}
        if passwordText.contains(" ") {
            showAlert(title: "Come on, really!? No spaces allowed!", message: nil)
            return
        }
        authUserService.createUser(email: emailText, password: passwordText)
    }
    
    @objc private func forgotPassword() {
        Auth.auth().sendPasswordReset(withEmail:loginView.emailLoginTextField.text!){(error) in
            print("sent")
            self.showAlert(title: "Password Reset", message: "Password  reset email sent")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loginView.emailLoginTextField.resignFirstResponder()
        loginView.passwordTextField.resignFirstResponder()
    }
    
    func showAlert(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        
    }
}

extension LoginViewController: AuthUserServiceDelegate {
    func didCreateUser(_ userService: AuthUserService, user: User) {
        print("didCreateUser: \(user)")
        Auth.auth().currentUser!.sendEmailVerification(completion: { (error) in
            if let error = error {
                print("error with sending email verification, \(error)")
                self.showAlert(title: "Error", message: "error with sending email verification");
                self.authUserService.signOut()
            } else {
                print("email verification sent")
                self.showAlert(title: "Verification Sent", message: "Please verify email");
                self.authUserService.signOut()
            }
        })
    }
    
    func didFailCreatingUser(_ userService: AuthUserService, error: Error) {
        showAlert(title: error.localizedDescription, message: nil)
    }
    
    func didSignIn(_ userService: AuthUserService, user: User) {
        if Auth.auth().currentUser!.isEmailVerified {
            self.dismiss(animated: true, completion: nil)
        } else {
            showAlert(title: "Email Verification Needed", message: "Please verify email")
            authUserService.signOut()
            return
        }
    }
    
    func didFailSignIn(_ userService: AuthUserService, error: Error) {
        showAlert(title: error.localizedDescription, message: nil)
    }
}
