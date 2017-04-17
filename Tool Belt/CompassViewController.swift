//
//  CompassViewController.swift
//  Tool Belt
//
//  Created by Nathan Daughety on 4/4/17.
//  Copyright © 2017 Harding University. All rights reserved.
//

import UIKit
import CoreLocation

class CompassViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var DirectionLabel: UILabel!
    @IBOutlet weak var CompassImageView: UIImageView!

    var locationManager:CLLocationManager!
    
    // transform compass arrow to point north at all times
    private func resetCompassHeading(to direction: Double?) {
        CompassImageView.transform = CGAffineTransform(rotationAngle: CGFloat(direction! * .pi / 180))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.headingOrientation = .portrait
        locationManager.headingFilter = kCLHeadingFilterNone

        locationManager.requestWhenInUseAuthorization()
    }
    
    // start updating the user's heading
    override func viewWillAppear(_ animated: Bool) {
        locationManager.startUpdatingHeading()
    }
    
    // stop updating users location when not in view
    override func viewWillDisappear(_ animated: Bool) {
        locationManager.stopUpdatingHeading()
    }
    
    // Heading readings tend to be widely inaccurate until the system has calibrated itself
    // Return true here allows iOS to show a calibration view when iOS wants to improve itself
    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
    
    private func locationManager(manager: CLLocationManager!, didUpdateHeading heading: CLHeading!) {
        DirectionLabel.text = heading.magneticHeading.description
//        // A value of 0 means north, 90 means east,
//        // 180 means south, 270 means west 
//        // and everything else in between.
//        switch heading.magneticHeading
//        {
//        case 0:
//            DirectionLabel.text = "N"
//        case 0..<90:
//            DirectionLabel.text = "NE"
//        case 90:
//            DirectionLabel.text = "E"
//        case 90..<180:
//            DirectionLabel.text = "SE"
//        case 180:
//            DirectionLabel.text = "S"
//        case 180..<270:
//            DirectionLabel.text = "SW"
//        case 270:
//            DirectionLabel.text = "W"
//        case 270..<360:
//            DirectionLabel.text = "NW"
//        default:
//            DirectionLabel.text = "Unavailable"
//        }
//        
//        resetCompassHeading(to: heading.magneticHeading)
        
    }
    
    @objc func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's heading: \(error.localizedDescription)")
        locationManager.stopUpdatingHeading()
    }

}
