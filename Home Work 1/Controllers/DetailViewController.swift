//
//  DetailViewController.swift
//  Home Work 1
//
//  Created by Anthony Becker on 12/21/18.
//  Copyright © 2018 Anthony Becker. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailPlayerView: UIView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    var webView: WKWebView?
    var webViewConfiguration = WKWebViewConfiguration()

    let apk1 = "AIzaSyAPm0cB8HZslY"
    let apk2 = "P1fL37U6TnXdLLOnteNAM"

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let _ = detailPlayerView, let wv =  webView{
 //               wv.loadHTMLString(script, baseURL: nil)
 //               wv.load(URLRequest(url: URL(string: "https://www.cnn.com")!))
                let myURL = URL(string: "https://www.youtube.com/embed/" + detail.id! + "?playsinline=1&amp;key=" + apk1 + apk2)
                var youtubeRequest = URLRequest(url: myURL!)
                youtubeRequest.setValue("com.mcrsys.Home-Work-1", forHTTPHeaderField: "X-Ios-Bundle-Identifier")

                wv.load(youtubeRequest)
            }
            if let label = detailDescriptionLabel {
                label.text = detail.snippet?.localised?.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        webViewConfiguration.allowsInlineMediaPlayback = true
        webView = WKWebView(frame: detailPlayerView.frame, configuration: webViewConfiguration)
        detailPlayerView.addSubview(webView!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }

    var detailItem: Video? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    let script = "<!DOCTYPE html>" +
    "<html>" +
    "<body>" +
    "<!-- 1. The <iframe> (and video player) will replace this <div> tag. -->" +
    "<div id=\"player\"></div>" +
    
    "<script>" +
    "// 2. This code loads the IFrame Player API code asynchronously." +
    "var tag = document.createElement('script');" +
    
    "tag.src = \"https://www.youtube.com/iframe_api\";" +
    "var firstScriptTag = document.getElementsByTagName('script')[0];" +
    "firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);" +
    
    "// 3. This function creates an <iframe> (and YouTube player)" +
    "//    after the API code downloads." +
    "var player;" +
    "function onYouTubeIframeAPIReady() {" +
    "player = new YT.Player('player', {" +
    "height: '390'," +
    "width: '640'," +
    "videoId: 'Ks-_Mh1QhMc'," +
    "events: {" +
    "'onReady': onPlayerReady," +
    "'onStateChange': onPlayerStateChange" +
    "}" +
    "});" +
    "}" +
    
    "// 4. The API will call this function when the video player is ready." +
    "function onPlayerReady(event) {" +
    "event.target.playVideo();" +
    "}" +
    
    "// 5. The API calls this function when the player's state changes." +
    "//    The function indicates that when playing a video (state=1)," +
    "//    the player should play for six seconds and then stop." +
    "var done = false;" +
    "function onPlayerStateChange(event) {" +
    "if (event.data == YT.PlayerState.PLAYING && !done) {" +
    "setTimeout(stopVideo, 6000);" +
    "done = true;" +
    "}" +
    "}" +
    "function stopVideo() {" +
    "player.stopVideo();" +
    "}" +
    "</script>" +
    "</body>" +
    "</html>"
}
