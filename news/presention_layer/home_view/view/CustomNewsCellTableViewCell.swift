//
//  CustomNewsCellTableViewCell.swift
//  news
//
//  Created by NourAllah Ahmed on 01/01/2023.
//

import UIKit

class CustomNewsTableViewCell: UITableViewCell {
    @IBOutlet weak var auther: UILabel!
    @IBOutlet weak var tiltle: UILabel!
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var desc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
