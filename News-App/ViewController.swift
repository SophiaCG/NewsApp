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

        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        loadArticles()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(String(describing: articles?.articles[indexPath.row].title ?? ""))"
        return cell
    }
}
