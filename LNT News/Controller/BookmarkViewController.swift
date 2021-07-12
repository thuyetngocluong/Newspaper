//
//  BookmarkViewController.swift
//  LNT News
//
//  Created by Luong Ngoc Thuyet on 12/07/2021.
//

import UIKit
import SafariServices

class BookmarkViewController: UIViewController {

    var listBookmark: [VNExpressModel] = []
    var contentTableView: UITableView?
    
    @IBOutlet weak var bookmarkTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        
        fetchData()
        bookmarkTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "bookmarkItem")
        bookmarkTableView.delegate = self
        bookmarkTableView.dataSource = self
    }
    
    func fetchData() {
        DispatchQueue(label: "bookmarkCoreData").async {
            self.listBookmark = VNExpressCoreDataService.shared.fetchAllBookmarkedItem()
        }
    }
    
    @IBAction func clickedBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        if let tableView = contentTableView {
            tableView.reloadData()
        }
    }
}

extension BookmarkViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBookmark.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = listBookmark[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkItem", for: indexPath) as! NewsCell
        
        cell.setData(newsItem: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let url = URL(string: listBookmark[indexPath.row].link) {
            self.present(SFSafariViewController(url: url), animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Xoá") {_,_,_ in
                VNExpressCoreDataService.shared.unmarkBookmarkedItem(vnExpressModel: self.listBookmark[indexPath.row]) { success in
                    if success {
                        self.listBookmark.remove(at: indexPath.row)
                        tableView.reloadData()
                    }
                }
            }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}
