import Foundation

class FlashCardModel {
    
    let cards: [Card]
    private var currentCardIndex = 0
    
    init(cards: [Card]) {
        self.cards = cards
    }
    
    func getCurrentCard() -> Card {
        return cards[currentCardIndex]
    }
    
    func moveToNext() {
        if currentCardIndex == cards.count - 1 {
            currentCardIndex = 0
        } else {
            currentCardIndex += 1
        }
    }
    
    func moveToPrevious() {
        if currentCardIndex == 0 {
            currentCardIndex = cards.count - 1
        } else {
            currentCardIndex -= 1
        }
    }
    
}
