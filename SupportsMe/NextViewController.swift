

import UIKit

class NextViewController: UIViewController {

    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var TimeLabel: UILabel!
    
    @IBOutlet weak var LocationLabel: UILabel!
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    @IBOutlet weak var EditButtonLabel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        DateLabel.text = dateString
        if(timeString.elementsEqual("")) {
            //if the event info is empty, change the button to say "add" and change the first label to read "no event"
            EditButtonLabel.setTitle("Add", for: .normal)
            TimeLabel.text = "No event today."
            LocationLabel.text = ""
            DescriptionLabel.text = ""
        }
        else {
            //if there is an event, change the button to say "edit" and change the labels to read the event data
            EditButtonLabel.setTitle("Edit", for: .normal)
            DateLabel.text = dateString
            TimeLabel.text = "Time: " + timeString
            LocationLabel.text = "Location: " + locationString
            DescriptionLabel.text = "Description: " + descriptionString
        }
    }
    @IBAction func BackButton(_ sender: Any) {
        performSegue(withIdentifier: "PrevView", sender: self)
    }
    
    @IBAction func EditButton(_ sender: Any) {
        performSegue(withIdentifier: "EditSegue", sender: self)
    }
}
