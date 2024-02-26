//
//  LoginViewController.swift
//  PlatziTweets
//
//  Created by Jozek Hajduk on 23/02/24.
//

import UIKit
import NotificationBannerSwift
import Simple_Networking
import SVProgressHUD

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func loginButtonAction() {
        view.endEditing(true) // Hide keyboard and hide focus on text field selected
        performLogin()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        loginButton.layer.cornerRadius = 25
        loginButton.layer.masksToBounds = true
    }
    
    private func performLogin() {
        guard let email = emailTextField.text, !email.isEmpty else {
            NotificationBanner(title: "Error",
                               subtitle: "You need to specify an Email",
                               style: .warning).show()
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            NotificationBanner(title: "Error",
                               subtitle: "You need to specify some password",
                               style: .warning).show()
            return
        }
        
        let request = LoginRequest(email: email, password: password)
        
        // Call login request
        handleLogin(with: request)
        
        // Go to home
        performSegue(withIdentifier: "showHome", sender: nil)
    }
    
    private func handleLogin(with request: LoginRequest) {
        // Start loading indicator
        SVProgressHUD.show()
        
        SN.post(endpoint: EndPoints.login, model: request) { (response: SNResultWithEntity<LoginResponse, ErrorResponse>) in
            SVProgressHUD.dismiss()
            
            switch response {
            case .success(let data):
                NotificationBanner(subtitle: "Welcome \(data.user.names)",
                                   style: .success).show()
                SimpleNetworking.setAuthenticationHeader(prefix: "", token: data.token) // Save Token for next requests
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
