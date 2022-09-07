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
        self.viewControllers = [HomeViewController(), Bookmark_VC()]
    }

}
