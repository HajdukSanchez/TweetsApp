//
//  RegisterViewController.swift
//  PlatziTweets
//
//  Created by Jozek Hajduk on 23/02/24.
//

import UIKit
import NotificationBannerSwift
import Simple_Networking
import SVProgressHUD

class RegisterViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var namesTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func registerButtonAction() {
        view.endEditing(true) // Hide keyboard and hide focus on text field selected
        performRegister()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        registerButton.layer.cornerRadius = 25
        registerButton.layer.masksToBounds = true
    }
    
    private func performRegister() {
        guard let email = emailTextField.text, !email.isEmpty else {
            NotificationBanner(title: "Error",
                               subtitle: "You need to specify an Email",
                               style: .warning).show()
            return
        }
        guard let names = namesTextField.text, !names.isEmpty else {
            NotificationBanner(title: "Error",
                               subtitle: "You need to specify your name and last name",
                               style: .warning).show()
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            NotificationBanner(title: "Error",
                               subtitle: "You need to specify some password",
                               style: .warning).show()
            return
        }
        let request = RegisterRequest(email: email, password: password, name: names)
        
        // Call register request
        handleRegister(with: request)
        
        // Go to home
        performSegue(withIdentifier: "showHome", sender: nil)
    }
    
    private func handleRegister(with request: RegisterRequest) {
        // Start loading indicator
        SVProgressHUD.show()
        
        SN.post(endpoint: EndPoints.register, model: request) { (response: SNResultWithEntity<LoginResponse, ErrorResponse>) in
            SVProgressHUD.dismiss()
            
            switch response {
            case .success(let data):
                NotificationBanner(subtitle: "Welcome \(data.user.names)",
                                   style: .success).show()
                return
            case .error(let error):
                NotificationBanner(title: "Error",
                                   subtitle: "There is a problem authenticated user: \(error.localizedDescription)",
                                   style: .danger).show()
                return
            case .errorResult(let entity):
                NotificationBanner(title: "Error",
                                   subtitle: "There is a problem with server: \(entity)",
                                   style: .warning).show()
                return
            }
        }
    }

}
