//
//  ControllerExtension.swift
//  NewspaperOnline
//
//  Created by Luong Ngoc Thuyet on 05/07/2021.
//  Copyright © 2021 thuyetln. All rights reserved.
//

import UIKit
import SafariServices

extension MainController {
    
    func openHamburgerView() {
        if isOpenHamburgerView { return }
        self.isOpenHamburgerView = true
        UIView.animate(withDuration: 0.3) {
            self.mainView.isUserInteractionEnabled = false
            self.hamburgerView.transform = .identity
            self.mainView.alpha = 0.5
        }
    }
    
    func closeHamburgerView() {
        if !isOpenHamburgerView { return }
        self.isOpenHamburgerView = false
        UIView.animate(withDuration: 0.3) {
            self.mainView.isUserInteractionEnabled = true
            self.hamburgerView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width * 0.75, y: 0)
            self.mainView.alpha = 1
        }
    }
    
    func openCategoryCollectionView() {
        if isOpenCollectionView { return }
        isOpenCollectionView = true
        self.mainView.isUserInteractionEnabled = false
        self.hamburgerView.isUserInteractionEnabled = false
        self.categoryCollectionView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.categoryCollectionView.transform = .identity
        }
    }
    
    func closeCategoryCollectionView() {
        if !isOpenCollectionView { return }
        isOpenCollectionView = false
      
        UIView.animate(withDuration: 0.3, animations: {
            self.categoryCollectionView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }) { _ in
            self.mainView.isUserInteractionEnabled = true
            self.hamburgerView.isUserInteractionEnabled = true
            self.categoryCollectionView.isHidden = true
        }
    }
    
    @objc
    func handlePanGesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
            case.began:
                self.mainView.isUserInteractionEnabled = false
            case .changed:
                let translation = gesture.translation(in: self.view)
                fab.center = CGPoint(x: fab.center.x + translation.x, y: fab.center.y + translation.y)
                gesture.setTranslation(CGPoint.zero, in: self.view)
            case .ended:
                UIView.animate(withDuration: 0.3) {
                    let trailing = UIScreen.main.bounds.width - self.fab.frame.width / 2 - 10 - self.fab.center.x
                    let leading = self.fab.frame.width / 2 + 10 - self.fab.center.x
                    
                    let top = UIScreen.main.bounds.height - self.mainView.bounds.height + self.fab.frame.height / 2 + 10
                    let bottom = UIScreen.main.bounds.height - self.fab.frame.height / 2 - 10
                    
                    let transX = self.fab.center.x < UIScreen.main.bounds.width / 2 ? leading : trailing
                    
                    var transY: CGFloat = 0
                    if self.fab.center.y <= top {
                        transY = top - self.fab.center.y
                    } else
                    if self.fab.center.y >= bottom {
                        transY = bottom - self.fab.center.y
                    }
                    
                    self.fab.transform = CGAffineTransform(translationX: transX, y: transY)
                }
                
                self.mainView.isUserInteractionEnabled = true
        default:
            break
        }
    }
}

extension MainController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == contentTableView ? listNews.count : listCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == contentTableView) {
            let newsItem = listNews[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsItem", for: indexPath) as! NewsCell
        
            cell.setData(newsItem: newsItem)
            return cell
        } else {
            let category = listCategory[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryItem", for:  indexPath) as! CategoryCell
            cell.backgroundColor = selectedCategory == category ? .lightGray : .none
            cell.setData(text: category.rawValue)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if tableView == contentTableView, let url = URL(string:  listNews[indexPath.row].link) {
            self.present(SFSafariViewController(url: url), animated: true, completion: nil)
        } else
        if tableView == categoryTableView {
            let category = listCategory[indexPath.row]
            title = category.rawValue
            closeHamburgerView()
            fetchData(url: category)
            selectedCategory = category
            tableView.reloadData()
        }
    }
}

extension MainController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = listCategory[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionItem", for: indexPath) as! CategoryCollectionViewCell
        cell.backgroundColor = selectedCategory == category ? .lightGray : .none
        cell.setValue(category: category.rawValue)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = listCategory[indexPath.row]
        title = category.rawValue
        fetchData(url: category)
        selectedCategory = category
        
        closeCategoryCollectionView()
        
        collectionView.reloadData()
    }
    
}
