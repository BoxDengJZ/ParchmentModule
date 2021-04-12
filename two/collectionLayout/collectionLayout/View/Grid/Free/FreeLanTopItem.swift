//
//  LanTopV.swift
//  petit
//
//  Created by Jz D on 2020/10/26.
//  Copyright © 2020 swift. All rights reserved.
//

import UIKit


class FreeLanTopItem: UICollectionReusableView {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var express: UILabel!
    
    @IBOutlet weak var head: UIImageView!
    
    weak var delegate: LanTopProxy?
    
    var list = [String]()
    
    
    @IBOutlet weak var selectBtn: FreeLanTopBtn!
    
    
    
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
    
    
    
    func config(package press: String, name n: String, config src: String, book grade: String){
        express.text = press
        title.text = n
        
        if UI.std.special, press.count >= 8 {
            express.font = UIFont.regular(ofSize: 12)
        }
        else{
            express.font = UIFont.regular(ofSize: 15)
        }
        selectBtn.setTitle(grade, for: .normal)
        pic(config: src)
    }
    

    private
    func pic(config src: String){
        imgEmpty()
    }
    
    
    @IBAction
    func chooseBook(_ sender: UIButton){
        
        delegate?.comeBottomBooks()
        
    }
    
    
    
    private
    func imgEmpty(){
        head.image = UIImage(named: "dictation_empty")
        
    }
    
}







class FreeLanTopBtn: UIButton {

    
    
    let w: CGFloat = 16
    
    
    init() {
        fatalError()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setTitleColor(UIColor(rgb: 0x0080FF), for: .normal)
        titleLabel?.font = UIFont.regular(ofSize: 12)
        // titleLabel?.layer.debug()
        titleLabel?.textAlignment = .right
        setImage(UIImage(named: "6_triangle_free_top"), for: .normal)
        backgroundColor = UIColor(rgb: 0xEEF7FF)
        cornerHalf()
        
    }
    
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        
        let x = contentRect.minX + 2
        let y = contentRect.minY
        let width = contentRect.width - w - 2 - 16
        return CGRect(x: x, y: y, width: width, height: contentRect.height)
    }
    
    
    
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let x = contentRect.maxX - 16 - w
        let y = contentRect.minY + (contentRect.height - w) / 2
        return CGRect(x: x, y: y, width: w, height: w)
    }

    
    
    

}
