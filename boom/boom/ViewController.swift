//
//  ViewController.swift
//  boom
//
//  Created by Jz D on 2021/4/12.
//

import UIKit

import Parchment


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        let firstViewController = UIViewController()
        let secondViewController = UIViewController()

        let pagingViewController = PagingViewController(viewControllers: [
          firstViewController,
          secondViewController
        ])
    }


}

