//
//  CustomTabBarController.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/02/23.
//

import UIKit

class CustomTabBarController: UITabBarController {

    private let mapViewController: UIViewController = {
        let viewController = MapViewController()
        viewController.view.backgroundColor = .systemBackground
        viewController.tabBarItem.title = "알림 추가"
        viewController.tabBarItem.image = UIImage(systemName: "alarm")
        return viewController
    }()
    private let listViewController: UIViewController = {
        let viewController = UINavigationController(rootViewController: ListViewController())
        viewController.view.backgroundColor = .systemBackground
        viewController.tabBarItem.title = "지하철"
        viewController.tabBarItem.image = UIImage(systemName: "list.bullet")
        return viewController
    }()
//    private let settingViewController: UIViewController = {
//        let viewController = UINavigationController(rootViewController: BusViewController())
//        viewController.view.backgroundColor = .systemBackground
//        viewController.tabBarItem.title = "버스"
//        viewController.tabBarItem.image = UIImage(systemName: "gearshape")
//        return viewController
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
    }
    
    private func configureTabBar() {
        tabBar.tintColor = .systemOrange
        tabBar.unselectedItemTintColor = .label
        tabBar.layer.borderWidth = 0.1
        tabBar.layer.borderColor = UIColor.label.cgColor
        tabBar.layer.cornerRadius = 10
        
        viewControllers = [
            mapViewController, listViewController
        ]
    }
}
