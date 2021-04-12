//
//  BookCatalog.swift
//  petit
//
//  Created by Jz D on 2020/10/29.
//  Copyright © 2020 swift. All rights reserved.
//

import Foundation

struct CataLogDat: Decodable{
    let books: [PieceBook]
    let publisher: String
    
    let version: String
}



struct PieceBook: Decodable{
    let k: Int
    
    let name: String
    
    
    private enum CodingKeys : String, CodingKey {
        case k = "id", name
    }
    
}



struct BookCatalog: Decodable{
    let texts: [BookListBrief]
    
    let version_name: String
    let publisher_name: String
    
    let book_image: String?
    let book_name: String
    

 
}



extension BookCatalog{

    var img: String{
        if let ca = book_image{
            return ca
        }
        else{
            return ""
        }
    }
    
}




struct BookListBrief: Decodable{
    let k: Int
    
    let preview: String
    let title: String
    
    private enum CodingKeys : String, CodingKey {
        case k = "id", preview, title
    }
    
}


struct RecorderPersist {
    let dat: EnterP_src
    let name: String
}



enum EnterP_src{
    case std(PlayPageHa)
    case custom(Int, LanOpt)
    case fun(Int, String?)
}



struct PlayPageHa {
    let kind: LanOpt
    let k: Int
}




struct ActivityGo: Decodable{
    
    let toHide: Bool
    
}




struct HanCatalog: Decodable{
    let texts: [HanListBrief]
    
    let version_name: String
    let publisher_name: String
    
    let book_image: String?
    let book_name: String
    
 
}

typealias SubNameInfo = (names: [String], cnt: Int)

extension HanCatalog{
    var subNameOreo: SubNameInfo{
        let titles = texts.map { (brief) -> String in
            return brief.name
        }
        return (titles, titles.count)
    }
}



struct HanListBrief: Decodable{
    let name: String
    let text: [TxtIntro]
}


struct TxtIntro: Decodable{
    let preview: String
    let author: String
    let k: Int
    
    let title: String
 
    
    private enum CodingKeys : String, CodingKey {
        case k = "id", preview, author, title
    }
}




struct FreeBrief: Decodable{
    let preview: String
    
    let author: String
    let id: Int
    
    let title: String
    let dynasty: String
    
 
}



extension Optional where Wrapped: Collection{
    var hasData: Bool{
        var has = false
        if let dat = self, dat.count > 0{
            has = true
        }
        return has
    }
    
    
    var validCnt: Int{
        var cnt = 1
        if let source = self{
            cnt = max(source.count, cnt)
        }
        return cnt
    }
}




