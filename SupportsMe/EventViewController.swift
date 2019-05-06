import UIKit
//global url variable - references the file path where the events library is saved
var saveFile: URL!

//this view controller contains three text fields and four labels. The user enters information for an event here.
class EventViewController: UIViewController {
    
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var timeField: UITextField!
    
    @IBOutlet weak var locationField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set header upon entering view
        DateLabel.text = "Edit Event for " + dateString
    }
    //return to NextViewController - second screen
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "backToView", sender: self)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if(timeField.text?.elementsEqual("") ?? false || locationField.text?.elementsEqual("") ?? false || descriptionField.text?.elementsEqual("") ?? false) {
            //change header to error msg if any fields are empty
            DateLabel.text = "Fill out all fields!"
        }
        else {        
            //change header to success message if complete
            DateLabel.text = "Saved"
            
            //create and store an event with the string information entered by the user
            eventLib.events.append(Event(date: dateString, time: timeField.text!, loc: locationField.text!, desc: descriptionField.text!))
            //save the library before exiting
            saveEventsLibrary()
            //return to previous view
            performSegue(withIdentifier: "backToView", sender: self)
        }
    }
    
    //save the library using a file manager, a specified document directory and file, and the NSKeyedArchiver to store the data in the library as binary code
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
}
