//
//  DictationCtrlRequest.swift
//  petit
//
//  Created by Jz D on 2020/10/29.
//  Copyright © 2020 swift. All rights reserved.
//

import Foundation

typealias MainDataLan = (LanOpt, [CataLogDat])


extension HanDictationController{
    
    // id 都是 Int
    func text(list key: Int){
        Base.netHud.request(.get_text_cn(key)) { (result) in
            do{
                let data = try result.get().data
                // data.debug()
                let resp = try Base.decoder.decode(GeneralSingle<HanCatalog>.self, from: data)
                let model = resp.data
                self.catalog = model
                self.clickX = nil
                self.refresh()
            }
            catch{
                print(error)
            }
        }
    }
}
