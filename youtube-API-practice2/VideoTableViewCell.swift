//
//  VideoTableViewCell.swift
//  youtube-API-practice2
//
//  Created by 洪展彬 on 2020/10/30.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var authorDate: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var repliesButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
