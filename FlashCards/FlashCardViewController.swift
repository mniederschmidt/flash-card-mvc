import UIKit

enum FlipSide {
    case front, back
}

class FlashCardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var flipView: UIView!
    
    @IBOutlet weak var flipViewTextLabel: UILabel!
    
    @IBOutlet weak var deckTableView: UITableView!
    
    var model: FlashCardModel?
    var currentVisibleSide = FlipSide.front

    override func viewDidLoad() {
        super.viewDidLoad()
        
        deckTableView.delegate = self
        deckTableView.dataSource = self
        flipViewTextLabel.text = model?.getCurrentCard()?.front
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let count = model?.cards.count {
//            return count
//        } else {
//            return 0
//        }
        return model?.deck.cards.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = model?.deck.cards[indexPath.row].front
        cell.detailTextLabel?.text = "???"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        model?.selectCard(atIndex: indexPath.row)
        flipViewTextLabel.text = model?.getCurrentCard()?.front
        currentVisibleSide = FlipSide.front
    }
    
    
    @IBAction func addCardToDeck(_ sender: Any) {
        let addCardAlert = UIAlertController(title: "Add New Card", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        let addCardAction = UIAlertAction(title: "Add Card", style: UIAlertActionStyle.default) { [weak addCardAlert] _ in
            if let textFields = addCardAlert?.textFields {
                let frontTextField = textFields[0]
                let front = frontTextField.text
                
                let backTextField = textFields[1]
                let back = backTextField.text
                
                self.model?.addCardToDeck(withFront: front ?? "", withBack: back ?? "")
                self.deckTableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        
        addCardAlert.addTextField { textField in
            textField.placeholder = "Card front"
        }
        
        addCardAlert.addTextField { textField in
            textField.placeholder = "Card back"
        }
        
        addCardAlert.addAction(addCardAction)
        addCardAlert.addAction(cancelAction)
        
        self.present(addCardAlert, animated: true)

    }
    
    @IBAction func flipItButtonPressed(_ sender: UIButton) {
        let animationOptions: UIViewAnimationOptions
        
        if currentVisibleSide == .front {
            animationOptions = [.curveEaseInOut, .transitionFlipFromLeft]
        } else {
            animationOptions = [.curveEaseInOut, .transitionFlipFromRight]
        }
        
        UIView.transition(with: flipView, duration: 0.5, options: animationOptions, animations: {
            if self.currentVisibleSide == .front {
                self.flipViewTextLabel.text = self.model?.getCurrentCard()?.back
                self.currentVisibleSide = .back
            } else {
                self.flipViewTextLabel.text = self.model?.getCurrentCard()?.front
                self.currentVisibleSide = .front
            }
        }) { (complete) in
            
        }
        
    }
 
    @IBAction func prevButtonPressed(_ sender: Any) {
        model?.moveToPrevious()
        if currentVisibleSide == .front {
            self.flipViewTextLabel.text = self.model?.getCurrentCard()?.front
        } else {
            self.flipViewTextLabel.text = self.model?.getCurrentCard()?.back
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        model?.moveToNext()
        if currentVisibleSide == .front {
            self.flipViewTextLabel.text = self.model?.getCurrentCard()?.front
        } else {
            self.flipViewTextLabel.text = self.model?.getCurrentCard()?.back
        }
    }
}
