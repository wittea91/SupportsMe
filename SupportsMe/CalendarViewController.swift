import UIKit

//global dateString variable used to reference the complete date - day, month, year - by other methods
var dateString = ""

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let months = ["January","February","March","April","May","June",
                  "July","August","September","October","November","December"]
    
    let weekDays = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    
    var monthLengths = [31,28,31,30,31,30,31,31,30,31,30,31]
    
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
        
        //changes the cell label to the proper day of the month
        cell.DateLabel.text = "\(indexPath.row + 1)"
    
        
        //if this cell has today's date (supplied by system calendar), draw a circle around it
        if currentMonth == months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 == day {
            cell.Circle.isHidden = false
            cell.DrawCircle()
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
        
        switch(weekday){
        case 1: dateString = "Sunday \(currentMonth) \(indexPath.row + 1) \(year)"
        case 2: dateString = "Monday \(currentMonth) \(indexPath.row + 1) \(year)"
        case 3: dateString = "Tuesday \(currentMonth) \(indexPath.row + 1) \(year)"
        case 4: dateString = "Wednesday \(currentMonth) \(indexPath.row + 1) \(year)"
        case 5: dateString = "Thursday \(currentMonth) \(indexPath.row + 1) \(year)"
        case 6: dateString = "Friday \(currentMonth) \(indexPath.row + 1) \(year)"
        case 7: dateString = "Saturday \(currentMonth) \(indexPath.row + 1) \(year)"
        default: dateString = "\(indexPath.row + 1) \(currentMonth) \(year)"
        }
        
        
        
        //change this date variable to the selected date
        highlightDate = indexPath.row
        
        //reload the calendar to show that the date was selected
        collectionView.reloadData()
        
        //switch to the next view
        performSegue(withIdentifier: "NextView", sender: self)
    }
}
