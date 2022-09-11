//
//  Missions_VC.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/17/1401 AP.
//

import UIKit
import UIScrollView_InfiniteScroll
import SDWebImage

class Missions_VC: SPXBaseViewController {
    
    //DataSource
    var dataModel = [Mission.Doc]()
    
    //TableView Pagination
    var currentPage: Int = 1
    let desiredLimit: Int = 20
    var totalPages: Int!
        
    var iconPlaceHolderImage = AppImages.image(for: .sattilePlaceHldr)
    
    //Views
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var failImgView: UIImageView!
    @IBOutlet weak var failLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        registerTableViewCell()
        prepareRequest(withPage: currentPage)
        tableView.infiniteScrollIndicatorView = UIView(frame: CGRect.zero)
        tableView.addInfiniteScroll { [self] (tableView) -> Void in
            if self.currentPage < totalPages {
            prepareRequest(withPage: self.currentPage)
            }
            tableView.finishInfiniteScroll()
        }
    }
    
    private func prepareRequest(withPage number: Int) {
        let actIndView = SPXActivityIndicator(in: view, label: "Fetching...")
        let req = Mission.Request(query: Mission.Query(upcoming: false), options: Mission.Options(limit: desiredLimit, page: number, sort: Mission.Sort(flightNumber: "desc")))
        Service.getMissions(request: req) { [weak self ] response in
            guard let self = self else {return}
            switch response {
            case .success(let suc):
                Util.UI {
                    actIndView.stop()
                    self.totalPages = suc.totalPages
                    suc.docs.forEach({ item in
                        self.dataModel.append(item)
                        print(item)
                    })
                    self.currentPage += 1
                    self.tableView.reloadData()
                }
            case .failure(_):
                Util.UI {
                    actIndView.stop()
                }
                print("Err")
            }
        }
    }
    
}
