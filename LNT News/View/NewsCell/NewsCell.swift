//
//  NewsCell.swift
//  NewspaperOnline
//
//  Created by Luong Ngoc Thuyet on 05/07/2021.
//  Copyright © 2021 thuyetln. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {


    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var previewLB: UILabel!
    @IBOutlet weak var moreInfoLB: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var bookmarkBtn: UIButton!
    
    var item: ItemVNExpress!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if (traitCollection.userInterfaceStyle == .light) {
            view.layer.shadowColor = UIColor.systemGray.cgColor
            view.layer.shadowOpacity = 0.5
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.cornerRadius = 5
        } else {
            view.layer.shadowColor = UIColor.white.cgColor
            view.layer.shadowOpacity = 0.5
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.cornerRadius = 5
        }
    }
    
    
    @IBAction func clickedBookmarkBtn(_ sender: UIButton) {
        DispatchQueue(label: "bookmarkCoreData").async {
            if let _ = VNExpressCoreDataService.shared.findBookmarkedItem(title: self.item.title) {
                VNExpressCoreDataService.shared.unmarkBookmarkedItem(vnExpress: self.item) {
                    [weak self] in
                    if $0 {
                        DispatchQueue.main.async {
                            self?.bookmarkBtn.setImage(UIImage(systemName: "bookmark"), for: .normal)
                        }
                    }
                }
            } else {
                VNExpressCoreDataService.shared.markBookmarkedItem(vnExpress: self.item) {
                    [weak self] in
                    if $0 {
                        DispatchQueue.main.async {
                            self?.bookmarkBtn.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                        }
                    }
                }
            }
        }
        
    }
    
    func setData(newsItem: ItemVNExpress) {
        item = newsItem
        DispatchQueue(label: "bookmarkCoreData").async {
            if let _ = VNExpressCoreDataService.shared.findBookmarkedItem(title: newsItem.title) {
                DispatchQueue.main.async {
                    self.bookmarkBtn.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                }
            } else {
                DispatchQueue.main.async {
                    self.bookmarkBtn.setImage(UIImage(systemName: "bookmark"), for: .normal)
                }
            }
        }
        
        titleLB.text = newsItem.title
        previewLB.text = newsItem.itemDescription.toPreview
        moreInfoLB.text = "\(newsItem.pubDate.toDateAgo) giờ trước"
        ImageService.shared.getUIImage(url: newsItem.itemDescription.toLinkImage) {
            [weak self] _, uiImage in
            DispatchQueue.main.async {
                self?.imgView.image = uiImage
            }
        }
    }
    
    func setData(newsItem: VNExpressModel) {
        item = ItemVNExpress(title: newsItem.title, itemDescription: newsItem.itemDescription, pubDate: newsItem.pubDate, link: newsItem.link, guid: newsItem.guid, comments: newsItem.comments)
        
        bookmarkBtn.isHidden = true
        bookmarkBtn.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        
        titleLB.text = newsItem.title
        previewLB.text = newsItem.itemDescription.toPreview
        moreInfoLB.text = "\(newsItem.pubDate.toDateAgo) giờ trước"
        ImageService.shared.getUIImage(url: newsItem.itemDescription.toLinkImage) {
            [weak self] _, uiImage in
            DispatchQueue.main.async {
                self?.imgView.image = uiImage
            }
        }
    }
}
