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
    var largeImg: UIImage?
    
    private var missionDetail: MissionDetail!
    
    @IBOutlet weak var bookmarkBtn: BookmarkButton!
    @IBOutlet weak var wikiBtn: UIButton!
    @IBOutlet weak var videoBtn: UIButton!
    @IBOutlet weak var satelliteNameLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var satelliteImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bookmarkBtn.completion = { [weak self] slctState in
            guard let self = self else {return}
            if slctState {
                print("Slc")
                DataManager.shared.add(item: self.missionDetail)
                self.missionDetail.set(smallImage: self.smallImg ?? UIImage(),
                                       and: self.largeImg ?? UIImage())
            } else {
                print("Uns")
            }
            
        }
    }
    
    func setup() {
        bookmarkBtn.isEnabled = false
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
        satelliteImgView.sd_setImage(with: msn.largeImgURL,
                                     placeholderImage: nil,
                                     options: SDWebImageOptions.highPriority,
                                     context: nil,
                                     progress: nil
                                     , completed:{ [weak self ] downloadedImg, downloadedExptn, cachType, downloadURL in
            guard let self = self else {return}
            if downloadedExptn != nil {
                
            } else {
                self.largeImg = downloadedImg
                //Enable when download compeleted
                self.bookmarkBtn.isEnabled = true
                
            }
            
        })
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
    
    @IBAction func moreDetailBtnTap(_ sender: UIButton) {
        DataManager.shared.savedMissions.first!.getLargeImage { resu in
            print(resu)
        }
    }
}
