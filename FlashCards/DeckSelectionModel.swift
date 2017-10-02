import Foundation

struct Card {
    let front: String
    let back: String
    
    func returnDictionary() -> [String: String] {
        let dictionary: [String: String] = [front: back]
        return dictionary
    }
}

class Deck {
    
    var cards: [Card]
    
    init(_ cards: [Card]) {
        self.cards = cards
    }
    
    func returnDictionary() -> [[String: String]] {
        var deckDictionary = [[String: String]]()
        
        for card in cards {
            deckDictionary.append(card.returnDictionary())
        }
        
        return deckDictionary
    }
    
}

class DeckSelectionModel {
    
    private(set) var decks: [String: Deck]
    
    var selectedDeck: String?
    
    init() {
        let decks = DeckSelectionModel.buildOutDecks()
        self.decks = decks
        storeDecks()
    }
    
    func addDeck(withTitle title: String) {
        decks[title] = Deck([])
    }
    
    func deckForSelection() -> Deck {
        guard let selectedKey = selectedDeck else { return Deck([]) }
        return decks[selectedKey]!
    }
    
    func storeDecks() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        do {
            let data = try PropertyListSerialization.data(fromPropertyList: returnDecksAsDictionaries(), format: .xml, options: 0)
            try data.write(to: directoryURL.appendingPathComponent("decks.plist"))
        } catch {
            
        }
    }
    
    private func returnDecksAsDictionaries() -> [String: [[String: String]]] {
        var decksDictionary = [String: [[String: String]]]()
        
        for deck in decks {
            decksDictionary[deck.key] = deck.value.returnDictionary()
        }
        
        return decksDictionary
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
