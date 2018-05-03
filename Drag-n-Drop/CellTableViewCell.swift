//
//  CellTableViewCell.swift
//  Drag-n-Drop
//
//  Created by Vitalii Obertynskyi on 5/2/18.
//  Copyright © 2018 Vitalii Obertynskyi. All rights reserved.
//

import UIKit

class CellTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
