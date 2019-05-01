
import UIKit

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
            
            timeString = timeField.text!
            locationString = locationField.text!
            descriptionString = descriptionField.text!
            
            //return to previous view
            performSegue(withIdentifier: "backToView", sender: self)
        }
        
    }
    
}
