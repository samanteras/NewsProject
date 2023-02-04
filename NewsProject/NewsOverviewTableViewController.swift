//
//  NewsOverviewTableViewController.swift
//  NewsProject
//
//  Created by MAC13 on 02.02.2023.
//

import UIKit
import RealmSwift

class NewsOverviewTableViewController: UITableViewController {
    
//    var realm = try! Realm()
//    var itemsList: CheckForList!

    
    class CheckList {
        var name: String
        var isChaeck: Bool
        init(name: String, isChaeck: Bool) {
            self.name = name
            self.isChaeck = isChaeck
        }
    }
    
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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return articles.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
      //  let correntItem = art![indexPath.row]
    
        
        let article = articles[indexPath.row]
        //articles.removeAll()
//        var checkList = UserDefaults.standard.dictionary(forKey: "checkList")
//        var checkContent = UserDefaults.standard.object(forKey: "checkList")
//        print(checkContent)
//        if let checkList = checkList {
//            for key in checkList.keys {
//                print(key)
//                if key == article.description {
//                    article.isCheck = true
//                }
//            }
//        }
        var isChecking: [Int:Any] {
            var returnCheckList: [Int:Any] = [:]
            for i in 0..<article.description.count {
                returnCheckList.updateValue(false, forKey: i)
            }
            return returnCheckList
        }
        if let url = URL(string: article.urlToImage) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    if image!.size.height > 100 && image!.size.width > 100 {
                        DispatchQueue.main.async {
                            cell.imageNews?.image = image
                        }
                    } else {
                        DispatchQueue.main.async {
                            cell.imageNews?.image = UIImage(named: "content")
                        }
                    }
                }
            }.resume()
        } else {
            DispatchQueue.main.async {
                cell.imageNews?.image = UIImage(named: "content")
            }
        }
//        try! realm.write {
//           // if let newsArray = json!["articles"] as? [Dictionary<String, Any>] {
//            for _ in 0..<article.description.count {
//                let item = CheckForList(value: ["isCheck":false])
//                    realm.add(item)
//                }
//            print(realm.objects(CheckForList.self))
//            //}
//        }
//        var items = realm.objects(CheckForList.self)
//        itemsList = items[indexPath.row]
        
     //   print(isChecking[indexPath.row])
     //   let currentItem = checkList[indexPath.row]
   //     var item = checkList[indexPath.row]
  //      item["isCompleted"] = item["isCompleted"] as? Bool ?? false
//        checkList[indexPath.row] = item
        if articles[indexPath.row].isCheck == true {
            cell.accessoryType = .checkmark
            
//            var item = checkList?[article.description]
//                item = !(item as? Bool ?? false)
//            checkList?[article.description] = item
//                UserDefaults.standard.set(checkList, forKey: "checkList")
//            UserDefaults.standard.synchronize()

//          //  UserDefaults.standard.set(checkList, forKey: "checkList")
        } else {
            cell.accessoryType = .none
        }
       //     let article = articles[indexPath.row]
        //cell.imageView?.image = article.urlToImage
        
        
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
            print(articles[indexPath.row].isCheck)
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

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
