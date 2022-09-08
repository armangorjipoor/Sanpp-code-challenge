//
//  BookmarkButton.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/17/1401 AP.
//

import Foundation
import UIKit

class BookmarkButton: UIButton {
    
    typealias Completion = (Bool) -> Void
    
    private var slctedImg = UIImage(systemName: "bookmark.fill")
    private var unSlctedImg = UIImage(systemName: "bookmark")
        
    private var setSelected: Bool = false {
        didSet {
            if setSelected {
                self.setImage(slctedImg, for: .normal)
            } else {
                self.setImage(unSlctedImg, for: .normal)
            }
        }
    }
    
    var completion: Completion?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        setSelected = false
        self.addTarget(self, action: #selector(controlTapped), for: .touchUpInside)
    }
    
    @objc func controlTapped() {
        isSelected = !isSelected
        setSelected = isSelected
        completion!(isSelected)
    }
}
