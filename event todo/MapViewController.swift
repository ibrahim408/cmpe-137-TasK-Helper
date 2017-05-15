//
//  MapViewController.swift
//  event todo
//
//  Created by ibrahim ibrahim on 5/14/17.
//  Copyright © 2017 IBMibrahim. All rights reserved.
//

import UIKit
import MapKit


class MapViewController:  UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    
    @IBOutlet var mapView: MKMapView!

    
    var location : CLLocation?
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        
        
        var loc : CLLocationCoordinate2D
        loc = CLLocationCoordinate2DMake((location?.coordinate.latitude)!,(location?.coordinate.longitude)!)
        let pin = Pin(title: "oracle arena", subtitle: "warriors finna take a L", coordinate: loc)
        
        mapView.addAnnotation(pin)
        
        if CLLocationManager.locationServicesEnabled(){
            print("yooooo")
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        let sourceCoordinates = locationManager.location?.coordinate
        let destCoordinates = location?.coordinate
        //let destCoordinates = CLLocationCoordinate2DMake(37.7502778, -122.2027778)
        //let destCoordinates = CLLocationCoordinate2DMake(37.336079, -121.880454)
        
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates!)
        let destinationPlacemark = MKPlacemark(coordinate: destCoordinates!)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceItem
        directionRequest.destination = destinationItem
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: {
            response, error in
            guard let response = response else{
                if let error = error{
                    print("errror")
                }
                return
            }
            
            print("meeeeee")
            let route = response.routes[0]
            self.mapView.add(route.polyline, level: .aboveRoads)
            
            print("freeee")
            let rekt = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rekt), animated: true)
        })
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5
        
        return renderer
    }
    
    
}


