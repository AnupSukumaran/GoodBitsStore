//
//  UIAlertViewController+Ext.swift
//  Loqqat
//
//  Created by Qaptive Technologies on 21/08/19.
//  Copyright © 2019 Qaptive_Technologies. All rights reserved.
//

import UIKit


public extension UIAlertController {
    
    static var alertWindow: UIWindow = {
        let win = UIWindow(frame: UIScreen.main.bounds)
        win.windowLevel = UIWindow.Level.alert + 1
        return win
    }()
    
    func show() {

        if #available(iOS 13.0, *) {
            //guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let windowScene = UIApplication.shared
                                .connectedScenes
                                .filter { ($0.activationState == .foregroundActive) || ($0.activationState == .foregroundInactive) }
                                .first
            
            let vc = UIViewController()
            vc.view.backgroundColor = .clear
            
            var win: UIWindow!
            
            if let windowScene = windowScene as? UIWindowScene {
                win = UIWindow(windowScene: windowScene)

                win.frame = UIScreen.main.bounds
                win.windowLevel = UIWindow.Level.alert + 1

            }

           
            win.rootViewController = vc
            win.makeKeyAndVisible()
            Self.alertWindow = win
            vc.present(self, animated: true) {}


        } else {
           // guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let vc = UIViewController()

            vc.view.backgroundColor = .clear
            Self.alertWindow.rootViewController = vc
            Self.alertWindow.makeKeyAndVisible()


            vc.present(self, animated: true) {}
        }


    }
    
    static func showSuperAlertView(title: String? = nil, message: String,actionTitles: [String], actions: [(() -> ())?]?) {
        UIAlertController.removeSASSuperAlert()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (i, title) in actionTitles.enumerated() {

            let action = UIAlertAction(title: title, style: .default) { (state) in
                if let acts = actions {
                    if acts.count >= actionTitles.count {
                        if let a = acts[i] {
                            a()
                        }
                       
                    }
                }
            }

            alert.addAction(action)
        }
        
        alert.show()
        
    }
    
    static func removeSASSuperAlert() {
        UIAlertController.alertWindow.isHidden = true
    }
    

}
