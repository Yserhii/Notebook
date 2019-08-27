//
//  ViewController.swift
//  day09
//
//  Created by Yolankyi SERHII on 7/5/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit
import LocalAuthentication
import yserhii2019

class ViewController: UIViewController {

    @IBAction func loginTouchId(_ sender: UIButton) {
        authWithTouchID()
    }

    func authWithTouchID() {

        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Authenticate with Touch ID"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason, reply: {(succes, error) in
                    if succes {
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                            }
                    } else {
                        switch (error as? LAError)?.code {
                            case LAError.authenticationFailed:
                                self.showAlertController("Touch ID Authentication Failed")
                                self.authenticateUser()
                            case LAError.userCancel:
                                print("")
                            default:
                             self.authenticateUser()
                        }
                    }
            })
        } else {
            authenticateUser()
        }
    }
    
    func authenticateUser() {
        let context = LAContext()

        context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: "Please authenticate to proceed.") { [weak self] (success, error) in
            guard success else {
                return
            }
            DispatchQueue.main.async {
                self?.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }

    func showAlertController(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        authWithTouchID()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
