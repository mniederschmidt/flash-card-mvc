import UIKit

enum FlipSide {
    case front, back
}

class FlashCardViewController: UIViewController {
    
    @IBOutlet weak var flipView: UIView!
    
    @IBOutlet weak var flipViewTextLabel: UILabel!
    
    var model: FlashCardModel?
    var currentVisibleSide = FlipSide.front

    override func viewDidLoad() {
        super.viewDidLoad()
        flipViewTextLabel.text = model?.getCurrentCard().front
    }

    @IBAction func flipItButtonPressed(_ sender: UIButton) {
        let animationOptions: UIViewAnimationOptions
        
        if self.currentVisibleSide == .front {
            animationOptions = [.curveEaseInOut, .transitionFlipFromLeft]
        } else {
            animationOptions = [.curveEaseInOut, .transitionFlipFromRight]
        }
        
        UIView.transition(with: flipView, duration: 0.5, options: animationOptions, animations: {
            if self.currentVisibleSide == .front {
                self.flipViewTextLabel.text = self.model?.getCurrentCard().back
                self.currentVisibleSide = .back
            } else {
                self.flipViewTextLabel.text = self.model?.getCurrentCard().front
                self.currentVisibleSide = .front
            }
        }) { (complete) in
            
        }
        
    }
 
    @IBAction func prevButtonPressed(_ sender: Any) {
        self.model?.moveToPrevious()
        if self.currentVisibleSide == .front {
            self.flipViewTextLabel.text = self.model?.getCurrentCard().front
        } else {
            self.flipViewTextLabel.text = self.model?.getCurrentCard().back
        }
    }
    
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        self.model?.moveToNext()
        if self.currentVisibleSide == .front {
            self.flipViewTextLabel.text = self.model?.getCurrentCard().front
        } else {
            self.flipViewTextLabel.text = self.model?.getCurrentCard().back
        }
    }
}
