//
//  PedometerViewController.swift
//  Tool Belt
//
//  Created by Nathan Daughety on 4/4/17.
//  Copyright © 2017 Harding University. All rights reserved.
//

import UIKit
import CoreMotion

class PedometerViewController: UIViewController {
    
    //Colors for the Start/Stop button
    let stopColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    let startColor = UIColor(red: 0.0, green: 0.75, blue: 0.0, alpha: 1.0)
    
    
    // values for the pedometer data
    var numberOfSteps:Int! = nil
    var distance:Double! = nil
    var averagePace:Double! = nil
    var pace:Double! = nil
    
    
    //the pedometer
    var pedometer = CMPedometer()
    
    // timers
    var timer = Timer()
    var timerInterval = 1.0
    var timeElapsed:TimeInterval = 1.0
    
    
    
    //Outlets
    @IBOutlet weak var statusTitle: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var avgPaceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    
    //Action Reset Button
    @IBAction func ResetButton(_ sender: UIButton) {
        statusTitle.text = "ToolBox Pedometer"
        stepsLabel.text = "Steps:"
        paceLabel.text = "Pace:"
        avgPaceLabel.text = "Average Pace:"
        distanceLabel.text = "Distance:"
        numberOfSteps = 0
        pace = 0.0
        averagePace = 0
        distance = 0.0
        timeElapsed = 0
        
    }
    
    //Action Start/Stop Button
    @IBAction func startStopButton(_ sender: UIButton) {
        if sender.titleLabel?.text == "Start"{
            
            //Start the pedometer
            pedometer = CMPedometer()
            startTimer()
            pedometer.startUpdates(from: Date(), withHandler: { (pedometerData, error) in
                if let pedData = pedometerData{
                    self.numberOfSteps = Int(pedData.numberOfSteps)
                    if let distance = pedData.distance{
                        self.distance = Double(distance)
                    }
                    if let averageActivePace = pedData.averageActivePace {
                        self.averagePace = Double(averageActivePace)
                    }
                    if let currentPace = pedData.currentPace {
                        self.pace = Double(currentPace)
                    }
                } else {
                    self.numberOfSteps = nil
                }
            })
            
            //Set the UI to on state
            statusTitle.text = "Pedometer On"
            sender.setTitle("Stop", for: .normal)
            sender.backgroundColor = stopColor
        } else if sender.titleLabel?.text == "Stop"{
            //Stop the pedometer
            pedometer.stopUpdates()
            stopTimer()
            //Set the UI to off state
            statusTitle.text = "Pedometer Off: " + timeIntervalFormat(interval: timeElapsed)
            sender.backgroundColor = startColor
            sender.setTitle("Start", for: .normal)
        }
    }
    
    //Timer functions
    func startTimer(){
        if timer.isValid { timer.invalidate() }
        timer = Timer.scheduledTimer(timeInterval: timerInterval,target: self,selector: #selector(timerAction(timer:)) ,userInfo: nil,repeats: true)
    }
    
    func stopTimer(){
        timer.invalidate()
        displayPedometerData()
    }
    
    func timerAction(timer:Timer){
        displayPedometerData()
    }
    
    //Display the updated data
    func displayPedometerData(){
        timeElapsed += 1.0
        statusTitle.text = "On: " + timeIntervalFormat(interval: timeElapsed)
        
        //Number of steps
        if let numberOfSteps = self.numberOfSteps{
            stepsLabel.text = String(format:"Steps: %i",numberOfSteps)
        }
        
        //distance
        if let distance = self.distance{
            distanceLabel.text = String(format:"Distance: %02.02f meters \n %02.02f mi",distance,miles(meters: distance))
        } else {
            distanceLabel.text = "Distance: N/A"
        }
        
        //average pace
        if let averagePace = self.averagePace{
            avgPaceLabel.text = paceString(title: "Average Pace", pace: averagePace)
        } else {
            avgPaceLabel.text =  paceString(title: "Average Pace", pace: computedAvgPace())
        }
        
        //pace
        if let pace = self.pace {
            print(pace)
            paceLabel.text = paceString(title: "Pace:", pace: pace)
        } else {
            paceLabel.text = "Pace: N/A "
            paceLabel.text =  paceString(title: "Pace", pace: computedAvgPace())
        }
    }
    
    //Display and time format functions
    //Convert seconds to hh:mm:ss as a string
    func timeIntervalFormat(interval:TimeInterval)-> String{
        var seconds = Int(interval + 0.5) //round up seconds
        let hours = seconds / 3600
        let minutes = (seconds / 60) % 60
        seconds = seconds % 60
        return String(format:"%02i:%02i:%02i",hours,minutes,seconds)
    }
    
    // convert a pace in meters per second to a string with
    // the metric m/s and the Imperial minutes per mile
    func paceString(title:String,pace:Double) -> String{
        var minPerMile = 0.0
        let factor = 26.8224 //conversion factor found on Google =)
        if pace != 0 {
            minPerMile = factor / pace
        }
        let minutes = Int(minPerMile)
        let seconds = Int(minPerMile * 60) % 60
        return String(format: "%@: %02.2f m/s \n\t\t %02i:%02i min/mi",title,pace,minutes,seconds)
    }
    
    func computedAvgPace()-> Double {
        if let distance = self.distance{
            pace = distance / timeElapsed
            return pace
        } else {
            return 0.0
        }
    }
    
    func miles(meters:Double)-> Double{
        let mile = 0.000621371192
        return meters * mile
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
