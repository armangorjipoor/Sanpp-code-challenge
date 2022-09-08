//
//  MissionsTableVCell.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/16/1401 AP.
//

import UIKit
import SDWebImage

class MissionsTableVCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var fireDateLbl: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    
    var setResultState: Bool? {
        didSet {
            if let sucess = setResultState {
                if sucess {
                    resultLbl.text = "Success"
                    resultLbl.backgroundColor = .green
                } else {
                    resultLbl.text = "Fail"
                    resultLbl.backgroundColor = .red
                }
            } else {
                resultLbl.text = "Unknow"
                resultLbl.backgroundColor = .yellow
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
