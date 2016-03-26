//
//  TestRealmObject.swift
//  SAMPLE
//
//  Created by Craig Rhodes on 3/26/16.
//  Copyright © 2016 Spectator Publishing Company. All rights reserved.
//

import Foundation
import RealmSwift

class TestRealmObject: Object {
    
    dynamic var id: Int = 0
    dynamic var name: String = ""
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
