//
//  SecretMessageCompactViewController.swift
//  SecretMessaging
//
//  Created by Mohammad Azam on 10/25/16.
//  Copyright © 2016 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

protocol SecretMessageCompactViewControllerDelegate : class {
    func secretMessageCompactViewControllerDidCreateNewSecretMessage()
}

class SecretMessageCompactViewController : UIViewController {
    
    weak var delegate :SecretMessageCompactViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createNewSecretMessageButtonPressed(_ sender: AnyObject) {
        
        self.delegate.secretMessageCompactViewControllerDidCreateNewSecretMessage()
    }
}
