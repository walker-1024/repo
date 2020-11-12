//
//  ViewController.swift
//  MyAlamofire
//
//  Created by 刘菁楷 on 2020/11/11.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        MyAlamofire.request("http://api.qingyunke.com/api.php?key=free&appid=0&msg=hello").responseJSON { response in
            switch response.result {
            case .success(let json):
                print(json)
            case .failure(let error):
                print(error)
            }
        }
        
        MyAlamofire.request("http://api.qingyunke.com/api.php?key=free&appid=0&msg=hello").responseString { response in
            switch response.result {
            case .success(let str):
                print(str)
            case .failure(let error):
                print(error)
            }
        }
        
    }


}

