import UIKit

class DeckSelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let flashCardController as FlashCardViewController:
            let flashCardModel = FlashCardModel(cards: deckModel.deckForSelection())
            flashCardController.model = flashCardModel
        default:
            break
        }
    }
}

