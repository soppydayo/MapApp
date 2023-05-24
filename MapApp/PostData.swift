//
//  PostData.swift
//  MapApp
//
//  Created by 白川創大 on 2023/05/23.
//

import Foundation
import RealmSwift

class PostData: Object {
    
    @Persisted var title: String = ""
    @Persisted var text: String = ""
    @Persisted var date: Date = Date()
    
  
}
