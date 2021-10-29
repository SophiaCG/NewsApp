//
//  ViewController.swift
//  News-App
//
//  Created by SCG on 10/25/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var tableView: UITableView!
    private var articles: Articles?

    override func viewDidLoad() {

        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        loadArticles()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        self.view.addSubview(tableView)
        super.viewDidLoad()

    }
        
    func loadArticles() {
        NetworkManager().getArticles { articles in
            self.articles = articles
            DispatchQueue.main.async {
                 self.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("\(indexPath.row). \(String(describing: articles?.articles[indexPath.row].title ?? ""))")
        let webVC = WebViewVC(webURL: articles?.articles[indexPath.row].url ?? "https://www.apple.com")
        webVC.modalPresentationStyle = .formSheet
        present(webVC, animated: true)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.articles.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleCell
        let currentLastItem = articles?.articles[indexPath.row]
        cell.article = currentLastItem
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 1
        let borderColor: UIColor = .systemGray6
        cell.layer.borderColor = borderColor.cgColor
        cell.clipsToBounds = true

        return cell
    }
}
