//
//  CustomNewsCellTableViewCell.swift
//  news
//
//  Created by NourAllah Ahmed on 01/01/2023.
//

import UIKit

class CustomNewsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var articlTitle: UILabel!
    @IBOutlet weak var auther: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var desc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   

   
    /// padding to the whole cell
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
