//
//  UTTop10API.swift
//  Home Work 1
//
//  Created by Anthony Becker on 12/23/18.
//  Copyright © 2018 Anthony Becker. All rights reserved.
//

import Foundation

class UTTop10API {
    
    func getTopTenVideos(targetURLString: String, searchText: String, apiKey: String, completion:@escaping ((_ videoList:VideoList?) -> Void)) {
        let queryItems = [URLQueryItem(name: "part", value: "snippet,id"),
//                          URLQueryItem(name: "videoCategoryId", value: videoCategoryId),
                          URLQueryItem(name: "chart", value:"mostPopular"),
                          URLQueryItem(name: "regionCode", value:"US"),
//                          URLQueryItem(name: "id", value:"Ks-_Mh1QhMc"),
                            URLQueryItem(name: "q", value:searchText),
                          URLQueryItem(name: "maxResults", value:"10"),
            
                          URLQueryItem(name: "key", value: apiKey)]

        let urlComps = NSURLComponents(string: targetURLString)!
        urlComps.queryItems = queryItems

        if let url = urlComps.url {
            var request = URLRequest(url: url)
            // Set header(s)
            request.setValue("com.mcrsys.Home-Work-1", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print(error)
                } else {
                    if let usableData = data {
                        let json = try? JSONSerialization.jsonObject(with: usableData, options: [])
                        if let jsonData = json as? [String:Any]? {
                            print(jsonData as Any)

                            if let error = jsonData?["error"] as? [String:Any] {
                                print(error)
                                DispatchQueue.main.async {
                                    completion(nil)
                                }
                                return // don't decode
                            }
                            let videoList = self.decode(json:jsonData)
                            DispatchQueue.main.async {
                                completion(videoList)
                            }
                        }
                    }
                }
            }
            task.resume() // technically "start"
        }
    }
    
    private func decode(json:[String:Any]?) -> VideoList? {
        
        var videos = [Video]()
        if let jsonData = json {
            var videoList = VideoList(kind: jsonData["kind"] as? String,
                                      etag: jsonData["etag"] as? String,
                                      pageInfo: jsonData["pageInfo"] as? [String:Int])
            let videoItems = jsonData["items"] as! [[String:Any]]
            for videoItem in videoItems {
                var id = ""
                var kind = ""
                if let anID = videoItem["id"] as? [String:Any] {
                    kind = anID["kind"] as! String
                    if !kind.contains("youtube#video") {
                        continue // channel ?
                    }
                    id = anID["videoId"] as! String
                } else {
                    id = videoItem["id"] as! String
                    kind = videoItem["kind"] as! String
                }
                var video = Video(kind: kind,
                                  etag: videoItem["etag"] as? String,
                                  id: id)
                
                let videoSnippet = videoItem["snippet"] as! [String:Any]
                let snippet = VideoSnippet(categoryId: videoSnippet["categoryId"] as? String,
                                           channelId: videoSnippet["channelId"] as? String,
                                           channelTitle: videoSnippet["channelTitle"] as? String,
                                           title: videoSnippet["title"] as? String,
                                           description: videoSnippet["description"] as? String,
                                           publishedAt: videoSnippet["publishedAt"] as? String)
                video.snippet = snippet
                
                if let videoLocalized = videoSnippet["localized"] as? [String:Any] {
                    let localized = VideoLocalized(title: videoLocalized["title"] as? String, description: videoLocalized["description"] as? String)
                    video.snippet?.localised = localized
                }

                let videoThumbnail = videoSnippet["thumbnails"] as! [String:Any]
                let defaultVideoThumbnail = videoThumbnail["default"] as! [String:Any]
                let thumbnail = VideoThumbnail(defaultURL: defaultVideoThumbnail["url"] as? String)
                video.snippet?.thumbnail = thumbnail

                if let videoContentDetails = videoItem["contentDetails"] as? [String:Any] {
                    let duration = videoContentDetails["duration"] as! String
                    let contentDetails = VideoContentDetails(duration: duration)
                    video.contentDetails = contentDetails
                }

                videos.append(video)
            }
            videoList.items = videos
            return videoList
        }
        return nil
    }
}
