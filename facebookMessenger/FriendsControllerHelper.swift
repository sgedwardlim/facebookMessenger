//
//  FriendsControllerHelper.swift
//  facebookMessenger
//
//  Created by Edward on 1/30/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit
import CoreData

extension FriendsController {
    
    func clearData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            do {
                let messages: [Message] = try context.fetch(Message.fetchRequest())
                for message in messages {
                    context.delete(message)
                }
                
                let friends: [Friend] = try context.fetch(Friend.fetchRequest())
                for friend in friends {
                    context.delete(friend)
                }
                
                delegate?.saveContext()
            } catch let err {
                print(err)
            }
            
        }
    }
    
    func setupData() {
        
        clearData()
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            let mark = Friend(context: context)
            
            mark.name = "Mark Zuckerberg"
            mark.profileImageName = "zuckprofile"
            
            let message = Message(context: context)
            
            message.friend = mark
            message.text = "Hello, my name is mark, nice to meet you..."
            message.date = NSDate()
            
            let steve = Friend(context: context)
            
            steve.name = "Steve Jobs"
            steve.profileImageName = "steveprofile"
            
            let messageSteve  = Message(context: context)
            messageSteve.friend = steve
            messageSteve.text = "Hello i am the founder of apple products..."
            messageSteve.date = NSDate()
            
            delegate?.saveContext()
            
//            do {
//                try context.save()
//            } catch let err {
//                print(err)
//            }

        }
        
        loadData()
    }
    
    func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            do {
                messages = try context.fetch(Message.fetchRequest())
            } catch let err {
                print(err)
            }
            
        }
    }
    

}










