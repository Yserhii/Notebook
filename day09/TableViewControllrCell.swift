//
//  TableViewControllrCell.swift
//  day09
//
//  Created by Yolankyi SERHII on 7/6/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit
import yserhii2019

class ArticleTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var articles: [Article]?
    var langue: String = "en"
    let articleManager = ArticleManager()
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "addSegue", sender: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        langue = Locale.current.languageCode!
        articles = articleManager.getArticles(withLang: langue)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        articles = articleManager.getArticles(withLang: langue)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (articles?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        
        if (articles?[indexPath.row] != nil) {
            let currentArticle = articles![indexPath.row]
            cell.title.text = currentArticle.title
            if (currentArticle.creation_date != nil) {
                cell.createDate.text = format_date(date: currentArticle.creation_date!)
                cell.modifDate.text = format_date(date: currentArticle.modification_date!)
            }
            
            if cell.createDate.text == cell.modifDate.text! {
                cell.modifDate.isHidden = false
            }
                cell.img.image = (currentArticle.image != nil) ? UIImage(data: currentArticle.image! as Data) : nil
                cell.content.text = currentArticle.content
        }
        return cell
    }
    
    func format_date(date: NSDate) -> String  {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: date as Date)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd-MMM-yyyy"
        let myStringafd = formatter.string(from: yourDate!)
        return (myStringafd)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let evc = segue.destination as? addViewController {
            if (segue.identifier == "addSegue" && sender != nil) {
                evc.edit = true
                evc.article = sender as? Article
                evc.articleManager = self.articleManager
            }
            if (segue.identifier == "addSegue") {
                evc.articleManager = self.articleManager
            }
        }
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "addSegue", sender: articles![indexPath.row])
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            articleManager.removeArticle(article: articles![indexPath.row])
            articleManager.save()
            articles?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
}
