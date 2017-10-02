import Foundation

struct Card {
    let front: String
    let back: String
}

class Deck {
    
    var cards: [Card]
    
    init(_ cards: [Card]) {
        self.cards = cards
    }
    
}

class DeckSelectionModel {
    
    private(set) var decks: [String: Deck]
    
    var selectedDeck: String?
    
    init() {
        let decks = DeckSelectionModel.buildOutDecks()
        self.decks = decks
    }
    
    func addDeck(withTitle title: String) {
        decks[title] = Deck([])
    }
    
    func deckForSelection() -> Deck {
        guard let selectedKey = selectedDeck else { return Deck([]) }
        return decks[selectedKey]!
    }
    
    private class func buildOutDecks() -> [String: Deck] {
        
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
        
        var returnDeck: [String: Deck] = Dictionary()
        returnDeck["Spanish"] = Deck([rojo, naranja, amarillo, verde, azul])
        returnDeck["French"] = Deck([rouge, orange, jaune, vert, bleu])
        
        return returnDeck
        
//        return [
//            "Spanish" : [rojo, naranja, amarillo, verde, azul],
//            "French" : [rouge, orange, jaune, vert, bleu]
//        ]
    }
}
