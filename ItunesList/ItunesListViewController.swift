//
//  ViewController.swift
//  ItunesList
//
//  Created by Balaji Peddaiahgari on 6/18/19.
//  Copyright © 2019 Balaji Peddaiahgari. All rights reserved.
//

import UIKit

class ItunesListViewController: UITableViewController {
    
    private var nameArray = [String]()
    private var typeArray = [String]()
    private var imgURLArray = [String]()
    private let urlString = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/explicit.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "custom")
        downloadJsonWithURL(named: urlString)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
    }
    
    func downloadJsonWithURL(named: String) {
        let url = URL(string: named)
        URLSession.shared.dataTask(with: url!, completionHandler: { [weak self] (data, response, error) -> Void in
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                if let feedObject = jsonObj.value(forKey: "feed") as? NSDictionary, let resultArray = feedObject.value(forKey: "results") as? NSArray {
                    for result in resultArray {
                        if let result = result as? NSDictionary {
                            if let name = result.value(forKey: "name") {
                                self?.nameArray.append(name as! String)
                            }
                            if let kind = result.value(forKey: "kind") {
                                self?.typeArray.append(kind as! String)
                            }
                            if let imageURL = result.value(forKey: "artworkUrl100") {
                                self?.imgURLArray.append(imageURL as! String)
                            }
                        }
                    }
                }
                OperationQueue.main.addOperation({
                    self?.tableView.reloadData()
                })
            }
        }).resume()
    }
}

extension ItunesListViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "custom") as! CustomCell
        cell.name = nameArray[indexPath.row]
        cell.type = typeArray[indexPath.row]
        let imageURL = URL(string: imgURLArray[indexPath.row])
        cell.mainImageView.load(url: imageURL!)
        cell.layoutSubviews()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
}

