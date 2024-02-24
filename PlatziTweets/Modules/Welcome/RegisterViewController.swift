//
//  RegisterViewController.swift
//  PlatziTweets
//
//  Created by Jozek Hajduk on 23/02/24.
//

import UIKit
import NotificationBannerSwift

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
            NotificationBanner(title: "Error", subtitle: "You need to specify an Email", style: .warning).show()
            return
        }
        guard let names = namesTextField.text, !names.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "You need to specify your name and last name", style: .warning).show()
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "You need to specify some password", style: .warning).show()
            return
        }
        // Handle register
        performSegue(withIdentifier: "showHome", sender: nil)
    }

}
