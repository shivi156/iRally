import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
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
    
    // MARK: - Properties
    private let matchManager = MatchManager()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialUI()
    }
    
    private func setupInitialUI() {
        updateAllLabels()
        updateServerColour()
    }
    
    // MARK: - IBActions
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
    
    // MARK: - UI Updates
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
    
//    func updatePreviousSetLabels() {
//        let scores = matchManager.set.getPreviousSetScores()
//
//        var p1Scores: [String] = []
//        var p2Scores: [String] = []
//
//        for (p1, p2) in scores {
//            p1Scores.append("\(p1)")
//            p2Scores.append("\(p2)")
//        }
//
//        p1PreviousSetsLabel.text = p1Scores.joined(separator: ", ")
//        p2PreviousSetsLabel.text = p2Scores.joined(separator: ", ")
//    }
    
    func updatePreviousSetLabels() {
        let scores = matchManager.getPreviousSetScores()  // Get previous set scores from the manager

        var p1Scores: [String] = []
        var p2Scores: [String] = []

        for (p1, p2) in scores {
            p1Scores.append("\(p1)")
            p2Scores.append("\(p2)")
        }

        // Update the labels
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

//import UIKit
//import AVFoundation
//
//
//class ViewController: UIViewController {
//
//    @IBOutlet weak var p1Button: UIButton!
//    @IBOutlet weak var p2Button: UIButton!
//    @IBOutlet weak var p1NameLabel: UILabel!
//    @IBOutlet weak var p2NameLabel: UILabel!
//
//    @IBOutlet weak var p1PointsLabel: UILabel!
//    @IBOutlet weak var p2PointsLabel: UILabel!
//
//    @IBOutlet weak var p1GamesLabel: UILabel!
//    @IBOutlet weak var p2GamesLabel: UILabel!
//
//    @IBOutlet weak var p1SetsLabel: UILabel!
//    @IBOutlet weak var p2SetsLabel: UILabel!
//
//    @IBOutlet weak var p1PreviousSetsLabel: UILabel!
//    @IBOutlet weak var p2PreviousSetsLabel: UILabel!
//
//
//    private var game = Game()
//    private var set = Set ()
//    private var match = Match()
//    private var tiebreak = Tiebreak()
//
//    var audioPlayer: AVAudioPlayer?
//    var externalWindow: UIWindow?
//    
//    private var player1GamesWon: Int = 0
//    private var player2GamesWon: Int = 0
//    private var player1SetsWon: Int = 0
//    private var player2SetsWon: Int = 0
//
//    private var isPlayer1Serving: Bool = true
//    private var totalGamesPlayed = 0
//    private var tiebreakPointCount = 0
//    
////    private var tennisViewModel = TennisViewModel()
//
//
//
//
//    /********Methods*********/
//    @IBAction func p1AddPointPressed(_ sender: UIButton) {
//
//        if set.isTiebrake() {
//            tiebreak.addPointToPlayer1()
//            tiebreakPointCount += 1
//
//            updateScoresLabelTiebreak()
//            updateGamesLabel()
//            checkMatchCompletion()
//
//        }
//
//        else {
//            game.addPointToPlayer1()
//            updateScoresLabel()
//            updateGamesLabel()
//            checkMatchCompletion()
//        }
//    }
//
//    @IBAction func p2AddPointPressed(_ sender: UIButton) {
//        if set.isTiebrake() {
//            tiebreak.addPointToPlayer2()
//            updateScoresLabelTiebreak()
//            updateGamesLabel()
//            checkMatchCompletion()
//            //            return
//        }
//        else {
//
//            game.addPointToPlayer2()
//            updateScoresLabel()
//            updateGamesLabel()
//            checkMatchCompletion()
//        }
//    }
//
//
//
//    @IBAction func restartPressed(_ sender: AnyObject) {
//        game = Game()  // Creates a new game instance, resetting the points
//        set = Set()
//        match = Match()
//
//        // Reset other variables that keep track of scores
//        player1SetsWon = 0
//        player2SetsWon = 0
//        player1GamesWon = 0
//        player2GamesWon = 0
//        totalGamesPlayed = 0
//        tiebreakPointCount = 0
//
//        // Update the UI to reflect the reset state
//        updateScoresLabel() // Update labels to reflect reset state
//        updateGamesLabel()
//        updateSetLabels()
//        updatePreviousSetLabels()
//
//        // Reset the server indicator (which player is serving)
//        updateServerColour()
//
//        // Ensure the buttons are enabled again in case they were disabled (e.g., during match completion)
//        p1Button.isEnabled = true
//        p2Button.isEnabled = true
//    }
//
//    func playSound() {
//        if let soundURL = Bundle.main.url(forResource: "Sound", withExtension: "wav") {
//            do {
//                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
//                audioPlayer?.play()
//            } catch {
//                print("Error playing sound: \(error.localizedDescription)")
//            }
//        }
//    }
//
//    func updateTiebreakServer() {
//        if tiebreakPointCount == 1 {
//            toggleServer()
//        } else if tiebreakPointCount > 1 && (tiebreakPointCount - 1) % 2 == 0 {
//            toggleServer()
//        }
//        updateServerColour()
//    }
//
//
//    func updateServerColour() {
//        isPlayer1Serving = totalGamesPlayed % 2 == 0
//
//        // Reset both to default first
//        p1NameLabel.textColor = .label
//        p2NameLabel.textColor = .label
//
//        if isPlayer1Serving {
//            playSound()
//            p1NameLabel.textColor = .purple
//        } else {
//            playSound()
//            p2NameLabel.textColor = .purple
//        }
//    }
//
//    func toggleServer() {
//        isPlayer1Serving.toggle()
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        updateScoresLabel()
//        updateGamesLabel()
//        updateSetLabels()
//        updatePreviousSetLabels()
//    }
//
//
//
//    func updateScoresLabel() {
//        p1PointsLabel.text = game.player1Score()
//        p2PointsLabel.text = game.player2Score()
//
//        if game.player1Score() > "0" {
//            p1PointsLabel.backgroundColor = .green
//        } else {
//            p1PointsLabel.backgroundColor = .clear
//        }
//
//        if game.player2Score() > "0" {
//            p2PointsLabel.backgroundColor = .green
//        } else {
//            p2PointsLabel.backgroundColor = .clear
//        }
//    }
//
//    func updateScoresLabelTiebreak() {
//        p1PointsLabel.text = "\(tiebreak.player1Score())"
//        p2PointsLabel.text = "\(tiebreak.player2Score())"
//    }
//
//    func disableButtons() {
//        p1Button.isEnabled = false
//        p2Button.isEnabled = false
//    }
//
//    func updateSetLabels() {
//        p1SetsLabel.text = "\(player1SetsWon)"
//        p2SetsLabel.text = "\(player2SetsWon)"
//    }
//
//    func lastSetGameTie() {
//        if match.getSetsCount() == 4 {
//            if set.isTiebrake() {
//                if tiebreak.player1WinsFinalSet() {
//                    set.addGameToPlayer1()
//                }
//                else {
//                    set.addGameToPlayer2()
//                }
//
//            }
//        }
//    }
//
//
//    func updateGamesLabel() {
//
//        lastSetGameTie()
//
//        if set.isTiebrake() {
//            if tiebreak.complete() {
//                if tiebreak.player1Won() {
//                    set.addGameToPlayer1() // final game to win set
//                } else {
//                    set.addGameToPlayer2()
//                }
//
//                // Update labels
//                p1GamesLabel.text = "\(set.getPlayer1GamesWon())"
//                p2GamesLabel.text = "\(set.getPlayer2GamesWon())"
//
//                if tiebreak.complete() {
//                    if tiebreak.player1Won() {
//                        player1SetsWon += 1
//                    } else {
//                        player2SetsWon += 1
//                    }
//                    updateSetLabels()
//                    set.resetGame()
//                    p1GamesLabel.text = "\(set.getPlayer1GamesWon())"
//                    p2GamesLabel.text = "\(set.getPlayer2GamesWon())"
//                    checkMatchWinner()
//                    updatePreviousSetLabels()
//                }
//
//                tiebreak = Tiebreak()
//                tiebreakPointCount = 0
//            }
//
//        } else if game.player1Won() || game.player2Won() {
//            if game.player1Won() {
//                set.addGameToPlayer1()
//            } else {
//                set.addGameToPlayer2()
//            }
//
//            toggleServer()
//            totalGamesPlayed += 1
//            updateServerColour()
//            game = Game()
//
//            p1GamesLabel.text = "\(set.getPlayer1GamesWon())"
//            p2GamesLabel.text = "\(set.getPlayer2GamesWon())"
//
//            if set.getPlayer1GamesWon() > 0 {
//                p1GamesLabel.backgroundColor = .green
//            } else {
//                p1GamesLabel.backgroundColor = .clear
//            }
//
//            if set.getPlayer2GamesWon() > 0 {
//                p2GamesLabel.backgroundColor = .green
//            } else {
//                p2GamesLabel.backgroundColor = .clear
//            }
//
//            if set.complete() {
//                if set.player1WonSet() {
//                    player1SetsWon += 1
//                } else {
//                    player2SetsWon += 1
//                }
//                updateSetLabels()
//                set.resetGame()
//                checkMatchWinner()
//                updatePreviousSetLabels()
//            }
//        }
//    }
//
//    func updatePreviousSetLabels() {
//        let scores = set.getPreviousSetScores()
//
//        var p1Scores: [String] = []
//        var p2Scores: [String] = []
//
//        for (p1, p2) in scores {
//            p1Scores.append("\(p1)")
//            p2Scores.append("\(p2)")
//        }
//
//        p1PreviousSetsLabel.text = p1Scores.joined(separator: ", ")
//        p2PreviousSetsLabel.text = p2Scores.joined(separator: ", ")
//    }
//
//    // Reset the UI and match state
//    func resetUI() {
//        p1SetsLabel.text = "\(match.getPlayer1SetsWon())"
//        p2SetsLabel.text = "\(match.getPlayer2SetsWon())"
//        p1GamesLabel.text = "0"
//        p2GamesLabel.text = "0"
//        p1PointsLabel.text = "0"
//        p2PointsLabel.text = "0"
//        set.resetGame()
//        game = Game()
//    }
//
//    // Call this when the match ends, e.g., after the winner is determined
//    func checkMatchWinner() {
//        let setsToWin = 3 // or 2 for best-of-3
//        if player1SetsWon == setsToWin {
//
//            // Player 1 wins
//            disableButtons()
//
//            //            requestCalendarPermissionAndScheduleMatch()
//        } else if player2SetsWon == setsToWin {
//
//            // Player 2 wins
//            disableButtons()
//
//            //            requestCalendarPermissionAndScheduleMatch()
//        }
//    }
//
//    func getMatchHistory() -> [MatchHistory] {
//        if let data = UserDefaults.standard.data(forKey: "matchHistory"),
//           let decoded = try? JSONDecoder().decode([MatchHistory].self, from: data) {
//            return decoded
//        }
//        return []
//    }
//
//    func checkMatchCompletion() {
//        if match.matchComplete() {
//            disableButtons()
//        }
//    }
//
//}
