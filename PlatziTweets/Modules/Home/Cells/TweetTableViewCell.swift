//
//  TweetTableViewCell.swift
//  PlatziTweets
//
//  Created by Jozek Hajduk on 26/02/24.
//

import UIKit
import Kingfisher

class TweetTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - IBActions
    @IBAction func openVideoAction() {
        // OJO: CELLS never invoke a viewController, never!!!
        
        guard let videoUrl = videoUrl else { return }
        needsToShowVideo?(videoUrl)
    }
    
    // MARK: - Properties
    private var videoUrl: URL?
    var needsToShowVideo: ((_ url: URL) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(with post: Post) {
        nameLabel.text = post.author.names
        nickNameLabel.text = post.author.nickname
        messageLabel.text = post.text
        videoButton.isHidden = !post.hasVideo
        videoUrl = URL(string: post.videoUrl ?? "")
        
        if post.hasImage {
            // Setup image
            tweetImageView.kf.setImage(with: URL(string: post.imageUrl ?? ""))
        } else {
            // Delete image
            tweetImageView.isHidden = true
        }
    }
    
}
