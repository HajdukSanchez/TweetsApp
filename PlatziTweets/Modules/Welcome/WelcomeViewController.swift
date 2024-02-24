//
//  WelcomeViewController.swift
//  PlatziTweets
//
//  Created by Jozek Hajduk on 23/02/24.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        loginButton.layer.cornerRadius = 25
        loginButton.layer.masksToBounds = true
    }
}
