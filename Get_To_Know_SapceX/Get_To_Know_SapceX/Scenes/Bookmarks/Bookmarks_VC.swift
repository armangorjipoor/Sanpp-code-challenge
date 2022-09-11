//
//  BookMark_VC.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/15/1401 AP.
//

import UIKit

class Bookmarks_VC: UIViewController {

    //DataSource
    var dataModel = [MissionDetail]()
    
    
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        dataModel = DataManager.shared.savedMissions
        configTableView()
        registerTableViewCell()
        tableView.reloadData()
        setupNotificationObservers()
    }
    func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self,selector: #selector(onBookMArkAdded),
                                                                          name: Notification.Name.didBookMarkAdded,
                                                                          object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(onBookMarkRemoved),
                                                                          name: Notification.Name.didBookMarkAdded,
                                                                          object: nil)
    }
    
    @objc func onBookMArkAdded() {
        dataModel = DataManager.shared.savedMissions
        tableView.reloadData()
    }
    
    @objc func onBookMarkRemoved() {
        dataModel = DataManager.shared.savedMissions
        tableView.reloadData()
    }
    
    func configTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
