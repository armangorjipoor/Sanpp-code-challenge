//
//  Bookmarks_VC+Extension.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/19/1401 AP.
//

import Foundation
import UIKit

extension Bookmarks_VC: UITableViewDelegate, UITableViewDataSource {
    func registerTableViewCell() {
        self.tableView.register(UINib(nibName: "BookmarkTabelVCell", bundle: nil), forCellReuseIdentifier: "BookmarkCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkCell", for: indexPath) as? BookmarkTabelVCell else { return UITableViewCell() }
        
        cell.nameLbl.text = dataModel[indexPath.row].mission.name
        cell.fireDateLbl.text = Date.changeDateFormat(with: dataModel[indexPath.row].mission.dateUTC)
        cell.setResultState = dataModel[indexPath.row].mission.success
        dataModel[indexPath.row].getSmallImage{ result in
            switch result {
            case .success(let val):
                cell.iconImgView.image = val.image
            case .failure(let err):
                cell.iconImgView.image = UIImage()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailMissionVC = MissionDetail_VC()
        detailMissionVC.savedMission = dataModel[indexPath.row]
//        detailMissionVC.smallImg = smallImg
        self.navigationController?.pushViewController(detailMissionVC, animated: true)
    }

}
