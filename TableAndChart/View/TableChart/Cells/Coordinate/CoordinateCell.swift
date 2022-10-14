//
//  CoordinateCell.swift
//  TableAndChart
//
//  Created by Mikhail on 08.10.2022.
//

import UIKit

class CoordinateCell: UITableViewCell {

    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCoordinates(x: Double, y: Double) {
        xLabel.text = String(x)
        yLabel.text = String(y)
    }
}
