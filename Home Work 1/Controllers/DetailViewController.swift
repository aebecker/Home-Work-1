//
//  DetailViewController.swift
//  Home Work 1
//
//  Created by Anthony Becker on 12/21/18.
//  Copyright © 2018 Anthony Becker. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailPlayerView: YTPlayerView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let playerView = detailPlayerView {
                playerView.load(withVideoId: detail.id!)
            }
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
}
