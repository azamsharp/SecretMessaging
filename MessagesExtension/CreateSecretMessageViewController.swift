//
//  CreateSecretMessageViewController.swift
//  SecretMessaging
//
//  Created by Mohammad Azam on 10/25/16.
//  Copyright © 2016 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

protocol CreateSecretMessageViewControllerDelegate : class {
    func createSecretMessageViewControllerDidAddSecretMessage(text :String)
}

class CreateSecretMessageViewController : UIViewController {
    
    var secretMessage :String = ""
    
    @IBOutlet weak var secretMessageTextField: UITextField!
    weak var delegate :CreateSecretMessageViewControllerDelegate!
    
    @IBAction func createSecretMessageButtonPressed(_ sender: AnyObject) {
        
        self.delegate.createSecretMessageViewControllerDidAddSecretMessage(text: self.secretMessageTextField.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.secretMessageTextField.text = self.secretMessage
        
        
        // for demo purposes only 
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTapGestureRecognizer)
    }
    
    func doubleTapped(recognizer :UITapGestureRecognizer) {
        self.secretMessageTextField.text = "Hey! Are you going to Ryan's party?"
    }
}
