//
//  MissionsTableVCell.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/16/1401 AP.
//

import UIKit

class MissionsTableVCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var fireDateLbl: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
