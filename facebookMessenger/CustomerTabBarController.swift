//
//  CustomerTabBarController.swift
//  facebookMessenger
//
//  Created by Edward on 1/30/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

class CustomerTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup our customer view controllers
        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsController(collectionViewLayout: layout)
        let recentMessagesNavController = UINavigationController(rootViewController: friendsController)
        recentMessagesNavController.tabBarItem.title = "Recent"
        recentMessagesNavController.tabBarItem.image = UIImage(named: "recents")
        
        let homeController = UIViewController()
        let homeNavController = UINavigationController(rootViewController: homeController)
        homeController.tabBarItem.title = "Home"
        homeController.tabBarItem.image = UIImage(named: "home")
        
        let groupsController = UIViewController()
        let groupsNavController = UINavigationController(rootViewController: groupsController)
        groupsController.tabBarItem.title = "Groups"
        groupsController.tabBarItem.image = UIImage(named: "groups")
        
        let settingsController = UIViewController()
        let settingsNavController = UINavigationController(rootViewController: settingsController)
        settingsController.tabBarItem.title = "Settings"
        settingsController.tabBarItem.image = UIImage(named: "settings")
        
        viewControllers = [recentMessagesNavController, homeNavController, groupsNavController, settingsNavController]
    }
}
