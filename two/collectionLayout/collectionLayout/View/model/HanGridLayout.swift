//
//  ScoreLibLayout.swift
//  musicSheet
//
//  Created by Jz D on 2020/7/29.
//  Copyright © 2020 Jz D. All rights reserved.
//

import UIKit

// 首页

class HanGridLayout: UICollectionViewLayout {
    

  override public var collectionViewContentSize: CGSize {
     CGSize(width: collectionViewWidth, height: contentHeight)
  }
  
  // MARK: - Properties

    
  private var contentHeight = CGFloat.zero
  private var cache = [CommonComponent: [IndexPath: UICollectionViewLayoutAttributes]]()
    
    
    
  private var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
  
  private var collectionViewHeight: CGFloat {
     collectionView!.frame.height
  }
  
  private var collectionViewWidth: CGFloat {
     collectionView!.frame.width
  }

    var oKey = false
  
    let layout = CommonLayout(head: 160)
}



// MARK: - LAYOUT CORE PROCESS
extension HanGridLayout {
  
  override public func prepare() {
     guard let collectionView = collectionView else {
         return
     }
    
     prepareCache()
     contentHeight = 0
     
     let headerH = layout.headSize.height
     let headerIP = IndexPath(item: 0, section: 0)
     let headerAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: CommonComponent.header.kind, with: headerIP)
      headerAttributes.frame = CGRect(x: 0, y: contentHeight, width: UI.std.width, height: headerH)
      var cellX: CGFloat = layout.contentEdge.left
        
      cache[.header]?[headerIP] = headerAttributes
      contentHeight += (headerH + layout.contentEdge.top)
      if oKey{
            let count = collectionView.numberOfItems(inSection: 0)
            for item in 0 ..< count {
                  let cellIndexPath = IndexPath(item: item, section: 0)
                  let attributes = UICollectionViewLayoutAttributes(forCellWith: cellIndexPath)
                
                attributes.frame = CGRect( x: cellX, y: contentHeight, width: layout.itemSize.width, height: layout.itemSize.height )
                  
                contentHeight += layout.exceed(origin: &cellX, limit: collectionViewWidth)
                  cache[.cell]?[cellIndexPath] = attributes
            }
            if count % 2 == 1{
                contentHeight += layout.itemSize.height
            }
      }
      else{
            let cellIndexPath = IndexPath(item: 0, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: cellIndexPath)
          
            attributes.frame = CGRect( x: cellX, y: contentHeight, width: UI.std.width, height: LanTopV_H.h )
            
            contentHeight += layout.itemSize.height
            cache[.cell]?[cellIndexPath] = attributes
      }
      contentHeight += layout.contentEdge.bottom
  }

    
    
  private func prepareCache() {
    cache.removeAll(keepingCapacity: true)
    cache[.cell] = [IndexPath: UICollectionViewLayoutAttributes]()
    cache[.header] = [IndexPath: UICollectionViewLayoutAttributes]()
  }
  

}









//MARK: - PROVIDING ATTRIBUTES TO THE COLLECTIONVIEW
extension HanGridLayout {
  
  public override func layoutAttributesForSupplementaryView(ofKind ComponentKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    switch ComponentKind {
    case CommonComponent.header.kind:
      return cache[.header]?[indexPath]
    default:
      return nil
    }
  }
  
  override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cache[.cell]?[indexPath]
  }
  

  override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let _ = collectionView else { return nil }
    
    visibleLayoutAttributes.removeAll(keepingCapacity: true)
    for (_, infos) in cache {
      for (_, attributes) in infos {
        attributes.transform = .identity
        
      
        if attributes.frame.intersects(rect) {

            visibleLayoutAttributes.append(attributes)
        }
      }
    }
    return visibleLayoutAttributes
  }
  

    

}


