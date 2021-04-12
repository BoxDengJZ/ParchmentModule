//
//  LanGrid.swift
//  
//
//  Created by Jz D on 2020/10/26.
//

import UIKit

class LanGrid: UICollectionViewCell {
    
    
    @IBOutlet weak var head: UILabel!
    
    
    @IBOutlet weak var detail: UILabel!
    
    
    @IBOutlet weak var tagImg: UIImageView!
    
    
    
    @IBOutlet weak var lineBelow: UIView!
    
    func config(package h: String, below txt: String, click tap: Bool, toHideBottom woRi: Bool){
        head.text = h
        detail.text = txt
        
        tagImg.isHidden = (tap == false)
        

        head.font = UIFont.semibold(ofSize: 16)
        
        lineBelow.isHidden = woRi
        if UI.std.special{
            let cnt = h.utf8.count
            if cnt > 36{
                head.font = UIFont.regular(ofSize: 14)
            }
            else if cnt > 21{
                head.font = UIFont.regular(ofSize: 15)
            }
            else{
                head.font = UIFont.regular(ofSize: 16)
            }
        }
        
        layoutIfNeeded()
        
    }
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tagImg.alpha = 0.7
        head.numberOfLines = 0
    }

}
