import Foundation

class FlashCardModel {
    
    private(set) var deck: Deck
    private var currentCardIndex = 0
    
    init(deck: Deck) {
        self.deck = deck
    }
    
    func getCurrentCard() -> Card? {
        if deck.cards.count > 0 {
            return deck.cards[currentCardIndex]
        }
        return nil
    }
    
    func selectCard(atIndex index: Int) {
        currentCardIndex = index
    }
    
    func addCardToDeck(withFront front: String, withBack back: String) {
        deck.cards.append(Card(front: front, back: back))
    }
    
    func moveToNext() {
        if currentCardIndex == deck.cards.count - 1 {
            currentCardIndex = 0
        } else {
            currentCardIndex += 1
        }
    }
    
    func moveToPrevious() {
        if currentCardIndex == 0 {
            currentCardIndex = deck.cards.count - 1
        } else {
            currentCardIndex -= 1
        }
    }
    
}
