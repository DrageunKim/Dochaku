//
//  MapViewController.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/05.
//

import UIKit
import NMapsMap

class MapViewController: UIViewController {

    let mapView = NMFMapView(frame: view.frame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLayout()
    }
}

// MARK: - View & Layout Configure

extension MapViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureLayout() {
        view.addSubview(mapView)
    }
}
