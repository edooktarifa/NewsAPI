//
//  NewsCellTableViewCell.swift
//  NewsApi
//
//  Created by Lawencon on 27/08/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import UIKit
import Kingfisher

class NewsCellTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
