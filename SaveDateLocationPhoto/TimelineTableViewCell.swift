//
//  TimelineTableViewCell.swift
//  SaveDateLocationPhoto
//
//  Created by Rimil Dey on 14/11/17.
//  Copyright © 2017 Rimil Dey. All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {

    // MARK: - when cell loads
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        selectedImageView.layer.cornerRadius = selectedImageView.frame.width * 0.1
        selectedImageView.layer.masksToBounds = true
    }
    
    // MARK: - outlets
    
    @IBOutlet weak var selectedImageView: UIImageView!

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var entryLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
}
