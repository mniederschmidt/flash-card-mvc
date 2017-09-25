import Foundation

struct Card {
    let front: String
    let back: String
}

class DeckSelectionModel {
    
    let decks: [String: [Card]]
    
    var selectedDeck: String?
    
    init() {
        let decks = DeckSelectionModel.buildOutDecks()
        self.decks = decks
    }
    
    func deckForSelection() -> [Card] {
        guard let selectedKey = selectedDeck else { return [] }
        return decks[selectedKey]!
    }
    
    private class func buildOutDecks() -> [String: [Card]] {
        
        // English / Spanish
        let rojo = Card(front: "Rojo", back: "Red")
        let naranja = Card(front: "Naranja", back: "Orange")
        let amarillo = Card(front: "Amarillo", back: "Yellow")
        let verde = Card(front: "Verde", back: "Green")
        let azul = Card(front: "Azul", back: "Blue")
        
        // English / French
        let rouge = Card(front: "Rouge", back: "Red")
        let orange = Card(front: "Orange", back: "Orange")
        let jaune = Card(front: "Jaune", back: "Yellow")
        let vert = Card(front: "Vert", back: "Green")
        let bleu = Card(front: "Bleu", back: "Blue")
        
        return [
            "Spanish" : [rojo, naranja, amarillo, verde, azul],
            "French" : [rouge, orange, jaune, vert, bleu]
        ]
    }
}
