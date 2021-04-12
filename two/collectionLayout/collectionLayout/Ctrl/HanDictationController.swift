//
//  DictationController.swift
//  petit
//
//  Created by Jz D on 2020/10/22.
//  Copyright © 2020 swift. All rights reserved.
//

import UIKit


import SnapKit

import RxSwift
class HanDictationController: UIViewController {
   
    var topCurtainConstraint: ConstraintMakerEditable?
    
    let topHigh: CGFloat = 40
    
    var catalog: HanCatalog?

    lazy var h: SideHeader = {
        let cao = SideHeader(title: "语文课本")
        cao.delegate = self
        return cao
    }()
    
    
    var layoutHan = HanGridLayout()
    
    
    lazy var contentV: UICollectionView = {
        let collect = UICollectionView(frame: .zero, collectionViewLayout: layoutHan)
        collect.delegate = self
        collect.dataSource = self
        collect.register(cell: LanGrid.self)
        collect.register(cell: EmptyContentCel.self)
        collect.configureCommon()
        collect.register(header: HanLanTopV.self)
        return collect
    }()

    var topClickIdx = 0
    var clickX: Int?
    
    var bag: Disposable?
    
    
    var hasDataX: Bool{
        let ha = catalog?.texts[topClickIdx].text
        return ha.hasData
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        forUI()
        doEvents()
        if let k = Front_w_Persist.hanInfo{
            text(list: k.key)
        }
        loadDat(src: .ch, school: .primary){ (datum) in
            self.mark = datum
            self.bookChoose.update(ui: datum)
            if Front_w_Persist.hanInfo == nil, let piece = datum.first{
                    let cakes = piece.books
                    if let oreo = cakes.first{
                        self.text(list: oreo.k)
                    }
            }
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let cnt = navigationController?.viewControllers.count ?? 0
        if cnt == 0{
            bag?.dispose()
        }
    }
    
    
    func forUI(){
        layout_h()
        view.addSubs([contentV])
        contentV.snp.makeConstraints { (m) in
            m.leading.trailing.bottom.equalToSuperview()
            m.top.equalTo(h.snp.bottom)
        }


    }
    
    
    
    func doEvents(){
        bag = bookChoose.doneB.rx.tap.subscribe(onNext: { () in
            self.update(dataFu: self.bookChoose.chooseTb)
            self.goBottomBooks()
        })
        
        NotificationCenter.default.rx
            .notification(.refreshLanLabel)
            .takeUntil(self.rx.deallocated).subscribe(onNext: { (noti) in
                if let xxx = noti.object as? Int, let dat = self.catalog?.texts[self.topClickIdx].text, let index = dat.firstIndex(where: { (book) -> Bool in
                        book.k == xxx
                    }){
                        self.clickX = index
                        self.contentV.reloadData()
                    }
        }).disposed(by: rx.disposeBag)
    }
    
    
    func update(dataFu info: SelectedTb){
        guard let data = mark else {
            return
        }
        let book = data[info.lhs]
        let paper = book.books[info.rhs]
        topClickIdx = 0
        let content = "\(paper.name)\n\(book.publisher)"
        Front_w_Persist.saveInfo(kind: true, k: paper.k, detail: content, middle: false)
        text(list: paper.k)
    }
    

    
}



extension UICollectionView{
    func configureCommon(){
        allowsMultipleSelection = false
        delaysContentTouches = false
        isPrefetchingEnabled = false
        backgroundColor = UIColor(rgb: 0xF4F6FA)
        
        bounces = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    
    var bgOK: Bool{
        get{
            return false
        }
        set{
            if newValue{
                backgroundColor = UIColor(rgb: 0xF4F6FA)
            }
            else{
                backgroundColor = UIColor.white
            }
        }
    }
}
