import Foundation

//variables for an event object
class Event: NSObject, NSCoding {
    //class attributes
    let date: String
    let time: String
    let loc: String
    let desc: String
    
    //constructor method initializes attributes
    init(date: String,time: String, loc: String, desc: String){
        self.date = date
        self.time = time
        self.loc = loc
        self.desc = desc
    }
    
    //toString equivalent - prints out all info when class is printed
    override var description: String {
        return "\(date) \(time) \(loc) \(desc)"
    }
    
    //encodes data with a key. Used to build event library.
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: "date")
        aCoder.encode(time, forKey: "time")
        aCoder.encode(loc, forKey: "loc")
        aCoder.encode(desc, forKey: "desc")
    }
    
    //required method - specifies decoding protocol
    required convenience init?(coder aDecoder: NSCoder) {
        guard let date = aDecoder.decodeObject(forKey: "date") as? String,
            let time = aDecoder.decodeObject(forKey: "time") as? String,
            let loc = aDecoder.decodeObject(forKey: "loc") as? String,
            let desc = aDecoder.decodeObject(forKey: "desc") as? String
            else {
                return nil
        }
        self.init(date: date, time: time, loc: loc, desc: desc)
    }
}
