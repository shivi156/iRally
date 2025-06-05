import UIKit
import AVFoundation


class ViewController: UIViewController {

    @IBOutlet weak var p1Button: UIButton!
    @IBOutlet weak var p2Button: UIButton!
    @IBOutlet weak var p1NameLabel: UILabel!
    @IBOutlet weak var p2NameLabel: UILabel!

    @IBOutlet weak var p1PointsLabel: UILabel!
    @IBOutlet weak var p2PointsLabel: UILabel!

    @IBOutlet weak var p1GamesLabel: UILabel!
    @IBOutlet weak var p2GamesLabel: UILabel!

    @IBOutlet weak var p1SetsLabel: UILabel!
    @IBOutlet weak var p2SetsLabel: UILabel!

    @IBOutlet weak var p1PreviousSetsLabel: UILabel!
    @IBOutlet weak var p2PreviousSetsLabel: UILabel!
    
    // Creating instance
    private let matchManager = MatchManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialUI()
    }
    
    private func setupInitialUI() {
        updateAllLabels()
        updateServerColour()
    }
    
    @IBAction func p1AddPointPressed(_ sender: UIButton) {
        matchManager.addPointToPlayer1()
        updateAfterPoint()
    }
    
    @IBAction func p2AddPointPressed(_ sender: UIButton) {
        matchManager.addPointToPlayer2()
        updateAfterPoint()
    }
    
    @IBAction func restartPressed(_ sender: AnyObject) {
        matchManager.resetMatch()
        resetUI()
    }
    
    private func updateAfterPoint() {
        updateAllLabels()
        updateServerColour()
        
        if matchManager.shouldDisableButtons() {
            p1Button.isEnabled = false
            p2Button.isEnabled = false
        }
    }
    
    private func updateAllLabels() {
        updateScoresLabel()
        updateGamesLabel()
        updateSetLabels()
        updatePreviousSetLabels()
    }
    
    private func updateScoresLabel() {
        if matchManager.set.isTiebrake() {
            p1PointsLabel.text = "\(matchManager.tiebreak.player1Score())"
            p2PointsLabel.text = "\(matchManager.tiebreak.player2Score())"
        } else {
            p1PointsLabel.text = matchManager.game.player1Score()
            p2PointsLabel.text = matchManager.game.player2Score()
        }
        
        p1PointsLabel.backgroundColor = matchManager.game.player1Score() > "0" ? .green : .clear
        p2PointsLabel.backgroundColor = matchManager.game.player2Score() > "0" ? .green : .clear
    }
    
    private func updateGamesLabel() {
        p1GamesLabel.text = "\(matchManager.set.getPlayer1GamesWon())"
        p2GamesLabel.text = "\(matchManager.set.getPlayer2GamesWon())"
        
        p1GamesLabel.backgroundColor = matchManager.set.getPlayer1GamesWon() > 0 ? .green : .clear
        p2GamesLabel.backgroundColor = matchManager.set.getPlayer2GamesWon() > 0 ? .green : .clear
    }
    
    private func updateSetLabels() {
        p1SetsLabel.text = "\(matchManager.player1SetsWon)"
        p2SetsLabel.text = "\(matchManager.player2SetsWon)"
        
        p1SetsLabel.backgroundColor = matchManager.match.getPlayer1SetsWon() > 0 ? .green : .clear
        p2SetsLabel.backgroundColor = matchManager.match.getPlayer1SetsWon() > 0 ? .green : .clear
    }
    
    func updatePreviousSetLabels() {
        let scores = matchManager.getPreviousSetScores()  // Get previous set scores from the manager

        var p1Scores: [String] = []
        var p2Scores: [String] = []

        for (p1, p2) in scores {
            p1Scores.append("\(p1)")
            p2Scores.append("\(p2)")
        }

        p1PreviousSetsLabel.text = p1Scores.joined(separator: ", ")
        p2PreviousSetsLabel.text = p2Scores.joined(separator: ", ")
    }

    private func updateServerColour() {
        p1NameLabel.textColor = matchManager.isPlayer1CurrentlyServing() ? .purple : .label
        p2NameLabel.textColor = matchManager.isPlayer1CurrentlyServing() ? .label : .purple
    }
    
    private func resetUI() {
        p1Button.isEnabled = true
        p2Button.isEnabled = true
        updateAllLabels()
        updateServerColour()
    }
}
