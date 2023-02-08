//
//  NewsOverviewTableViewController.swift
//  NewsProject
//
//  Created by MAC13 on 02.02.2023.
//

import UIKit
import Kingfisher

class NewsOverviewTableViewController: UITableViewController {
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNews{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func pullToRefresh(_ sender: Any) {
        loadNews{
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        
        let article = articleModel[indexPath.row]
        getImage(url: article.urlToImage, imageView: cell.imageNews)
        
        if article.isCheck == true {
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                cell.imageCheck.isHidden = false
            }
        } else {
            cell.imageCheck.isHidden = true
        }
        
        cell.titleNews.text = article.title
        cell.timeNews.text = article.publishedAt
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toContent", sender: indexPath)
        updateIsCheck(index: indexPath.row, isCheck: true)
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toContent" {
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as? ContentViewController)?.article = articleModel[indexPath.row]
                tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
            }
        }
    }
}
