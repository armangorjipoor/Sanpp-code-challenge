//
//  SPXActivityIndicator.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/17/1401 AP.
//

import Foundation
import UIKit

class SPXActivityIndicator: UIView {

    private var activityContainerView = UIView()
    private var activityIndicator =  UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    private let activityLabel = UILabel()
    private let activityStack = UIStackView()
    private let blurView = UIVisualEffectView()
    
    var activitySuperView: UIView!
    var label: String! {
        didSet {
            activityLabel.text = label
        }
    }
    
    init(in activitySuperView: UIView, label: String) {
        super.init(frame: CGRect.zero)
        self.activitySuperView = activitySuperView
        self.label = label
        setup()
    }
    
    private func setup() {
        activitySuperView.addSubview(self)
        self.frame = UIScreen.main.bounds
        configureViews()
        configureViewsLayout()
    }
    private func configureViews() {
        activityContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityContainerView)
        activityContainerView.backgroundColor = #colorLiteral(red: 0, green: 0.80400002, blue: 0.8119999766, alpha: 1)
        activityLabel.text = label
        activityLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        activityLabel.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        activityLabel.sizeToFit()
        
        blurView.effect = UIBlurEffect(style: .regular)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        activityContainerView.insertSubview(blurView, at: 0)

        activityIndicator.startAnimating()
        
        activityStack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityStack)
        activityStack.addArrangedSubview(activityIndicator)
        activityStack.addArrangedSubview(activityLabel)
        activityStack.axis = .vertical
        activityStack.alignment = .center
        activityStack.spacing = 4
        
        activityContainerView.layer.masksToBounds = true
        activityContainerView.clipsToBounds = true
        
    }
    
    private func configureViewsLayout() {
        // ActivityContainerView
        NSLayoutConstraint.activate([
            activityContainerView.widthAnchor.constraint(equalTo: activityLabel.widthAnchor, multiplier: 1.2),
            activityContainerView.heightAnchor.constraint(equalToConstant: 70),
            activityContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            blurView.widthAnchor.constraint(equalTo: activityLabel.widthAnchor, multiplier: 1.2),
            blurView.heightAnchor.constraint(equalToConstant: 70),
            blurView.centerYAnchor.constraint(equalTo: activityContainerView.centerYAnchor),
            blurView.centerXAnchor.constraint(equalTo: activityContainerView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.widthAnchor.constraint(equalToConstant: 30),
            activityIndicator.heightAnchor.constraint(equalToConstant: 30)
        ])
        // StackView
        NSLayoutConstraint.activate([
            activityStack.centerYAnchor.constraint(equalTo: activityContainerView.centerYAnchor),
            activityStack.centerXAnchor.constraint(equalTo: activityContainerView.centerXAnchor)
        ])
    }

    
    func stop() {
        if self.superview != nil {
            self.removeFromSuperview()
        }
    }
    override func layoutSubviews() {
        activityContainerView.layer.cornerRadius = 15
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
