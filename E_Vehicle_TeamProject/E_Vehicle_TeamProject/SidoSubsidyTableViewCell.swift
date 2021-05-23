//
//  SidoSubsidyTableViewCell.swift
//  E_Vehicle_TeamProject
//
//  Created by kpugame on 2021/05/24.
//

import UIKit

class SidoSubsidyTableViewCell: UITableViewCell {


    @IBOutlet var sidoLabel: UILabel!
    @IBOutlet var carSubsidyLabel: UILabel!
    @IBOutlet var scarSubsidyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
