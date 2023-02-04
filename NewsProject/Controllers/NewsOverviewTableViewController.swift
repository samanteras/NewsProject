//
//  NewsOverviewTableViewController.swift
//  NewsProject
//
//  Created by MAC13 on 02.02.2023.
//

import UIKit
import RealmSwift
import Kingfisher

class NewsOverviewTableViewController: UITableViewController {
    
    @IBAction func pullToRefresh(_ sender: Any) {
        loadNews {
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNews {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        
        let article = articles[indexPath.row]
        getImage(url: article.urlToImage, imageView: cell.imageNews)
        
        if articles[indexPath.row].isCheck == true {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
                cell.imageCheck.isHidden = false
            }
        } else {
            cell.imageCheck.isHidden = true
        }
        
        cell.titleNews.text = article.title
        cell.timeNews.text = article.publishedAt
        
        return cell
    }
    
    func updateIsCheck(index: Int, isCheck: Bool) {
        let article = articles[index]
        article.isCheck = isCheck
        articles[index] = article
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toContent", sender: indexPath)
        updateIsCheck(index: indexPath.row, isCheck: true)
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toContent" {
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as? ContentViewController)?.article = articles[indexPath.row]
                tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
            }
        }
    }
}
