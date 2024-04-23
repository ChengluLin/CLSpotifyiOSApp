//
//  TabBarViewController.swift
//  CLSpotify
//
//  Created by ChengLu on 2024/3/31.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // change the Tabbar background color or style
//        let blurEffect = UIBlurEffect(style: .regular)
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        blurView.frame = tabBar.bounds
//        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        tabBar.insertSubview(blurView, at: 0)
//        tabBar.shadowImage = UIImage()
//        tabBar.backgroundImage = UIImage()
//        tabBar.barTintColor = .clear
        
        
        let vc1 = HomeViewController()
        let vc2 = SearchViewController()
        let vc3 = LibraryViewController()
        
        vc1.title = "Browse"
        vc2.title = "Search"
        vc3.title = "Library"
        
        vc1.navigationItem.largeTitleDisplayMode = .automatic
        vc1.navigationItem.largeTitleDisplayMode = .automatic
        vc1.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
//        
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        nav3.navigationBar.tintColor = .label

        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 3)
        
        for nav in [nav1, nav2, nav3] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([nav1, nav2, nav3], animated: true)
        
    }
}
