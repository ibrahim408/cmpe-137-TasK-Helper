//
//  Pin.swift
//  event todo
//
//  Created by ibrahim ibrahim on 5/14/17.
//  Copyright © 2017 IBMibrahim. All rights reserved.
//

import MapKit

class Pin :NSObject, MKAnnotation{
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title : String, subtitle : String, coordinate : CLLocationCoordinate2D ){
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
    
}
