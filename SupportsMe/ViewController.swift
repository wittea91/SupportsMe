//
//  ViewController.swift
//  SupportsMe
//
//  Created by Admin on 2/27/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import GoogleMaps



class GoogleMap: UIViewController {
        
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate of Suny Ulster
        let camera = GMSCameraPosition.camera(withLatitude: 41.8515, longitude: -74.1290, zoom: 17.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.setMinZoom(10, maxZoom: 20)
        mapView.settings.myLocationButton = true
        view = mapView
        
        
        // Creates markers for each building at Suny Ulster
        let Ulstermarker = GMSMarker()
        Ulstermarker.position = CLLocationCoordinate2D(latitude: 41.8515, longitude: -74.1290)
        Ulstermarker.title = "SUNY Ulster"
        Ulstermarker.map = mapView
        
        let hmarker = GMSMarker()
        hmarker.position = CLLocationCoordinate2D(latitude: 41.8521, longitude: -74.1278)
        hmarker.title = "Hardenbergh Building"
        hmarker.map = mapView
        
        let bmarker = GMSMarker()
        bmarker.position = CLLocationCoordinate2D(latitude: 41.85126, longitude: -74.12745)
        bmarker.title = "Burroughs Hall"
        bmarker.map = mapView
        
        let amarker = GMSMarker()
        amarker.position = CLLocationCoordinate2D(latitude: 41.85074, longitude: -74.128028)
        amarker.title = "Algonquin"
        amarker.map = mapView
        
        let vmarker = GMSMarker()
        vmarker.position = CLLocationCoordinate2D(latitude: 41.850867, longitude: -74.12979)
        vmarker.title = "Vanderlyn Hall"
        vmarker.map = mapView
        
        let dmarker = GMSMarker()
        dmarker.position = CLLocationCoordinate2D(latitude: 41.85132, longitude: -74.128813)
        dmarker.title = "Dewitt Library"
        dmarker.map = mapView
        
        let smarker = GMSMarker()
        smarker.position = CLLocationCoordinate2D(latitude: 41.85078, longitude: -74.1308)
        smarker.title = "Senate Gymnasium"
        smarker.map = mapView
    }
}
