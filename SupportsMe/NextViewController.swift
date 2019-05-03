import UIKit

//this view controller displays event info if there is any, and allows segue to the third screen to enter event info. Has four labels and two buttons.
class NextViewController: UIViewController {

    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var TimeLabel: UILabel!
    
    @IBOutlet weak var LocationLabel: UILabel!
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    //This label is used to dynamically alter the add/edit button text
    @IBOutlet weak var EditButtonLabel: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //first set the date label to display today's date
        DateLabel.text = dateString
        
        //assume there is no event and display "no event" header, empty labels, and change the button to "Add"
        EditButtonLabel.setTitle("Add", for: .normal)
        TimeLabel.text = "No event today."
        LocationLabel.text = ""
        DescriptionLabel.text = ""
        
        //get the events library and loop through. If an event is found with this date, display the information and change the button to "edit"
        for Event in getEventsLibrary().events {
            if(dateString.elementsEqual(Event.date)) {
                EditButtonLabel.setTitle("Edit", for: .normal)
                DateLabel.text = Event.date
                TimeLabel.text = "Time: " + Event.time
                LocationLabel.text = "Location: " + Event.loc
                DescriptionLabel.text = "Description: " + Event.desc
            }
        }
    }
    
    //return to previous screen
    @IBAction func BackButton(_ sender: Any) {
        performSegue(withIdentifier: "PrevView", sender: self)
    }
    
    //edit/add button - move on to third screen to add or edit an event
    @IBAction func EditButton(_ sender: Any) {
        performSegue(withIdentifier: "EditSegue", sender: self)
    }
    
    //method to unarchive the events library and decode as a usable and searchable object
    func getEventsLibrary() -> EventLibrary {
        let libraryDataRead = NSData(contentsOf: saveFile)
        let lib = NSKeyedUnarchiver.unarchiveObject(with: libraryDataRead! as Data) as! EventLibrary
        return lib
    }
}
