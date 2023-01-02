//
//  home_view_controller.swift
//  news
//
//  Created by NourAllah Ahmed on 01/01/2023.
//


import UIKit
import Kingfisher

class HomeViewController: UIViewController{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var newsTable: UITableView!
    
    
    private var homeVM = HomeViewModel() ///todo: dependency injection
    private var articles = Array<Article>()
    override func viewDidLoad() {
        super.viewDidLoad()

        

        //MARK: delegates
        self.newsTable.delegate = self;
        self.newsTable.dataSource = self;

        
        //MARK: send api request
        homeVM.getNews { articles in
            self.articles = articles;
            self.newsTable.separatorStyle = .none


            self.newsTable.reloadData();
            
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

extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
   
    
    /// get the number from viewmodel
  

    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomNewsTableViewCell
        
        cell.tiltle.text = self.articles[indexPath.row].title
        
        cell.auther.text = self.articles[indexPath.row].author
        cell.desc.text = self.articles[indexPath.row].articleDescription
        cell.time.text = self.articles[indexPath.row].source.name



        
        cell.articleImage.image = UIImage(named: "default")
        
        
        let imageUrl = URL(string: self.articles[indexPath.row].urlToImage ?? "")
        cell.articleImage.kf.setImage(with: imageUrl,
                                    placeholder: UIImage(named: "default") ,
                                    options: nil,
                                    progressBlock: nil)
    
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        
        var heightExpected = calculateHeight(inString: self.articles[indexPath.row].articleDescription ?? ""  ) + calculateHeight(inString: self.articles[indexPath.row].title ?? ""  )  + calculateHeight(inString: self.articles[indexPath.row].author ?? ""  );
        
        return heightExpected;
        

    }
    
    func calculateHeight(inString:String) -> CGFloat {
         let messageString = inString
        let attributes : [NSAttributedString.Key  : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15.0)]

         let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attributes)

         let rect : CGRect = attributedString.boundingRect(with: CGSize(width: 222.0, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

          let requredSize:CGRect = rect
          return requredSize.height
    }
    
    
}
            
    
    

extension HomeViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty){
            self.homeVM.getNews{ articles in
                self.articles = articles;
                self.newsTable.reloadData();
            }
        }
        else{
            print(searchText);
        self.homeVM.getSearch(query: searchText) { articles in
            self.articles = articles;
            self.newsTable.reloadData();
        }
        }
     
    }
}
