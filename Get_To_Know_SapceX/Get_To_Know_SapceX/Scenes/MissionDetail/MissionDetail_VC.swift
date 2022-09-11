//
//  MissionDetail_VC.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/17/1401 AP.
//

import UIKit
import SDWebImage
import SafariServices

class MissionDetail_VC: SPXBaseViewController {
    
    //For detail from Missions
    var mission: Mission.Doc?
    var smallImg: UIImage?
    var largeImg: UIImage?
    // For bookmarks
    var savedMission: MissionDetail!

    private var missionDetail: MissionDetail!
    // MARK: - views
    @IBOutlet weak var bookmarkBtn: BookmarkButton!
    @IBOutlet weak var wikiBtn: UIButton!
    @IBOutlet weak var satelliteNameLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var satelliteImgView: UIImageView!
    
    //Detail Views
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var flghtNoLbl: UILabel!
    @IBOutlet weak var rocketLbl: UILabel!

    
    // MARK: -Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bookMarkAction()
    }
    
    // MARK: -Functions
    func bookMarkAction() {
        bookmarkBtn.completion = { [weak self] slctState in
                   guard let self = self else {return}
                   if slctState {
                       DataManager.shared.add(item: self.missionDetail)
                       self.missionDetail.set(smallImage: self.smallImg ?? UIImage(),
                                              and: self.largeImg ?? UIImage())
                       NotificationCenter.default.post(name: .didBookMarkAdded, object:
                       nil)
                   } else {
  
                   }
                   
               }
    }
    
    func setup() {
        fillUI()
    }
    
    private func fillUI() {
        if let mission = mission {
            missionDetail = MissionDetail(mission: mission)
            fillMissionDetailUI(with: missionDetail)
            if missionDetail.wikiURL == nil { wikiBtn.removeFromSuperview() }
        }
        if let savedMission = savedMission {
            fillSavedMissionUI(with: savedMission)
        }
    }
    
    private func fillSavedMissionUI(with msn: MissionDetail) {
        satelliteNameLbl.text = msn.satelliteName
        detailLbl.text = msn.detail
        bookmarkBtn.setSelected = true
        msn.getLargeImage{ result in
            switch result {
            case .success(let val):
                self.satelliteImgView.image = val.image
            case .failure(_):
                self.satelliteImgView.image = AppImages.image(for: .missionPlaceHldr)
            }
        }
    }
    
    /// Fill UI with mission recived from server
    /// - Parameter msn: MissionDetail Model created with Mission.Doc
    private func fillMissionDetailUI(with msn: MissionDetail) {
        bookmarkBtn.isEnabled = false
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
        dateLbl.text = Date.changeDateFormat(with: msn.mission.dateUTC)
        flghtNoLbl.text = String(msn.mission.flightNumber)
        rocketLbl.text = msn.mission.rocket
    }
    
    @IBAction func linkBtnTapped(_ sender: UIButton) {
        if let url = missionDetail.wikiURL {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            vc.delegate = self

            present(vc, animated: true)
        }
    }

}
