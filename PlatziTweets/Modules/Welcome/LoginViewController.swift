//
//  LoginViewController.swift
//  PlatziTweets
//
//  Created by Jozek Hajduk on 23/02/24.
//

import UIKit
import NotificationBannerSwift

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
            NotificationBanner(title: "Error", subtitle: "You need to specify an Email", style: .warning).show()
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "You need to specify some password", style: .warning).show()
            return
        }
        // Handle login
        performSegue(withIdentifier: "showHome", sender: nil)
    }
}
