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
        viewController.tabBarItem.image = UIImage(systemName: "bus.fill")
        return viewController
    }()
//    private let subwayViewController: UIViewController = {
//        let viewController = UINavigationController(rootViewController: SubwayViewController())
//        viewController.view.backgroundColor = .systemBackground
//        viewController.tabBarItem.title = "지하철"
//        viewController.tabBarItem.image = UIImage(systemName: "tram.fill")
//        return viewController
//    }()
//    private let busViewController: UIViewController = {
//        let viewController = UINavigationController(rootViewController: BusViewController())
//        viewController.view.backgroundColor = .systemBackground
//        viewController.tabBarItem.title = "버스"
//        viewController.tabBarItem.image = UIImage(systemName: "bus.fill")
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
            mapViewController
        ]
    }
}
