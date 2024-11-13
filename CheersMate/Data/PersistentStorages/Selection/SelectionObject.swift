//
//  Realm.swift
//  CheersMate
//
//  Created by 재훈 on 11/9/24.
//

import Foundation
import RealmSwift

public final class SelectionObject: Object {
    @Persisted(primaryKey: true) var title: String
    @Persisted var desc: String
    @Persisted var type: String
    
    convenience init(title: String, desc: String, type: PageType) {
        self.init()
        self.title = title
        self.desc = desc
        self.type = type.rawValue
    } // closed init
    
} // closed SelectionRealm
