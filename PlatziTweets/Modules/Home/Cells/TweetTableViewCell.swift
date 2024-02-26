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
        
        if post.hasImage {
            // Setup image
            tweetImageView.kf.setImage(with: URL(string: post.imageUrl))
        } else {
            // Delete image
            tweetImageView.isHidden = true
        }
    }
    
}
