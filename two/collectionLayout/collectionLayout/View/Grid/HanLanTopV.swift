//
//  LanTopV.swift
//  petit
//
//  Created by Jz D on 2020/10/26.
//  Copyright © 2020 swift. All rights reserved.
//

import UIKit
import RxSwift

protocol LanTopProxy: class {
    func comeBottomBooks()
}


protocol LanItemTopProxy: class {
    func comeBottomBooks()
    func choose(idx index: Int)
}


struct LanTopV_H {
    static let h: CGFloat = 300
    
}


class HanLanTopV: UICollectionReusableView {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var express: UILabel!
    
    
    @IBOutlet weak var head: UIImageView!
    
    weak var delegate: LanItemTopProxy?
    
    @IBOutlet weak var midView: UIView!
    
    
    var list = [String]()
    
    lazy var scroll = UIScrollView()
    var names = [UILabel]()
    
    var bags = [Disposable]()
    
    lazy var line: UIView = {
        let l = UIView()
        l.backgroundColor = UIColor(rgb: 0x0080FF)
        l.isHidden = true
        return l
    }()
    
    override func awakeFromNib(){
        super.awakeFromNib()
        // Initialization code
        head.corner(8)
        
        head.contentMode = .scaleAspectFill
        if scroll.superview == nil{
            midView.addSubs([scroll])
        }
        if line.superview == nil{
            scroll.addSubs([line])
        }
        // scroll.layer.debug()
        scroll.showsHorizontalScrollIndicator = false
        scroll.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
    }
    
    
    
    func beDefault(){
        title.text = "您还没有选择课本"
        
        express.font = UIFont.regular(ofSize: 15)
        express.text = "点击选择课本"
        imgEmpty()
        
    }
    
    
    func config(package press: String, name n: String, config src: String?, list info: SubNameInfo, selected sIdx: Int){
        bags.forEach {
            $0.dispose()
        }
        names.forEach {
            $0.removeFromSuperview()
        }
        bags.removeAll()
        names.removeAll()
        express.text = press
        title.text = n
        
        if UI.std.special, press.count >= 8 {
            express.font = UIFont.regular(ofSize: 12)
        }
        else{
            express.font = UIFont.regular(ofSize: 15)
        }
        if let img = src{
            pic(config: img)
        }
        // print(info.names)
        let temps = info.names.map { (str) -> UILabel in
            let l = UILabel()
            l.text = str
            l.isUserInteractionEnabled = true
            l.textAlignment = .center
            l.textColor = UIColor(rgb: 0x404248)
            l.font = UIFont.regular(ofSize: 14)
            return l
        }
        names.append(contentsOf: temps)
        scroll.addSubs(names)
        
        for i in 0..<info.cnt{
            // names[i].layer.debug()
            let tagGesture = UITapGestureRecognizer()
            names[i].addGestureRecognizer(tagGesture)
            let bag = tagGesture.rx.event.subscribe { (t) in
                self.delegate?.choose(idx: i)
            }
            bags.append(bag)
            names[i].snp.makeConstraints { (m) in
                m.height.centerY.equalToSuperview()
                if i == 0{
                    m.leading.equalToSuperview().offset(16)
                }
                else{
                    m.leading.equalTo(names[i - 1].snp.trailing).offset(28)
                }
                if i == info.cnt - 1{
                    m.trailing.equalToSuperview().offset(16.neg)
                }
            }
        }
        names[sIdx].textColor = UIColor(rgb: 0x0080FF)
        names[sIdx].font = UIFont.semibold(ofSize: 14)
        midView.layoutIfNeeded()
        animate(idx: sIdx)
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
    
    
    @IBAction
    func chooseBook(_ sender: UIButton){
        
        delegate?.comeBottomBooks()
        
    }
    
    
    
    private
    func imgEmpty(){
        head.image = UIImage(named: "dictation_empty")
        
    }
    
    
    func animate(idx index: Int){
        UIView.animate(withDuration: 0.3) {
            let v = self.names[index]
            let f = v.frame
            self.line.frame = CGRect(x: f.origin.x, y: self.scroll.frame.maxY - 1, width: f.size.width, height: 1)
            self.midView.layoutIfNeeded()
        } completion: { (_) in
            self.line.isHidden = false
        }

        
    }
    
}
