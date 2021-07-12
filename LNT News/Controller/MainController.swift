//
//  ViewController.swift
//  NewspaperOnline
//
//  Created by Luong Ngoc Thuyet on 7/2/21.
//  Copyright © 2021 thuyetln. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var isReloadingData = false
    var isOpenHamburgerView = false
    var isOpenCollectionView = false
    var selectedCategory: VNExpressCategory = .trang_chu
    var listNews: [ItemVNExpress] = []
    var listCategory: [VNExpressCategory] = VNExpressCategory.allCases
    
    let refreshControl =  UIRefreshControl()
    
    @IBOutlet weak var hamburgerView: UIView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var contentTableView: UITableView!
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    @IBOutlet weak var fab: UIButton!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        print("appear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Trang Chủ"
        setupHamburgerView()
        setupTableView()
        setupCollectionView()
        setupFloatingActionButton()
    }
    
    func setupCollectionView() {
        categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionItem")
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
       
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: categoryCollectionView.bounds.width / 3, height: categoryCollectionView.bounds.height / 3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        categoryCollectionView.collectionViewLayout = layout
        categoryCollectionView.layer.cornerRadius = 10
        
        categoryCollectionView.isHidden = true
        categoryCollectionView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    }
    
    private func setupFloatingActionButton() {
        let transX = UIScreen.main.bounds.width - self.fab.frame.width / 2 - 10 - self.fab.center.x
        let transY = UIScreen.main.bounds.height - self.fab.frame.height / 2 - 10 - self.fab.center.y
        fab.transform = CGAffineTransform(translationX: transX, y: transY)
        fetchData(url: .trang_chu)
        fab.layer.cornerRadius = fab.layer.frame.width / 2
        fab.layer.shadowColor = UIColor.systemGray.cgColor
        fab.layer.shadowOpacity = 0.5
        fab.layer.shadowOffset = CGSize(width: 0, height: 0)
        fab.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:))))
        fab.alpha = 1
    }
    
    
    private func setupHamburgerView() {
        hamburgerView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width * 0.75, y: 0)
        
        self.view.setSwipeLeftGesture {
            if self.isOpenHamburgerView {
                self.closeHamburgerView()
            }
        }
        
        self.view.setSwipeRightGesture {
            if !self.isOpenHamburgerView {
                self.openHamburgerView()
            }
        }
    }
    
    @objc
    func refreshTableView() {
        if let urlNotNil = allVNExpressRss[selectedCategory] {
            VNExpressAPIService.shared.fetchData(url: urlNotNil) {
                [weak self] in
                self?.listNews = $1
                DispatchQueue.main.async {
                    self?.contentTableView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    private func setupTableView() {
        
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        
        contentTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsItem")
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.backgroundView = refreshControl
        
        
        
        categoryTableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryItem")
        categoryTableView.rowHeight = 50
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
    }
    
    func fetchData(url: VNExpressCategory) {
        listNews.removeAll()
        contentTableView.reloadData()
        if let urlNotNil = allVNExpressRss[url] {
            VNExpressAPIService.shared.fetchData(url: urlNotNil) {
                [weak self] in
                self?.listNews = $1
                DispatchQueue.main.async {
                    self?.contentTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func clickedFloatingActionButton(_ sender: UIButton) {
        !isOpenCollectionView ? openCategoryCollectionView() : closeCategoryCollectionView()
    }
   
    @IBAction func clickedHamburgerButton(_ sender: Any) {
        !isOpenHamburgerView ? openHamburgerView() : closeHamburgerView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
       
        if isOpenCollectionView && touch.view != categoryCollectionView {
            closeCategoryCollectionView()
        }
        
        if isOpenHamburgerView && touch.view != hamburgerView {
            closeHamburgerView()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let view = segue.destination as? BookmarkViewController, segue.identifier == "showBookmark" {
            view.contentTableView =  self.contentTableView
        }
    }
}
