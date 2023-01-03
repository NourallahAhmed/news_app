//
//  HeadlinesViewController.swift
//  news
//
//  Created by NourAllah Ahmed on 01/01/2023.
//

import UIKit
import NVActivityIndicatorView


class HeadlinesViewController: UIViewController {

    
    
    private var viewModel : HeadLinesViewModel = HeadLinesViewModel()
    @IBOutlet weak var headlinesCollectionView: UICollectionView!
    
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    private var isClicked = false
    
    private let indicator = NVActivityIndicatorView(frame: CGRect(x: 50, y: 10, width: 100, height: 100),
        type: NVActivityIndicatorType.ballTrianglePath  ,
        color: UIColor.blue)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headlinesCollectionView.delegate = self
        self.headlinesCollectionView.dataSource = self
        self.navigationItem.title = "Head Lines"

        
        
        //MARK: setting 1 items in 1 row with zero space
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/1, height:  UIScreen.main.bounds.height/4)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        headlinesCollectionView.collectionViewLayout = layout
        
        
        //MARK: Indicator
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        self.indicator.startAnimating()
        
        //MARK: fetch data
        viewModel.getHeadLines { articles in
            
            self.indicator.stopAnimating()
            self.headlinesCollectionView.reloadData()
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HeadlinesViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfArticles
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "headlinesCell", for: indexPath) as! HeadLinesViewCell
        
        
        cell.articleTitle.text = viewModel.newsArticles[indexPath.row].title
        
        cell.articleAuther.text  = viewModel.newsArticles[indexPath.row].author
        let imageUrl = URL(string: viewModel.newsArticles[indexPath.row].urlToImage ?? "")
        cell.articleImage.sd_setImage(with: imageUrl , placeholderImage: UIImage(named: "default"))

        
        
        
        return cell
        
       
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let url =
           URL(string: self.viewModel.newsArticles[indexPath.row].url ?? "https://www.google.com")
        else{
            return
        }
        
        let webView = WebKitViewController(url: url)
        self.navigationController?.pushViewController(webView, animated: false)
        
      
    }
 
}
