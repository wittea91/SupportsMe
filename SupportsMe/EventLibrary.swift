//
//  EventLibrary.swift
//  SupportsMe
//
//  Created by user150428 on 5/3/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation

//collections class for events
class EventLibrary: NSObject, NSCoding {
    //stores all events in an array
    var events: [Event] = []
    
    
    override init() {
        super.init()
    }
    
    //constructor method initializes events array
    init(events: [Event]) {
        super.init()
        self.events = events
    }
    
    //toString prints out event descriptions in the array
    override var description: String {
        var description = ""
        
        for event in events {
            description += event.description + "\n"
        }
        
        return description
    }
    
    //nscoding method - encodes the events array with a key
    func encode(with aCoder: NSCoder) {
        aCoder.encode(events, forKey: "events")
    }
    
    //required decoder method - specified decoding protocol for events array
    required convenience init?(coder aDecoder: NSCoder) {
        let events = aDecoder.decodeObject(forKey: "events") as! [Event]
        self.init(events: events)
    }
}
