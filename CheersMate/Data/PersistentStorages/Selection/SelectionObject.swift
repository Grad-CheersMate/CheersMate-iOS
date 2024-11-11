//
//  Realm.swift
//  CheersMate
//
//  Created by 재훈 on 11/9/24.
//

import Foundation
import RealmSwift

public final class SelectionObject: Object {
    @Persisted(primaryKey: true) var imageName: String
    @Persisted var desc: String
    @Persisted var isChecked: Bool
    @Persisted var type: String
    
    convenience init(imageName: String, desc: String, isChecked: Bool = false, type: PageType) {
        self.init()
        self.imageName = imageName
        self.desc = desc
        self.isChecked = isChecked
        self.type = type.rawValue
    } // closed init
    
} // closed SelectionRealm
