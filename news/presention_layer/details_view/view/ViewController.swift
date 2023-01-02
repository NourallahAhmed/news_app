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
    @IBOutlet weak var auther: UILabel!
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var time: UILabel!
    
    @IBAction func toWebSite(_ sender: Any) {
        
        if let url = URL(string: self.article?.url ?? "https://www.google.com") {
        UIApplication.shared.open(url, completionHandler: { success in
        if success {
            print("opened")
        }else {
            print("failed")
            // showInvalidUrlAlert()
            }
        })
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.desc.text = self.article?.articleDescription;
        self.articleTitle.text = self.article?.title;
        self.articleContent.text = self.article?.content;
        self.articleImage.image = UIImage(named: "default")
        self.auther.text = self.article?.author
        let imageUrl = URL(string: self.article?.urlToImage ?? "")
        
        
        articleImage.sd_setImage(with: imageUrl , placeholderImage: UIImage(named: "default"))
        self.sourceName.text = article?.source.name
        self.time.text = article?.publishedAt

    }


}

