//
//  SPXBaseViewController.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/17/1401 AP.
//

import UIKit

class SPXBaseViewController: UIViewController {

    typealias Completion = (UIAlertAction) -> Void
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func showAlert(with title: String,
                   body: String,
                   actionTitle: String? = nil,
                   completion: @escaping Completion) {
        
        let alertcontroller = UIAlertController(title: title, message: body, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertcontroller.addAction(cancelAction)
        if let actionTitle = actionTitle {
            let okAction = UIAlertAction(title: actionTitle, style: .default, handler: completion)
            alertcontroller.addAction(okAction)
        }
        self.present(alertcontroller, animated: true)
    }

}
