//
//  ErrorAlert.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 9/30/21.
//

import UIKit
protocol ErrorAlertControlling {
    func displayConnectionAlert()
    func displayHackingAlert()
    func displayUnknownIssueAlert()
}

extension ErrorAlertControlling where Self : UIViewController {
    func displayConnectionAlert() {
        displayAlert(message: "Our data center is under attack. There has been an issue with the connection.")
    }
    
    func displayHackingAlert() {
        displayAlert(message: "Our systems are being attacked. The data fetched was corrupted.")
    }
    
    func displayUnknownIssueAlert() {
        displayAlert(message: "We don't know what just happened. We are investigating the issue.")
    }
    
    func displayLimitedConnectivity() {
        displayAlert(message: "Seems like there is no service outside of earth, Search functionality is unavailable.")
    }
    
    private func displayAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

