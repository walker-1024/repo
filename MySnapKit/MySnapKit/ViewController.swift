//
//  ViewController.swift
//  MySnapKit
//
//  Created by 刘菁楷 on 2020/11/9.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let box = UIView()
        box.backgroundColor = UIColor.blue
        view.addSubview(box)
        
        box.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalTo(200)
            make.leading.equalTo(100)
            make.centerY.equalToSuperview()
        }
    }


}
