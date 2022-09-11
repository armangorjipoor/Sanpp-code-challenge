//
//  BookmarkTabelVCell.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/19/1401 AP.
//

import UIKit

class BookmarkTabelVCell: UITableViewCell {

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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
