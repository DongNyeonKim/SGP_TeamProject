//
//  ECarNewsTableViewCell.swift
//  E_Vehicle_TeamProject
//
//  Created by kpugame on 2021/06/01.
//

import UIKit

class ECarNewsTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet var companyImage: UIImageView!
    
    @IBOutlet var title: UILabel!
    
    @IBOutlet var company: UILabel!
    
    @IBOutlet var time: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
