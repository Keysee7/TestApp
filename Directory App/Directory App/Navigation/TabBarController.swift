//
//  TabBarController.swift
//  HitchWiki
//
//  Created by Kacper Cichosz on 03/02/2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTabBarController()
    }
    
    func setUpTabBarController() {
        let mainMenu = NavigationController(rootViewController: MainMenuViewController())
        let peopleView = NavigationController(rootViewController: PeopleListViewController(viewModel: PeopleListViewModel()))
        let roomsView = NavigationController(rootViewController: RoomListViewController(viewModel: RoomListViewModel()))
        self.setViewControllers([mainMenu, peopleView, roomsView], animated: true)
        guard let items = self.tabBar.items else {
            return
        }
        
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.stackedLayoutAppearance.normal.iconColor = Constants.MainBrandColour
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
            appearance.stackedLayoutAppearance.selected.iconColor = Constants.MainBrandColour
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = appearance
        }
        
        if #available(iOS 13, *) {
            let appearance = UITabBarAppearance()
            appearance.shadowImage = UIImage()
            appearance.shadowColor = .white
            
            appearance.stackedLayoutAppearance.normal.iconColor = Constants.MainBrandColour
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
            appearance.stackedLayoutAppearance.selected.iconColor = Constants.MainBrandColour
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
            self.tabBar.standardAppearance = appearance
        }
        let images = ["house", "person", "person.3.sequence"]
        for (index, item) in items.enumerated() {
            item.image = UIImage(named: images[index])
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let viewController = self.viewControllers?[selectedIndex] as? NavigationController
        viewController?.popToRootViewController(animated: false)
    }
}
