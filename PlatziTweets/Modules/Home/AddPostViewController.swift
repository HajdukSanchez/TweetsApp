//
//  AddPostViewController.swift
//  PlatziTweets
//
//  Created by Jozek Hajduk on 26/02/24.
//

import UIKit
import Simple_Networking
import SVProgressHUD
import NotificationBannerSwift

class AddPostViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var postTextView: UITextView!
    
    // MARK: - IBActions
    @IBAction func addPostAction() {
        savePost()
    }
    
    @IBAction func dismissAction() {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func savePost() {
        SVProgressHUD.show()
        let newText = postTextView.text ?? ""
//        let request = PostRequest(text: newText, imageUrl: "", videoUrl: "", location: nil)
        // (Endpoint not work)
//        SN.post(endpoint: EndPoints.post) { (response: SNResultWithEntity<Post, ErrorResponse>) in
//            SVProgressHUD.dismiss()
//            
//            switch response {
//            case .success(let post):
//                self.dismissAction()
//            case .error(let error):
//                NotificationBanner(title: "Error",
//                                   subtitle: "There is a problem authenticated user: \(error.localizedDescription)",
//                                   style: .danger).show()
//                return
//            case .errorResult(let entity):
//                NotificationBanner(title: "Error",
//                                   subtitle: "There is a problem with server: \(entity)",
//                                   style: .warning).show()
//                return
//            }
//        }
        let newPost = Post(id: "0", author: Constants.user, imageUrl: "", text: newText, videoUrl: "", location: Constants.postLocation, hasVideo: false, hasImage: false, hasLocation: false, createdAt: "")
        Constants.postsDataSource.insert(newPost, at: 0)
        dismissAction()
        SVProgressHUD.dismiss()
    }
}
