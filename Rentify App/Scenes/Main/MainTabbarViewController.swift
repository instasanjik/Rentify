//
//  MainTabbarViewController.swift
//  Sleepmate
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit

class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        updateTabbarUI()
        selectedIndex = 2
    }
    

}

extension MainTabbarViewController {
    
    func updateTabbarUI() {
        tabBar.tintColor = ColorPalette.white
        tabBar.barTintColor = .clear
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        
        let positionX: CGFloat = 24
        let positionY: CGFloat = 8
        let width = tabBar.bounds.width - positionX * 2
        let height: CGFloat = 53
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(x: positionX,
                                y: tabBar.bounds.minY - positionY,
                                width: width,
                                height: height),
            cornerRadius: height / 2)
        
        roundLayer.path = bezierPath.cgPath
        roundLayer.fillColor = ColorPalette.black.cgColor
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5.5
        tabBar.itemPositioning = .centered
        tabBar.unselectedItemTintColor = ColorPalette.systemGray
    }
    
    func configureViewControllers() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FavoritesNavigationViewController")
        let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "HousesNavigationViewController")
        
        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "MainNavigationViewController")
    
        let vc3 = self.storyboard?.instantiateViewController(withIdentifier: "ProfileNavigationViewController")
        viewControllers = [
            prepareViewController(vc!, imageName: "Heart"),
            prepareViewController(vc1!, imageName: "House"),
            prepareViewController(vc2!, imageName: "Search"),
            prepareViewController(vc3!, imageName: "User")
        ]
    }
    
    private func prepareViewController(_ viewController: UIViewController, title: String? = nil, imageName: String) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(named: imageName)
        return viewController
    }
    
    
}
