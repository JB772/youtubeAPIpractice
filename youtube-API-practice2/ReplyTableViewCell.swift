//
//  ReplyTableViewCell.swift
//  youtube-API-practice2
//
//  Created by 洪展彬 on 2020/10/31.
//

import UIKit

class ReplyTableViewCell: UITableViewCell {

    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var editDateLabel: UILabel!
    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
