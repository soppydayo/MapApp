//
//  PostData.swift
//  MapApp
//
//  Created by 白川創大 on 2023/05/23.
//

import Foundation
import RealmSwift

class Savedata: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var text: String = ""
  
}
