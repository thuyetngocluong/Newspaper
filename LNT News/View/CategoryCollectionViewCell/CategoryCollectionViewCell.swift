//
//  CollectionViewCell.swift
//  LNT News
//
//  Created by Luong Ngoc Thuyet on 08/07/2021.
//

import UIKit


class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameCategoryLB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setValue(category: String) {
        self.nameCategoryLB.text = category
    }
}
