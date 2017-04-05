//
//  CompassViewController.swift
//  Tool Belt
//
//  Created by Nathan Daughety on 4/4/17.
//  Copyright © 2017 Harding University. All rights reserved.
//

import UIKit
import CoreLocation

class CompassViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var DirectionLabel: UILabel!
    var locationManager:CLLocationManager!
    
    
    @IBOutlet weak var CompassImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager  = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
    }
    
    // transform compass arrow to point north at all times
    private func resetCompassHeading(to direction: Double?) {
        CompassImageView.transform = CGAffineTransform(rotationAngle: CGFloat(direction! * .pi/180));
    }
    
    private func locationManager(manager: CLLocationManager!, didUpdateHeading heading: CLHeading!) {
        
        // A value of 0 means north, 90 means east,
        // 180 means south, 270 means west 
        // and everything else in between.
        switch heading.magneticHeading
        {
        case 0:
            DirectionLabel.text = "North"
        case 0..<90:
            DirectionLabel.text = "Northeast"
        case 90:
            DirectionLabel.text = "East"
        case 90..<180:
            DirectionLabel.text = "Southeast"
        case 180:
            DirectionLabel.text = "South"
        case 180..<270:
            DirectionLabel.text = "Southwest"
        case 270:
            DirectionLabel.text = "West"
        case 270..<360:
            DirectionLabel.text = "Northwest"
        default:
            DirectionLabel.text = "Unavailable"
        }
        
        resetCompassHeading(to: heading.magneticHeading);
        
    }

}
