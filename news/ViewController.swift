//
//  ViewController.swift
//  news
//
//  Created by NourAllah Ahmed on 01/01/2023.
//

import UIKit

class ViewController: UIViewController {
    var homeVM = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        homeVM.getNews { result in
            print(result.count)
            print(result.first)
        }
        
        
        
        homeVM.getTopHeaders { result in
            print(result.count)
            print(result.first)
        }
        
        homeVM.getSearch(query: "football"){ result in
            print(result.count)
            print(result.first)
        }
    }


}

