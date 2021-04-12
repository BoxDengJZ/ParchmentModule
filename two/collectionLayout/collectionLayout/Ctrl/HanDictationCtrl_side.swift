//
//  DictationCtrl_side.swift
//  petit
//
//  Created by Jz D on 2020/10/27.
//  Copyright © 2020 swift. All rights reserved.
//

import Foundation

extension UIViewController{
    func toLogin(){
        
        navigationController?.pushViewController(LoginController(), animated: true)
        
    }
    
    
    
    func vipRefresh(done completion: @escaping () -> Void){
        if UserSetting.shared.logined{
            Base.netHud.request(.get_vipstate){ (result) in
                do{
                    let data = try result.get().data
                    data.debug()
                    let resp = try Base.decoder.decode(GeneralSingle<V_Info>.self, from: data)
                    let info = resp.data
                    UserDefaults.std.isVIP = info.is_vip
                    UserDefaults.std.leftDays = info.left_days
                    UserDefaults.std.notSeven = (info.display_vip_button == false)
                    
                    UserDefaults.std.isExperimental = info.is_experience
                    UserDefaults.std.showLanTop = info.showLanTop
                    UserSetting.shared.expiration = info.expiration_time
                    NotificationCenter.default.post(name: .justLogined, object: nil)
                    completion()
                }
                catch{
                    print(error)
                }
            }
        }
        
        
    }
}


extension HanDictationController: SideHeaderDelegate{
    
    
    func xForce() {
        navigationController?.popViewController(animated: true)
    }

}



extension HanDictationController: LanItemTopProxy{
    

    
    func comeBottomBooks(){
        
      
        darkCurtain.love = bookChoose.kiss
        view.bringSubviewToFront(darkCurtain)
        view.bringSubviewToFront(bookChoose)
        darkCurtain.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.topCurtainConstraint?.constraint.update(offset: self.bookChoose.h.neg)
            self.view.layoutIfNeeded()
        }
    }
    
    func goBottomBooks(){
        darkCurtain.isHidden = true
        
        UIView.animate(withDuration: 0.3) {
            self.topCurtainConstraint?.constraint.update(offset: 0)
            self.view.layoutIfNeeded()
        }
    }
    
    
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




extension HanDictationController: SideMask{
    
    func hide(mask k: String) {
        switch k {
        case bookChoose.kiss:
            goBottomBooks()
        default:
            ()
        }
    }
    
    
    
}
