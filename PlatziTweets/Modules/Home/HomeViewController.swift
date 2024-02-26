//
//  HomeViewController.swift
//  PlatziTweets
//
//  Created by Jozek Hajduk on 26/02/24.
//

import UIKit
import NotificationBannerSwift
import Simple_Networking
import SVProgressHUD

class HomeViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private let cellId = "TweetTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        getPosts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Each time screen is showed, everything here will be executed
        // We dont execute method to get posts because it will reload the array with same data,
        // and we want to matain data from AddPostViewController
//        getPosts()
        self.tableView.reloadData()
    }
    
    private func setUpUI() {
        // Setup data soruce
        tableView.dataSource = self
        // register cell
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    private func getPosts() {
        // Show loader
        SVProgressHUD.show()
        // Get data from service (Endpoint not work)
//        SN.get(endpoint: EndPoints.getPosts) { (response: SNResultWithEntity<[Post], ErrorResponse>) in
//            SVProgressHUD.dismiss()
//            
//            switch response {
//            case .success(let posts):
//                self.dataSource = posts
//                self.tableView.reloadData() // Reload table data
//            case .error(let error):
//                NotificationBanner(title: "Error",
//                                   subtitle: "There is a problem getting posts: \(error.localizedDescription)",
//                                   style: .danger).show()
//                return
//            case .errorResult(let entity):
//                NotificationBanner(title: "Error",
//                                   subtitle: "There is a problem with server: \(entity)",
//                                   style: .warning).show()
//                return
//            }
//        }
        // Set data
        Constants.postsDataSource = [
            Post(id: "0", author: Constants.user, imageUrl: "", text: "Tweet 1", videoUrl: "", location: Constants.postLocation, hasVideo: false, hasImage: false, hasLocation: false, createdAt: ""),
            Post(id: "1", author: Constants.user, imageUrl: "", text: "Tweet 2", videoUrl: "", location: Constants.postLocation, hasVideo: false, hasImage: false, hasLocation: false, createdAt: ""),
            Post(id: "2", author: Constants.user, imageUrl: "", text: "Tweet 3", videoUrl: "", location: Constants.postLocation, hasVideo: false, hasImage: false, hasLocation: false, createdAt: ""),
            Post(id: "3", author: Constants.user, imageUrl: "", text: "Tweet 4", videoUrl: "", location: Constants.postLocation, hasVideo: false, hasImage: false, hasLocation: false, createdAt: ""),
        ]
        // Reload table
        self.tableView.reloadData()
    }

}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.postsDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if let cell = cell as? TweetTableViewCell {
            // Setup cell
            cell.setUpCell(with: Constants.postsDataSource[indexPath.row])
        }
        
        return cell
    }
    
}
