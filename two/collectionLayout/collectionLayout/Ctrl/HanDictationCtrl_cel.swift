//
//  LanController_cel.swift
//  petit
//
//  Created by Jz D on 2020/10/26.
//  Copyright © 2020 swift. All rights reserved.
//

import Foundation

import UIKit

extension HanDictationController: UICollectionViewDelegate{
    
  
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case CommonComponent.header.kind:
            let top = collectionView.dequeue(header: HanLanTopV.self, ip: indexPath)
            top.delegate = self
            if let datum = catalog{
                top.config(package: datum.publisher_name, name: datum.book_name, config: datum.book_image, list: datum.subNameOreo, selected: topClickIdx)
            }
            else{
                top.beDefault()
            }
            return top
        default:
            return UICollectionReusableView()
        }
        
    }
}

extension HanDictationController: UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dat = catalog?.texts[topClickIdx].text
        return dat.validCnt
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        if hasDataX, let source = catalog{
            let dat = source.texts[topClickIdx].text
            let cel = collectionView.dequeue(cell: LanGrid.self, ip: indexPath)
            let datagram = dat[index]
            var toHideBottomWoX = true
            var fucArray = [Int]()
            let cnt = dat.count
            if cnt - 1 >= 0{
                fucArray += [cnt - 1]
            }
            if cnt - 2 >= 0, cnt % 2 == 0{
                fucArray += [cnt - 2]
            }
            if fucArray.contains(index){
                toHideBottomWoX = false
            }
            cel.config(package: datagram.title, below: datagram.preview, click: false, toHideBottom: toHideBottomWoX)
            return cel
        }
        else{
            return collectionView.dequeue(cell: EmptyContentCel.self, ip: indexPath)
        }
      
    }
    
    
    
    
    
    
    
    
}

