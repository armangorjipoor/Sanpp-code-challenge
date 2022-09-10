//
//  Missions_VC.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/17/1401 AP.
//

import UIKit
import UIScrollView_InfiniteScroll
import SDWebImage

enum FailMode {
    case noInterent
    case serverError
    case normal
    
}

class Missions_VC: SPXBaseViewController {
    
    let reachability = try! Reachability()

    //DataSource
    var dataModel = [Mission.Doc]()
    
    //TableView Pagination
    var currentPage: Int = 1
    let desiredLimit: Int = 60
    var totalPages: Int!
    
    var smallImg: UIImage?
    
    var iconPlaceHolderImage = UIImage(named: "MissionPLaceHolder")
    
    //Views
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var failImgView: UIImageView!
    @IBOutlet weak var failLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: .reachabilityChanged, object: reachability)
            do{
              try reachability.startNotifier()
            }catch{
              print("could not start reachability notifier")
            }
    }
    private func setup() {
        registerTableViewCell()
        prepareRequest(withPage: currentPage)
        tableView.infiniteScrollIndicatorView = UIView(frame: CGRect.zero)
        tableView.addInfiniteScroll { [self] (tableView) -> Void in
            prepareRequest(withPage: self.currentPage)
            tableView.finishInfiniteScroll()
        }
    }
    
    private func prepareRequest(withPage number: Int) {
        let actIndView = SPXActivityIndicator(in: view, label: "Fetching...")
        let req = Mission.Request(query: Mission.Query(upcoming: false), options: Mission.Options(limit: desiredLimit, page: number, sort: Mission.Sort(flightNumber: "desc")))
        Service.tempRequest(request: req) { [weak self ] response in
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
                    self.manageFaialbilty(state: .serverError)
                }
                print("Err")
            }
        }
    }
    
    func manageFaialbilty(state: FailMode) {
        switch state {
        case .noInterent:
            failImgView.image = UIImage(named: "NoInternet")
            failLbl.text = "Seems you are offline"
        case .serverError:
            failImgView.image = UIImage(named: "serverError")
            failLbl.text = "Somthing is wrong"
        case .normal:
            failImgView.isHidden = true
            failLbl.isHidden = true
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {

      let reachability = note.object as! Reachability

      switch reachability.connection {
      case .wifi:
          manageFaialbilty(state: .normal)
      case .cellular:
          manageFaialbilty(state: .normal)
      case .unavailable:
          manageFaialbilty(state: .noInterent)
      case .none:
          print("")
      }
    }
}
