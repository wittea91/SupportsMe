import UIKit

//global dateString variable used to reference the complete date - day, month, year - by other methods
var dateString = ""
//eventLib is an eventLibrary used to store all events
let eventLib = EventLibrary()

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    //array of strings for reference to month names
    let months = ["January","February","March","April","May","June",
                  "July","August","September","October","November","December"]
    //array of ints for reference to month lengths - leap year february is ignored
    var monthLengths = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    //local var for easy reference to current month from system calendar
    var currentMonth = String()
    
    //this is used to show that the user clicked on a certain date. -1 is used to refer to no particular date
    var highlightDate = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set the current month from the system calendar
        currentMonth = months[month]
        //set the header label to display the month and year
        MonthLabel.text = "\(currentMonth) \(year)"
        
    }
    
    @IBOutlet weak var Calendar: UICollectionView!
    @IBOutlet weak var MonthLabel: UILabel!
    
    
    //swipe gesture recognizers - swiping right goes to previous month
    @IBAction func rightSwipe(_ sender: Any) {
        PrevMonth((Any).self)
    }
    
    //swiping left goes to next month
    @IBAction func leftSwipe(_ sender: Any) {
        NextMonth((Any).self)
    }
    
    //back button to return to L1 screen
    @IBAction func backToHome(_ sender: Any) {
        performSegue(withIdentifier: "backToHome", sender: self)
    }
    
    
    //button to switch to the previous month
    @IBAction func PrevMonth(_ sender: Any) {
        highlightDate = -1
        switch(currentMonth) {
        case "January":
            month = 11
            year -= 1
            currentMonth = months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        default:
            month -= 1
            currentMonth = months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        }
    }
    
    //button to switch to the next month
    @IBAction func NextMonth(_ sender: Any) {
        highlightDate = -1
        switch(currentMonth) {
        case "December":
            month = 0
            year += 1
            currentMonth = months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        default:
            month += 1
            currentMonth = months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        }
    }
    
    
    //this method returns the correct number of days in the month and fills the collection view with cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monthLengths[month]
    }
    
    //this method handles the content and formatting for each cell on the calendar - called as the view is filled with cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = UIColor.clear
        cell.DateLabel.textColor = UIColor.black
        cell.Circle.isHidden = true
        circleColor = UIColor.red.cgColor
        
        //changes the cell label to the proper day of the month
        cell.DateLabel.text = "\(indexPath.row + 1)"
    
        
        //if this cell has today's date (supplied by system calendar), draw a red circle around it and change the background color to cyan
        if currentMonth == months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 == day {
            cell.backgroundColor = UIColor.cyan
            cell.Circle.isHidden = false
            circleColor = UIColor.red.cgColor
            cell.DrawCircle()
        }
        
        //check the events library for an event
        //if the date of an event matches the current cell date, draw a blue circle on this date
        if(getEventsLibrary().events.count > 0) {
            for Event in getEventsLibrary().events {
                if(("\(weekdayString(weekday: weekday)) \(currentMonth) \(indexPath.row + 1) \(year)").elementsEqual(Event.date)) {
                    cell.Circle.isHidden = false
                    circleColor = UIColor.blue.cgColor
                    cell.DrawCircle()
                }
            }
        }
        
        //change the background color of a selected cell to indicate use
        if (highlightDate == indexPath.row) {
            cell.backgroundColor = UIColor.cyan
        }
        return cell
    }
    
    //this method is called when a user touches a date in the month
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //set the date string indicating the full date to be displayed on the next screen
        dateString = "\(weekdayString(weekday: weekday)) \(currentMonth) \(indexPath.row + 1) \(year)"
        
        
        //change this date variable to the selected date
        highlightDate = indexPath.row
        
        //reload the calendar to show that the date was selected
        collectionView.reloadData()
        
        //switch to the next view
        performSegue(withIdentifier: "NextView", sender: self)
    }
    
    
    //this method writes event classes to an events library, then saves it to disk for persistence
    func saveEventsLibrary() {
        do {
            let fileManager = FileManager.default
            let documentDir = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            saveFile = documentDir.appendingPathComponent("library.bin")
            let eventData = try NSKeyedArchiver.archivedData(withRootObject: eventLib, requiringSecureCoding: false)
            try eventData.write(to: saveFile)
        }
        catch {
            print("error saving files")
        }
    }
    
    //this method returns the events library which is used to store events
    func getEventsLibrary() -> EventLibrary {
        saveEventsLibrary()
        let libraryDataRead = NSData(contentsOf: saveFile!)
        let lib = NSKeyedUnarchiver.unarchiveObject(with: libraryDataRead! as Data) as! EventLibrary
        return lib
    }
    
    //the system calendar tracks the weekday using an int 1-7 representing sun-sat. This method converts that int to a string for easy use
    func weekdayString(weekday: Int) -> String {
        switch(weekday){
        case 1: return "Sunday"
        case 2: return "Monday"
        case 3: return "Tuesday"
        case 4: return "Wednesday"
        case 5: return "Thursday"
        case 6: return "Friday"
        case 7: return "Saturday"
        default: return ""
        }
    }
}
