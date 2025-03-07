//
//  ListItem.swift
//  TravelBook
//
//  Created by Onur Bilke on 7.03.2025.
//

import UIKit

class CellListItem: UITableViewCell {
    
    @IBOutlet weak var imgPlace: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: ListItemModel) {
        txtTitle.text = model.title
        txtDescription.text = model.description
    }
}
