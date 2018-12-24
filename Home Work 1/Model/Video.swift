//
//  Video.swift
//  Home Work 1
//
//  Created by Anthony Becker on 12/23/18.
//  Copyright © 2018 Anthony Becker. All rights reserved.
//

import Foundation

structure VideoList {
    var kind:String
    var etag:String
    var pageInfo:[String:Int]
    var items:[Video]
}
