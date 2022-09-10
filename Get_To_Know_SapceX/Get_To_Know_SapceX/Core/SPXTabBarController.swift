//
//  SPXTabBarController.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/15/1401 AP.
//

import UIKit

class SPXTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let missionsVC = Missions_VC()
        let bookmarksVC = Bookmarks_VC()
        let missionNavigationController = UINavigationController()
        missionNavigationController.viewControllers = [missionsVC]
        
        let bookMarkNavigationController = UINavigationController()
        bookMarkNavigationController.viewControllers = [bookmarksVC]
        
        self.setViewControllers([missionNavigationController, bookMarkNavigationController], animated: true)
        
        guard let items = tabBar.items else { return }
        let icons = [UIImage(named: "missle"),
                     UIImage(systemName: "bookmark")]
        let titles = ["Missions", "Bookmarks"]
        for (index, item) in items.enumerated() {
            item.title = titles[index]
            item.image = icons[index]
        }
        
        self.tabBar.tintColor = .black
    }

}
