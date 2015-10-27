//
//  addEventViewController.swift
//  Calender
//
//  Created by Satyam Dhar on 10/26/15.
//  Copyright © 2015 Satyam Dhar. All rights reserved.
//

import UIKit
//import EventKitUI

protocol eventBuilt {
    func eventGet(event: Event)
}

class addEventViewController: UIViewController {
    
//    formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    //formatter.dateFormat = "MM/dd/yy"
    
    @IBOutlet weak var eventDateLabel: UILabel!
    var eventDate : NSDate = NSDate()
    var dateString : String?
    var event = Event()
    var delegate :eventBuilt?
    
    @IBOutlet weak var eventTime: UIDatePicker!
    
    @IBOutlet weak var startTime: UIDatePicker!
    
    @IBOutlet weak var location: UITextField!

    @IBOutlet weak var endTime: UIDatePicker!
    
    @IBOutlet weak var eventTitle: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .NoStyle
        dateString = formatter.stringFromDate(eventDate)
        eventDateLabel.text = dateString
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addEventTime() {
        let formatter = NSDateFormatter()
        var startDate = NSDate()
        var endDate = NSDate()
        formatter.dateStyle = .NoStyle
        formatter.timeStyle = .ShortStyle
        let eventStartDateString = dateString! + " " + formatter.stringFromDate(startTime.date)
        let eventEndDateString = dateString! + " " + formatter.stringFromDate(endTime.date)
        formatter.dateFormat = "MM/dd/yy hh:mm a"
        startDate = formatter.dateFromString(eventStartDateString)!
        endDate = formatter.dateFromString(eventEndDateString)!
        //print(dateString! + " " + formatter.stringFromDate(startTime.date))
//        print(eventStartDateString)
//        print(eventEndDateString)
        
        
        event.title = eventTitle.text!
        event.location = location.text
        event.startDate = startDate
        event.endDate = endDate
        
        if (delegate != nil) {
            delegate?.eventGet(event)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        //performSegueWithIdentifier("backSegue", sender: nil)
        
        //self.dismissViewControllerAnimated(true, completion: nil)
        //self.navigationController ?.popToViewController(ViewController, animated: true)
    }
    
    @IBAction func cancelAdd() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
