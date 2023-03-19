//
//  MapViewController.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/19.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    private let targetStationBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundColor = .systemBackground
        searchBar.placeholder = "목적지"
        searchBar.searchTextField.font = .systemFont(ofSize: 15)
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.isPitchEnabled = true
        map.isZoomEnabled = true
        map.showsUserLocation = true
        return map
    }()
    let locationManager: CLLocationManager = {
        let location = CLLocationManager()
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.requestWhenInUseAuthorization()
        location.startUpdatingLocation()
        return location
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLayout()
        configureDelegate()
    }
    
    private func configureDelegate() {
        mapView.delegate = self
        locationManager.delegate = self
    }
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {}

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {}

// MARK: - Sendable

extension MapViewController: Sendable {
    func dataSend(location station: String, lane: String, code: Int) {
        
    }
}

// MARK: - Configure Button Action

extension MapViewController {
    private func configureButtonAction() {
        targetStationBar.searchTextField.addTarget(
            self,
            action: #selector(tappedTargetStationBar),
            for: .touchDown
        )
    }
    
    @objc
    private func tappedTargetStationBar() {
        let presentViewController = ListViewController()
        
        presentViewController.delegate = self
        
        present(presentViewController, animated: true)
    }
}

// MARK: - Configure View & Layout

extension MapViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(targetStationBar)
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            targetStationBar.leftAnchor.constraint(
                equalTo: view.leftAnchor,
                constant: view.frame.width * 0.03
            ),
            targetStationBar.rightAnchor.constraint(
                equalTo: view.rightAnchor,
                constant: view.frame.width * -0.03
            ),
            targetStationBar.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: view.frame.height * 0.1
            ),
            targetStationBar.bottomAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: -10
            ),
            
            mapView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            mapView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mapView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: -10
            )
        ])
    }
}
