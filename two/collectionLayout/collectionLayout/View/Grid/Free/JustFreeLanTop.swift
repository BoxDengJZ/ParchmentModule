//
//  LanTopV.swift
//  petit
//
//  Created by Jz D on 2020/10/26.
//  Copyright © 2020 swift. All rights reserved.
//

import UIKit


protocol JustFreeTopProxy: class{
    func choose(index idx: Int)
}



class JustFreeLanTop: UICollectionReusableView {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var express: UILabel!
    
    @IBOutlet weak var head: UIImageView!
    
    weak var delegate: JustFreeTopProxy?
    
    
    @IBOutlet weak var lhsBtn: UIButton!
    
    
    @IBOutlet weak var midBtn: UIButton!
    
    @IBOutlet weak var rhsBtn: UIButton!
    
    @IBOutlet weak var line: UIView!
    
    
    @IBOutlet weak var lineCenterX_constraint: NSLayoutConstraint!
    
    var topIdx = 0
    
    
    override func awakeFromNib(){
        super.awakeFromNib()
        // Initialization code
        head.corner(8)
        
        head.contentMode = .scaleAspectFill
        ///
        
        lineCenterX_constraint.constant = UI.std.width / (-3)
        layoutIfNeeded()
    }
    
    
    
    func beDefault(){
        title.text = "您还没有选择课本"
        
        express.font = UIFont.regular(ofSize: 15)
        express.text = "点击选择课本"
        imgEmpty()

    }
    
    
    
    func configure(package press: String, name n: String, config src: String, choose row: Int){
        express.text = press
        title.text = n
        
        if UI.std.special, press.count >= 8 {
            express.font = UIFont.regular(ofSize: 12)
        }
        else{
            express.font = UIFont.regular(ofSize: 15)
        }
        pic(config: src)
        let bs = [lhsBtn, midBtn, rhsBtn]
        bs.forEach {
            $0?.dftJustFree()
        }
        topIdx = row
        bs[row]?.chooseJustFree()
        
        
    }
    
    

    private
    func pic(config src: String){
        if src == ""{
            imgEmpty()
        }
        else{
            head.kf.imgP(with: src, wait: "dictation_empty")
        }
    }
    
    
    private
    func imgEmpty(){
        head.image = UIImage(named: "dictation_empty")
        
    }
    
    
    
    @IBAction func lhsClick(_ sender: Any) {
        guard topIdx != 0 else {
            return
        }
        delegate?.choose(index: 0)
        UIView.animate(withDuration: 0.3) {
            self.lineCenterX_constraint.constant = UI.std.width / (-3)
            self.layoutIfNeeded()
        }
    }
    
    
    
    
    @IBAction func midClick(_ sender: Any) {
        guard topIdx != 1 else {
            return
        }
        delegate?.choose(index: 1)
        UIView.animate(withDuration: 0.3) {
            self.lineCenterX_constraint.constant = 0
            self.layoutIfNeeded()
        }
    }
    
    
    
    @IBAction func rhsClick(_ sender: Any) {
        guard topIdx != 2 else {
            return
        }
        delegate?.choose(index: 2)
        UIView.animate(withDuration: 0.3) {
            self.lineCenterX_constraint.constant = UI.std.width / 3
            self.layoutIfNeeded()
        }
    }
}




extension UIButton{

    func chooseJustFree(){
        setTitleColor(UIColor(rgb: 0x0080FF), for: .normal)
    }
    
    func dftJustFree(){
        setTitleColor(UIColor(rgb: 0x404248), for: .normal)
    }
}

