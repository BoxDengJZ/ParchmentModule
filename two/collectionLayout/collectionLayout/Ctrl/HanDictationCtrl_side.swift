//
//  DictationCtrl_side.swift
//  petit
//
//  Created by Jz D on 2020/10/27.
//  Copyright © 2020 swift. All rights reserved.
//

import Foundation


extension HanDictationController: SideHeaderDelegate{
    
    
    func xForce() {
        navigationController?.popViewController(animated: true)
    }

}



extension HanDictationController: LanItemTopProxy{
    
    
    func choose(idx index: Int){
        topClickIdx = index
        clickX = nil
        refresh()
    }
    
    
    
    func refresh(){
        let ok = hasDataX
        layoutHan.oKey = ok
        contentV.bgOK = ok
        contentV.reloadData()
    }

}



