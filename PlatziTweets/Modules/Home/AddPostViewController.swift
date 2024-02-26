//
//  AddPostViewController.swift
//  PlatziTweets
//
//  Created by Jozek Hajduk on 26/02/24.
//

import UIKit

class AddPostViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var postTextView: UITextView!
    
    // MARK: - IBActions
    @IBAction func addPostAction() {
        
    }
    
    @IBAction func dismissAction() {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
