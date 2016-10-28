//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Mohammad Azam on 10/25/16.
//  Copyright © 2016 Mohammad Azam. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController, SecretMessageCompactViewControllerDelegate, CreateSecretMessageViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func presentViewController(for conversation: MSConversation, for presentationStyle :MSMessagesAppPresentationStyle) {
        
        var controller :UIViewController!
        
        if presentationStyle == .compact {
            controller = instantiateSecretMessageCompactViewController()
        } else {
            
            if conversation.selectedMessage != nil {
                
                guard let message = conversation.selectedMessage,
                let url = message.url,
                let components = NSURLComponents(url: url, resolvingAgainstBaseURL: false),
                let queryItems = components.queryItems,
                let text = queryItems[0].value
                    
                else {
                    return
                }
                
                controller = instantiateCreateNewMessageViewController(text: text)
                
                
            } else {
            
            controller = instantiateCreateNewMessageViewController()
            }
        }
        
        // Remove any existing child controllers.
        for child in childViewControllers {
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
        
        addChildViewController(controller)
        
        controller.view.frame = self.view.bounds
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(controller.view)
        
        controller.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        controller.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        controller.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        controller.didMove(toParentViewController: self)
    }
    
    private func instantiateSecretMessageCompactViewController() -> UIViewController {
        
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "SecretMessageCompactViewController") as? SecretMessageCompactViewController else {
            fatalError("SecretMessageCompactViewController does not exist")
        }
        
        controller.delegate = self
        return controller
    }
    
    
    func createSecretMessageViewControllerDidAddSecretMessage(text: String) {
        requestPresentationStyle(.compact)
        
        let components = NSURLComponents()
        
        let queryItem = URLQueryItem(name: "secretMessage", value: text)
        
        components.queryItems = [queryItem]
        
        //"secretMessage=Hwy wanna partt"
        
        let layout = MSMessageTemplateLayout()
        layout.image = UIImage(named: "mom")
       
        let message = MSMessage()
        message.layout = layout
        message.url = components.url!
        
        self.activeConversation?.insert(message, completionHandler: nil)
        
        //self.activeConversation?.insertText(text, completionHandler: nil)
        
    }
    
    func secretMessageCompactViewControllerDidCreateNewSecretMessage() {
       
        requestPresentationStyle(.expanded)
    }
    
    override func willBecomeActive(with conversation: MSConversation) {
        presentViewController(for: conversation, for: presentationStyle)
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
     
        guard let conversation = self.activeConversation else {
            fatalError("No active conversation")
        }
        
        presentViewController(for: conversation, for: presentationStyle)
    }
    
    
    
    
    
   

    
    
    
    
    
    
    
    
    
    
    
    private func instantiateCreateNewMessageViewController(text :String) -> UIViewController {
        
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "CreateSecretMessageViewController") as? CreateSecretMessageViewController else {
            fatalError("CreateSecretMessageViewController does not exist")
        }
        
        controller.delegate = self
        controller.secretMessage = text
        return controller
    }
    
    private func instantiateCreateNewMessageViewController() -> UIViewController {
      
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "CreateSecretMessageViewController") as? CreateSecretMessageViewController else {
            fatalError("CreateSecretMessageViewController does not exist")
        }
        
        controller.delegate = self
        return controller
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    
}
