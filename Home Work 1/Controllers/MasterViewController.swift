//
//  MasterViewController.swift
//  Home Work 1
//
//  Created by Anthony Becker on 12/21/18.
//  Copyright © 2018 Anthony Becker. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var tableObjects = [Video]()

    let endPoint = "https://www.googleapis.com/youtube/v3/videos"
    let apiKey = "AIzaSyAPm0cB8HZslYP1fL37U6TnXdLLOnteNAM"
    let videoCategoryId = "1" // Top 10 of film
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
//        let youTubeURLString = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(playListId)&key=\(apiKey)"        
        UTTop10API().getTopTenVideos(targetURLString: endPoint, videoCategoryId: videoCategoryId, apiKey: apiKey, completion: {
            videoList in
            
                if let videoList = videoList {
                    self.tableObjects = videoList.items
                    self.tableView.reloadData()
                } else {
                    // else popup bad data
                    self.messageBox(messageTitle: "Bad Request",
                                    messageAlert: "Error from video list request",
                                    messageBoxStyle: .alert,
                                    alertActionStyle: .default,
                                    completionHandler: {})
                }
            
            })
    }
    
    private func messageBox(messageTitle: String,
                            messageAlert: String,
                            messageBoxStyle: UIAlertController.Style,
                            alertActionStyle: UIAlertAction.Style,
                            completionHandler: @escaping () -> Void)
    {
        let alert = UIAlertController(title: messageTitle, message: messageAlert, preferredStyle: messageBoxStyle)
        
        let okAction = UIAlertAction(title: "Ok", style: alertActionStyle) { _ in
            completionHandler() // This will only get called after okay is tapped in the alert
        }
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }


    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    @objc
    func insertNewObject(_ sender: Any) {
//        objects.insert(NSDate(), at: 0)
//        let indexPath = IndexPath(row: 0, section: 0)
//        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = tableObjects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableObjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath)

        let object = tableObjects[indexPath.row]
 //       cell.textLabel!.text = object.snippet?.localised?.title
        if let titleLable = cell.viewWithTag(1) as? UILabel {
            titleLable.text = object.snippet?.localised?.title
        }
        if let imageView = cell.viewWithTag(2) as? UIImageView {
            DispatchQueue.global().async { // [weak self] in
                if let data = try? Data(contentsOf: URL(string: object.snippet?.thumbnail?.defaultURL ?? "")! ) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            imageView.image = image
                        }
                    }
                }
            }
        }
        if let channelTitleLable = cell.viewWithTag(3) as? UILabel {
            channelTitleLable.text = object.snippet?.channelTitle
        }
        if let durationLable = cell.viewWithTag(4) as? UILabel {
            durationLable.text = object.contentDetails?.duration
        }
        if let publishedAtLable = cell.viewWithTag(5) as? UILabel {
            let dateFormatterIn = DateFormatter()
            dateFormatterIn.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
            
            let dateFormatterOut = DateFormatter()
            dateFormatterOut.dateFormat = "MMM dd, yyyy"
            
            let date: Date? = dateFormatterIn.date(from: object.snippet?.publishedAt ?? "")
            publishedAtLable.text = dateFormatterOut.string(from: date!)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableObjects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}
