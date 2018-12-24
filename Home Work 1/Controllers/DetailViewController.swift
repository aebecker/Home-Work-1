//
//  DetailViewController.swift
//  Home Work 1
//
//  Created by Anthony Becker on 12/21/18.
//  Copyright © 2018 Anthony Becker. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.snippet?.localised?.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: Video? {
        didSet {
            // Update the view.
            configureView()
        }
    }

//    if let range = strUrl.range(of: "=") {
//        let strIdentifier = strUrl.substring(from: range.upperBound)
//        let playerViewController = AVPlayerViewController()
//        self.present(playerViewController, animated: true, completion: nil)
//        XCDYouTubeClient.default().getVideoWithIdentifier(strIdentifier) {
//
//            [weak playerViewController] (video: XCDYouTubeVideo?, error: Error?) in
//            if let streamURLs = video?.streamURLs, let streamURL =
//                (streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ??
//                    streamURLs[YouTubeVideoQuality.hd720] ??
//                    streamURLs[YouTubeVideoQuality.medium360] ??
//                    streamURLs[YouTubeVideoQuality.small240]) {
//                playerViewController?.player = AVPlayer(url: streamURL)
//            } else {
//                self.dismiss(animated: true, completion: nil)
//            }
//        }
//    }

}
