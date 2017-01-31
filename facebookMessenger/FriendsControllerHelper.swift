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
            
            createMessage(withText: "Hello, my name is mark, nice to meet you...", friend: mark, minutesAgo: 3, context: context)
            createMessage(withText: "Whatzzup marky!!", friend: mark, minutesAgo: 2, context: context)
            
            let steve = Friend(context: context)
            
            steve.name = "Steve Jobs"
            steve.profileImageName = "steveprofile"
            
            createMessage(withText: "Good Morning...", friend: steve, minutesAgo: 3, context: context)
            createMessage(withText: "Hello how are you doing!", friend: steve, minutesAgo: 2, context: context)
            
            let ghandi = Friend(context: context)
            
            ghandi.name = "Mahatma Gandhi"
            ghandi.profileImageName = "gandhiprofile"
            
            createMessage(withText: "My name is ghandi and I am pleased to meet you!", friend: ghandi, minutesAgo: 60 * 24, context: context)
            
            let donald = Friend(context: context)
            
            donald.name = "Donald Trump"
            donald.profileImageName = "donaldprofile"
            
            createMessage(withText: "No goddamit You're Fired!", friend: donald, minutesAgo: 60 * 24 * 8, context: context)
            
            delegate?.saveContext()
        }
        
        loadData()
    }
    
    private func createMessage(withText text: String, friend: Friend, minutesAgo: Double, context: NSManagedObjectContext) {
        
        let message  = Message(context: context)
        message.friend = friend
        message.text = text
        message.date = NSDate().addingTimeInterval(-minutesAgo * 60)
        
    }
    
    func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            if let friends = fetchFriends() {
                
                messages = [Message]()
                for friend in friends {
                    
                    let fetchRequest: NSFetchRequest<Message> = Message.fetchRequest()
                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                    fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                    fetchRequest.fetchLimit = 1
                    
                    do {
                        let fetchedMessage = try context.fetch(fetchRequest)
                        messages?.append(contentsOf: fetchedMessage)
                    } catch let err {
                        print(err)
                    }
                }
                
                messages = messages?.sorted(by: {
                    $0.date!.compare($1.date! as Date) == .orderedDescending
                })
            }
        }
    }
    
    private func fetchFriends() -> [Friend]? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            
            do {
                return try context.fetch(Friend.fetchRequest())
            } catch let err {
                print(err)
            }
            
        }
        return nil
    }
    

}










