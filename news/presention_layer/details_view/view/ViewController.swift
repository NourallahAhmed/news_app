//
//  ViewController.swift
//  news
//
//  Created by NourAllah Ahmed on 01/01/2023.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    var article :Article?

    @IBOutlet weak var articleContent: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.desc.text = self.article?.articleDescription;
        self.articleTitle.text = self.article?.title;
        self.articleContent.text = self.article?.content;
        self.articleImage.image = UIImage(named: "default")
        
        let imageUrl = URL(string: self.article?.urlToImage ?? "")
        
        
        articleImage.sd_setImage(with: imageUrl , placeholderImage: UIImage(named: "default"))
//        self.articleImage.kf.setImage(with: imageUrl,
//                                    placeholder: UIImage(named: "default") ,
//                                    options: nil,
//                                    progressBlock: nil)

    }


}

