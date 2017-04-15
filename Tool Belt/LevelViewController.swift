//
//  LevelViewController.swift
//  Tool Belt
//
//  Created by Nathan Daughety on 4/3/17.
//  Copyright © 2017 Harding University. All rights reserved.
//

import UIKit
import CoreMotion // For Core Motion Manager

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

class LevelViewController: UIViewController {

    let manager = CMMotionManager()
    
    @IBOutlet weak var XLabel: UILabel!
    @IBOutlet weak var YLabel: UILabel!
    @IBOutlet weak var ZLabel: UILabel!
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var LevelLabel: UILabel!

    
    @IBOutlet weak var XSlider: UISlider!
        {
            didSet
            {
                XSlider.minimumValue = -1;
                XSlider.maximumValue = 1;
            }
        }
    @IBOutlet weak var YSlider: UISlider!
        {
        didSet
        {
            YSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
            YSlider.minimumValue = -1;
            YSlider.maximumValue = 1;
        }
    }
    @IBOutlet weak var ZSlider: UISlider!
        {
        didSet
        {
            ZSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
            ZSlider.minimumValue = -2;
            ZSlider.maximumValue = 0;
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // prep accelerometer manager to recieve updates
        // and place updates in the corresponding text labels
        if manager.isAccelerometerAvailable {
            manager.accelerometerUpdateInterval = 0.05
            manager.startAccelerometerUpdates(to: .main, withHandler: {
                [weak self] (data: CMAccelerometerData?, error: Error?) in
                if let acceleration = data?.acceleration {
                    self?.XLabel.text = acceleration.x.roundTo(places: 2).description
                    self?.YLabel.text = acceleration.y.roundTo(places: 2).description
                    self?.ZLabel.text = acceleration.z.roundTo(places: 2).description
//                    let move1 = Double(String(format: "%.2f",acceleration.x))
//                    let move2 = Double(String(format: "%.2f",acceleration.y))
//                    let move3 = Double(String(format: "%.2f",acceleration.z))
                    
//                    if (move1! + 0.5 > acceleration.x || move1! - 0.5 < acceleration.x)
//                    {
                    self?.XSlider.setValue(Float(String(format: "%.2f",acceleration.x))!, animated: true)
//                    }
//                     if (move2! + 0.5 > acceleration.y || move2! - 0.5 < acceleration.y)
//                     {
                    self?.YSlider.setValue(Float(String(format: "%.2f",acceleration.y))!, animated: true)
//                    }
//                     if (move3! + 0.5 > acceleration.z || move3! - 0.5 < acceleration.z)
//                     {
                    self?.ZSlider.setValue(Float(String(format: "%.2f",acceleration.z))!, animated: true)
//                    }
                    if ((acceleration.x <= 0.02 && acceleration.x >= -0.02 && acceleration.y <= 0.02 && acceleration.y >= -0.02))
                    {
                        self?.LevelLabel.text = "LEVEL"
                        self?.view.backgroundColor = UIColor.cyan
                        self?.ZSlider.setValue(-1, animated: true)
                        self?.YSlider.setValue(0, animated: true)
                        self?.XSlider.setValue(0, animated: true)
                        
                    }
                    else if ((acceleration.x <= 1.02 && acceleration.x >= 0.98 && acceleration.y <= 0.02 && acceleration.y >= -0.02) && acceleration.z <= 0.02 && acceleration.z >= -0.02)
                    {
                        self?.LevelLabel.text = "LEVEL"
                        self?.view.backgroundColor = UIColor.cyan
                    }
                    else if ((acceleration.y <= 0.02 && acceleration.y >= -0.02) && acceleration.z <= 0.02 && acceleration.z >= -0.02)
                    {
                        self?.LevelLabel.text = "LEVEL"
                        self?.view.backgroundColor = UIColor.cyan
                    }
                    else if ((acceleration.x <= 0.02 && acceleration.x >= -0.02 && acceleration.y <= 1.02 && acceleration.y >= -0.98) && acceleration.z <= 0.02 && acceleration.z >= -0.02)
                    {
                        self?.LevelLabel.text = "LEVEL"
                        self?.view.backgroundColor = UIColor.cyan
                    }
                    else
                    {
                        self?.LevelLabel.text = " "
                        self?.view.backgroundColor = UIColor.white
                    }
                }
            })
        }
        else {
            XLabel.text = "Could not be calculated."
            YLabel.text = "Could not be calculated."
            ZLabel.text = "Could not be calculated."
            ErrorLabel.text = "This feature is unavailable on this device."
            XSlider.setValue(0, animated: false)
            YSlider.setValue(0, animated: false)
            ZSlider.setValue(0, animated: false)
        }
    }
    
    // must stop updates when view disappears
    override func viewWillDisappear(_ animated: Bool) {
        manager.stopAccelerometerUpdates()
    }
    
}
