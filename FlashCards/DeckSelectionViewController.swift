import UIKit

class DeckSelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var decksTableView: UITableView!
    
    var deckModel: DeckSelectionModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.deckModel = DeckSelectionModel()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return deckModel.decks.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let keyString = deckModel.decks.keys.map({ String($0) })[indexPath.row]
        cell.textLabel?.text = keyString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath),
              let title = cell.textLabel?.text else {
            return
        }
        
        deckModel.selectedDeck = title
        performSegue(withIdentifier: "showDeck", sender: nil)
    }
    
    
    @IBAction func addDeck(_ sender: Any) {
        let addDeckAlert = UIAlertController(title: "Add New Deck", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        let addDeckAction = UIAlertAction(title: "Add Deck", style: UIAlertActionStyle.default) { [weak addDeckAlert] _ in
            if let textFields = addDeckAlert?.textFields {
               let deckNameTextField = textFields[0]
               let deckName = deckNameTextField.text
                
                self.deckModel.addDeck(withTitle: deckName ?? "")
                self.decksTableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        
        addDeckAlert.addTextField { textField in textField.placeholder = "Deck name"
        }
        
        addDeckAlert.addAction(addDeckAction)
        addDeckAlert.addAction(cancelAction)
        
        self.present(addDeckAlert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let flashCardController as FlashCardViewController:
            let flashCardModel = FlashCardModel(deck: deckModel.deckForSelection())
            flashCardController.model = flashCardModel
        default:
            break
        }
    }
}

