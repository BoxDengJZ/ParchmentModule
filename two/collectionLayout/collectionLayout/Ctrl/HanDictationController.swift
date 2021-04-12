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

        if let src = Bundle.main.url(forResource: "one", withExtension: "plist"){
            do {
                let data = try Data(contentsOf: src)
                // handle data
                let decoder = PropertyListDecoder()
                let resp = try decoder.decode(HanCatalog.self, from: data)
                self.catalog = resp
                self.clickX = nil
                self.refresh()
            } catch  {
                print(error)
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
