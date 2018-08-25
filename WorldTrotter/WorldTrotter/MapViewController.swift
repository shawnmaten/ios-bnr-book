//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Shawn Aten on 8/18/18.
//  Copyright © 2018 Shawn Aten. All rights reserved.
//

import UIKit
import MapKit

class Pin: MKPointAnnotation {
    init(lat: Double, lng: Double) {
        super.init()
        coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
}

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var trackButton: UIButton!
    var pinButton: UIButton!
    
    var currentPin = 0
    
    var annotations = [MKPointAnnotation]()
    
    override func loadView() {
        mapView = MKMapView()
        trackButton = UIButton(type: .system)
        pinButton = UIButton(type: .system)
        locationManager = CLLocationManager()
        
        view = mapView
        mapView.delegate = self
        
        trackButton.addTarget(self, action: #selector(MapViewController.trackButtonPressed), for: .touchUpInside)
        pinButton.addTarget(self, action: #selector(MapViewController.pinButtonPressed), for: .touchUpInside)
        
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        
        let segmentedControl = UISegmentedControl(items: [standardString, satelliteString, hybridString])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        /*
        // For track button
        trackButton.setTitle("Locate Me", for: .normal)
        trackButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        trackButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(trackButton)
        
        let trackBottomConstraint = trackButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        let trackCenterXConstraint = trackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        trackBottomConstraint.isActive = true
        trackCenterXConstraint.isActive = true
        
        // For pin button
        pinButton.setTitle("Show Pins", for: .normal)
        pinButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        pinButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pinButton)
        pinButton.bottomAnchor.constraint(equalTo: trackButton.topAnchor).isActive = true
        pinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        annotations.append(Pin(lat: 29.508171, lng: -98.573010))
        annotations.append(Pin(lat: 29.426239, lng: -98.493589))
        annotations.append(Pin(lat: 40.782915, lng: -73.959067))
        
        for annotation in annotations {
            mapView.addAnnotation(annotation)
        }
        */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view")
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationManager.requestWhenInUseAuthorization()
    }
    
    @objc func trackButtonPressed() {
        if mapView.showsUserLocation {
            mapView.showsUserLocation = false
            mapView.setUserTrackingMode(.none, animated: true)
        } else {
            mapView.showsUserLocation = true
            mapView.setUserTrackingMode(.followWithHeading, animated: true)
        }
    }
    
    @objc func pinButtonPressed() {
        let coordinate = annotations[currentPin].coordinate
        mapView.setCenter(coordinate, animated: true)
        
        currentPin += 1
        if currentPin == 3 {
            currentPin = 0
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
    }
    
}
