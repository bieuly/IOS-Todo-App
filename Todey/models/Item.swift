//
//  Item.swift
//  Todey
//
//  Created by Billy Hoang on 2018-10-20.
//  Copyright © 2018 Billy Hoang. All rights reserved.
//

import Foundation

// Instead of doing both Encodable and Decodable, we could have just done Codable
class Item: Encodable, Decodable {
    var title: String = ""
    var done: Bool = false
}
