//
//  LoadingViewController.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 10/2/21.
//

import UIKit

class LoadingIndicatorView: UIView {
    
    var loader = UIActivityIndicatorView(style: .large)
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor(white: 0, alpha: 0.7)

        loader.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loader)

        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: loader, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: loader, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        ])
    }
    
    func showLoadingIndicator(in viewController: UIViewController) {
        frame = viewController.view.frame
        viewController.view.addSubview(self)
        loader.startAnimating()
    }
    
    func hideLoadingIndicator() {
        loader.stopAnimating()
        removeFromSuperview()
    }
}
