//
//  MissionDetail_VC.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/17/1401 AP.
//

import UIKit
import SDWebImage

class MissionDetail_VC: SPXBaseViewController {
    
    //For detail from Missions
    var mission: Mission.Doc?
    var smallImg: UIImage?
    
    private var missionDetail: MissionDetail!
    
    @IBOutlet weak var bookmarkBtn: BookmarkButton!
    @IBOutlet weak var wikiBtn: UIButton!
    @IBOutlet weak var videoBtn: UIButton!
    @IBOutlet weak var satelliteNameLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var satelliteImgView: UIImageView!
//    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bookmarkBtn.completion = { slctState in
            if slctState {
                print("Slc")
                self.showAlert(with: "Error", body: "Do you want to continue", actionTitle: "Ok", completion: { action in
                    print("Di this completion")
                })
            } else {
                print("Uns")
            }
            
        }
    }
    
    func setup() {
        if let mission = mission {
            missionDetail = MissionDetail(mission: mission)
            
            fillMissionDetailUI(with: missionDetail)
            if missionDetail.wikiURL == nil { wikiBtn.removeFromSuperview() }
            if missionDetail.videoURL == nil { videoBtn.removeFromSuperview() }
        }
        
        satelliteImgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
    }
    
    private func fillMissionDetailUI(with msn: MissionDetail) {
        satelliteNameLbl.text = msn.satelliteName
        satelliteImgView.sd_setImage(with: msn.largeImgURL)
        detailLbl.text = msn.detail
    }
    
    @IBAction func videoBtnTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func linkBtnTapped(_ sender: UIButton) {
        
        let webVC = WikiWeb_VC()
        webVC.url = missionDetail.wikiURL
        webVC.modalTransitionStyle = .coverVertical
        webVC.modalPresentationStyle = .overCurrentContext
        self.present(webVC, animated: true)
    }
}
