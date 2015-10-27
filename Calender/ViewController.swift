//
//  ViewController.swift
//  Calender
//
//  Created by Satyam Dhar on 10/25/15.
//  Copyright © 2015 Satyam Dhar. All rights reserved.
//

import UIKit
//import EventKit

class ViewController: UIViewController, UITableViewDataSource, eventBuilt {
    
    @IBOutlet weak var currentDate: UIDatePicker!
    @IBOutlet weak var eventsTableView: UITableView!
    var formatter = NSDateFormatter()
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        eventsOnDate.removeAll()
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .NoStyle
        for var i=0;i<events.count;i++ {
            if formatter.stringFromDate(events[i].startDate) == formatter.stringFromDate(currentDate.date) {
                eventsOnDate.append(events[i])
            }
        }
        return 1
    }
    
    @IBAction func addNewEvent() {
        self.performSegueWithIdentifier("addEventSegue", sender: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsOnDate.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        //let cell = UITableViewCell()
        cell.textLabel?.text = eventsOnDate[indexPath.row].title
        formatter.dateStyle = .NoStyle
        formatter.timeStyle = .ShortStyle
        cell.detailTextLabel?.text = formatter.stringFromDate(eventsOnDate[indexPath.row].startDate) + " to " + formatter.stringFromDate(eventsOnDate[indexPath.row].endDate) + " in " + eventsOnDate[indexPath.row].location
        return cell
    }
    
    // delete an event
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        var index = 0
        for var i=0; i<events.count; i++ {
            if events[i].title == eventsOnDate[indexPath.row].title {
                index = i;
                break
            }
        }
        if editingStyle == UITableViewCellEditingStyle.Delete {
            events.removeAtIndex(index)
            eventsTableView.reloadData()
        }
    }
    
    var events = Array<Event>()
    var eventsOnDate = Array<Event>()

    @IBAction func dateChanged() {
        
        eventsTableView.reloadData()
        //print(events)
        print(eventsOnDate)
        
    }
    
    func eventGet(event: Event) {
        events.append(event)
        eventsTableView.reloadData()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! addEventViewController
        if segue.identifier == "addEventSegue" {
            print(currentDate.date)
            vc.eventDate = currentDate.date
            vc.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

