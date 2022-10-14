//
//  TitleCell.swift
//  TableAndChart
//
//  Created by Mikhail on 08.10.2022.
//

import UIKit

class TitleCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
}
