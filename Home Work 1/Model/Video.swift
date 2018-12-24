//
//  Video.swift
//  Home Work 1
//
//  Created by Anthony Becker on 12/23/18.
//  Copyright © 2018 Anthony Becker. All rights reserved.
//

import Foundation

struct VideoList {
    var kind:String?
    var etag:String?
    var pageInfo:[String:Int]?
    var items:[Video]
    
    init(kind:String?, etag:String?, pageInfo:[String:Int]?) {
        self.kind = kind
        self.etag = etag
        self.pageInfo = pageInfo
        self.items = []
    }
}

struct Video {
    var kind:String?
    var etag:String?
    var id:String?
    var snippet:VideoSnippet?
    var contentDetails:VideoContentDetails?

    init(kind:String?, etag:String?, id:String?) {
        self.kind = kind
        self.etag = etag
        self.id = id
    }
}

struct VideoSnippet {
    var categoryId:String?
    var channelId:String?
    var channelTitle:String?
    var title:String?
    var description:String?
    var publishedAt:String?
    var localised:VideoLocalized?
    var thumbnail:VideoThumbnail?

    init(categoryId:String?, channelId:String?, channelTitle:String?, title:String?, description:String?, publishedAt:String?) {
        self.categoryId = categoryId
        self.channelId = channelId
        self.channelTitle = channelTitle
        self.title = title
        self.description = description
        self.publishedAt = publishedAt
    }
}

struct VideoLocalized {
    var description:String?
    var title:String?
    init(title:String?, description:String?) {
        self.title = title
        self.description = description
    }
}

struct VideoThumbnail {
    var defaultURL:String?
    
    init(defaultURL:String?) {
        self.defaultURL = defaultURL
    }
}

struct VideoContentDetails {
    var duration:String?
    
    init(duration:String?) {
        self.duration = duration
    }
}
