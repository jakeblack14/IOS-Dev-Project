//
//  RulerViewController.swift
//  Tool Belt
//
//  Created by Nathan Daughety on 4/4/17.
//  Copyright © 2017 Harding University. All rights reserved.
//

import UIKit
import CoreMotion

class RulerViewController: UIViewController {

    let manager = CMMotionManager()

    @IBOutlet weak var DistanceLabel: UILabel!
    @IBOutlet weak var ErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // prep accelerometer manager to recieve updates
        // and place updates in the corresponding text labels
        if manager.isAccelerometerAvailable {
            manager.accelerometerUpdateInterval = 0.01
            manager.startAccelerometerUpdates(to: .main, withHandler: {
                [weak self] (data: CMAccelerometerData?, error: Error?) in
                if let acceleration = data?.acceleration {
                    self?.DistanceLabel.text = acceleration.y.description
                }
            })
        }
        else {
            ErrorLabel.text = "This feature is unavailable on this device."
        }
    }
    
    // must stop updates when view disappears
    override func viewWillDisappear(_ animated: Bool) {
        manager.stopAccelerometerUpdates()
    }
}
