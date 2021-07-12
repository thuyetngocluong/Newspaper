//
//  CategoryCell.swift
//  NewspaperOnline
//
//  Created by Luong Ngoc Thuyet on 05/07/2021.
//  Copyright © 2021 thuyetln. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    
    func setData(text: String) {
        categoryLB.text = text
    }
    
}
