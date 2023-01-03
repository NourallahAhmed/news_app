//
//  home_view_controller.swift
//  news
//
//  Created by NourAllah Ahmed on 01/01/2023.
//


import UIKit
import NVActivityIndicatorView



protocol HomeProtocol {
    func checkNetwork ()
    func noData ()
    func showAlert()
    func handleSearchResult(articles : Array<Article> , isConnected : Bool)
    func handleGetNewsResult(articles : Array<Article> , isConnected : Bool)
}


class HomeViewController: UIViewController  {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var newsTable: UITableView!
    
    @IBOutlet weak var buttonsCollection: UICollectionView!
    
    let indicator = NVActivityIndicatorView(frame: CGRect(x: 50, y: 10, width: 100, height: 100),
                                        
        type: NVActivityIndicatorType.ballTrianglePath  ,
        color: UIColor.blue)
    
    private let suggestionTopics = ["WorldCup" , "Football" , "Cinema",  "Politics" ,"Education" , "Economic" , "Tourism" , "Health"  , "Fashion"]
    
    private var homeVM = HomeViewModel() ///todo: dependency injection
    
    
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.title = "Home"
        //MARK: delegates
        self.newsTable.delegate = self;
        self.newsTable.dataSource = self;

        self.newsTable.keyboardDismissMode = .onDrag
        
        
        self.buttonsCollection.delegate = self
        self.buttonsCollection.dataSource = self
        
        
        self.searchBar.delegate = self
        self.searchBar.endEditing(true)
        
        
        //MARK: setting 1 item in 1 row
        
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/4, height:  40)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 4
        layout.scrollDirection = .horizontal

        buttonsCollection.collectionViewLayout = layout
        
        
        
        //MARK: indicator
        indicator.center = self.view.center
        self.view.addSubview(indicator)

        indicator.startAnimating()

        //MARK: send api request
        
        
        homeVM.getNews { articles , isConnected in
            
            self.handleGetNewsResult(articles: articles , isConnected: isConnected)

            
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

extension HomeViewController : UITableViewDelegate , UITableViewDataSource{
   
    
  

 

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // this will turn on `masksToBounds` just before showing the cell
        cell.contentView.layer.masksToBounds = true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeVM.newsArticles.count;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomNewsTableViewCell
        
        
        
        
        cell.backgroundColor = .clear
        cell.layer.masksToBounds = true
        cell.layer.shadowOpacity = 0.23
        cell.layer.shadowRadius = 4
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowColor = UIColor.black.cgColor

        // add corner radius on `contentView`
        cell.contentView.backgroundColor = .white
        cell.contentView.layer.cornerRadius = 10
        
        
        
        
        cell.articlTitle.text = self.homeVM.newsArticles[indexPath.row].title

        cell.auther.text = self.homeVM.newsArticles[indexPath.row].author
        cell.desc.text = self.homeVM.newsArticles[indexPath.row].articleDescription
        cell.time.text = self.homeVM.newsArticles[indexPath.row].publishedAt
        cell.articleImage.image = UIImage(named: "default")

        let imageUrl = URL(string: self.homeVM.newsArticles[indexPath.row].urlToImage ?? "")
        cell.articleImage.sd_setImage(with: imageUrl , placeholderImage: UIImage(named: "default"))

        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->CGFloat
    {

        return UITableView.automaticDimension;

    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsScreen = self.storyboard?.instantiateViewController(identifier: "detailsScreen") as! ViewController
        detailsScreen.article = self.homeVM.newsArticles[indexPath.row]
        self.navigationController?.pushViewController(detailsScreen, animated: false)
     
    }
    

    
}
            
    
    
//MARK: SearchBar
extension HomeViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty){
            self.homeVM.getNews{ articles ,isConnected  in
                self.handleGetNewsResult(articles: articles , isConnected: isConnected)

            }
        }
        else{
            self.homeVM.getSearch(query: searchText) { articles , isConnected in
                self.handleSearchResult(articles: articles , isConnected: isConnected)
            }
        }
     
    }
}

    //MARK: CollectionView
extension HomeViewController : UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.suggestionTopics.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buttonCell", for: indexPath) as! CustomButtonCell
        cell.buttonName.text = self.suggestionTopics[indexPath.row]
        cell.buttonName.layer.masksToBounds = true
        cell.buttonName.layer.cornerRadius = 15
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        self.homeVM.getSearch(query: self.suggestionTopics[indexPath.row]) { articles , isConnected in
            self.handleSearchResult(articles: articles , isConnected: isConnected)
        }
           
    }
}


//MARK: Helper Functions




extension HomeViewController : HomeProtocol {
    func checkNetwork () {
        
        let imageViewBackground = UIImageView()
        imageViewBackground.image = UIImage(named: "offline")
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFit
        self.newsTable.backgroundView = imageViewBackground
        self.newsTable.reloadData()
        self.showAlert()

       }
    
    
    func noData () {
        
        let imageViewBackground = UIImageView()
        imageViewBackground.image = UIImage(named: "nodata")
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFit
        self.newsTable.backgroundView = imageViewBackground
        self.newsTable.reloadData()

       }
    func showAlert(){
        DispatchQueue.main.async {
            let alert : UIAlertController = UIAlertController(title: "ERROR", message: "Please check your internet connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
            self.present(alert , animated: true , completion: nil)
            
        }
        
    }
    
    func handleSearchResult(articles : Array<Article> , isConnected : Bool){
        if(isConnected == true){
            if(articles.isEmpty){
                self.noData()
            }
            else{
                self.newsTable.scrollToRow(at: IndexPath(row: 0, section: 0) , at: .top , animated: true)
                self.newsTable.reloadData();
            }
        }else{
            self.checkNetwork()
        }
    }
    
    
    func handleGetNewsResult(articles : Array<Article> , isConnected : Bool){
        if (isConnected == true ){
            
            if ( articles.isEmpty){
                self.noData()
                self.indicator.stopAnimating()
            }
            else{
                self.newsTable.separatorStyle = .none
                self.newsTable.rowHeight = UITableView.automaticDimension
                self.indicator.stopAnimating()
                self.newsTable.reloadData()
            }
            
        }
        else{
            self.indicator.stopAnimating()

            self.checkNetwork()
        }
    }

}
