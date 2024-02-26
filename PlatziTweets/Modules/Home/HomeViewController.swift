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
    private var dataSource = [Post]() // Empty array
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        getPosts()
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
        let user = User(email: "hajduksanchez.dev@gmail.com", names: "Jozek Hajduk", nickname: "@HajdukSanchez")
        let postLocation = PostLocation(latitude: 0, longitude: 0)
        // Set data
        self.dataSource = [
            Post(id: "0", author: user, imageUrl: "", text: "Tweet 1", videoUrl: "", location: postLocation, hasVideo: false, hasImage: false, hasLocation: false, createdAt: ""),
            Post(id: "1", author: user, imageUrl: "", text: "Tweet 2", videoUrl: "", location: postLocation, hasVideo: false, hasImage: false, hasLocation: false, createdAt: ""),
            Post(id: "2", author: user, imageUrl: "", text: "Tweet 3", videoUrl: "", location: postLocation, hasVideo: false, hasImage: false, hasLocation: false, createdAt: ""),
            Post(id: "3", author: user, imageUrl: "", text: "Tweet 4", videoUrl: "", location: postLocation, hasVideo: false, hasImage: false, hasLocation: false, createdAt: ""),
        ]
        // Reload table
        self.tableView.reloadData()
    }

}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if let cell = cell as? TweetTableViewCell {
            // Setup cell
            cell.setUpCell(with: dataSource[indexPath.row])
        }
        
        return cell
    }
    
}
