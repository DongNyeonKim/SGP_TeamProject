//
//  AptChargeFeeCellTableViewCell.swift
//  E_Vehicle_TeamProject
//
//  Created by kpugame on 2021/05/23.
//

import UIKit

class AptChargeFeeCellTableViewCell: UITableViewCell {

    @IBOutlet var TimeLabel: UILabel!
    @IBOutlet var DetailTimeLabel: UILabel!
    @IBOutlet var FeeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
