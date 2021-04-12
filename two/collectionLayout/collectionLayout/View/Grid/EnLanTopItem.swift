//
//  LanTopV.swift
//  petit
//
//  Created by Jz D on 2020/10/26.
//  Copyright © 2020 swift. All rights reserved.
//

import UIKit


class EnLanTopItem: UICollectionReusableView {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var express: UILabel!
    
    @IBOutlet weak var head: UIImageView!
    
    var list = [String]()
    
    override func awakeFromNib(){
        super.awakeFromNib()
        // Initialization code
        head.corner(8)
        
        head.contentMode = .scaleAspectFill
        ///
    }
    
    
    
    func beDefault(){
        title.text = "您还没有选择课本"
        
        express.font = UIFont.regular(ofSize: 15)
        express.text = "点击选择课本"
        imgEmpty()

    }
    
    
    
    func config(package press: String, name n: String, config src: String){
        express.text = press
        title.text = n
        
        if UI.std.special, press.count >= 8 {
            express.font = UIFont.regular(ofSize: 12)
        }
        else{
            express.font = UIFont.regular(ofSize: 15)
        }
     
        imgEmpty()
    }
    
    
    private
    func imgEmpty(){
        head.image = UIImage(named: "dictation_empty")
        
    }
    
}
