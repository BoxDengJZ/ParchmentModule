//
//  LanTopV.swift
//  petit
//
//  Created by Jz D on 2020/10/26.
//  Copyright © 2020 swift. All rights reserved.
//

import UIKit




protocol LanTopProxy: class {
    func comeBottomBooks()
    
    func doLanTopV(for act: Int)
}

struct LanTopV_actBundle {
    let act: LanTopV_act
    let from: LanOpt
}


enum LanTopV_act{
    case know, write, list
}



class LanTopV: UIView{

    
    lazy var desp: UILabel = {
        let l = UILabel()
        l.text = "我的课本"
        l.textColor = UIColor(rgb: 0x1A1B1C)
        l.font = UIFont.semibold(ofSize: 16)
        return l
    }()
    
    lazy var title: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(rgb: 0x1A1B1C)
        l.font = UIFont.regular(ofSize: 18)
        return l
    }()
    
    
    
    lazy var express: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(rgb: 0x9397A1)
        l.font = UIFont.regular(ofSize: 14)
        return l
    }()
    
    
    lazy var head = UIImageView()
    
    lazy var chooseBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "3_top_switch"), for: .normal)
        return b
    }()
    
    
    weak var delegate: LanTopProxy?
    
    var list = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        head.corner(8)
        
        head.contentMode = .scaleAspectFill
        ///
        chooseBtn.rx.tap.subscribe { () in
            self.delegate?.comeBottomBooks()
        }.disposed(by: rx.disposeBag)
        
        doLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func doLayout(){
        
        addSubs([desp, head, title,
                 express, chooseBtn])
        
        desp.snp.makeConstraints { (m) in
            m.leading.equalToSuperview().offset(15)
            m.top.equalToSuperview().offset(15)
        }
        
        
        head.snp.makeConstraints { (m) in
            m.leading.equalToSuperview().offset(15)
            m.bottom.equalToSuperview().offset(15.neg)
            m.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        title.snp.makeConstraints { (m) in
            m.leading.equalTo(head.snp.trailing).offset(10)
            m.top.equalTo(head)
            m.trailing.equalTo(express)
        }
        
        express.snp.makeConstraints { (m) in
            m.leading.equalTo(head.snp.trailing).offset(10)
            m.bottom.equalTo(head)
            m.trailing.equalToSuperview().offset(15.neg)
        }
        
        
        chooseBtn.snp.makeConstraints { (m) in
            m.centerY.equalTo(head)
            m.trailing.equalToSuperview().offset(15.neg)
            m.size.equalTo(CGSize(width: 90, height: 28))
            
        }
    }
    
    
    
    func beDefault(list info: [String]){
        title.text = "您还没有选择课本"
        
        express.font = UIFont.regular(ofSize: 15)
        express.text = "点击选择课本"
        imgEmpty()
        config(list: info)
    }
    
    
    
    func config(package press: String, name n: String, list info: [String], config src: String){
        express.text = press
        title.text = n
        
        if UI.std.special, press.count >= 8 {
            express.font = UIFont.regular(ofSize: 12)
        }
        else{
            express.font = UIFont.regular(ofSize: 15)
        }
        config(list: info)
        pic(config: src)
    }
    
    private
    func config(list info: [String]){
        list.removeAll()
        list.append(contentsOf: info)
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
    
}

