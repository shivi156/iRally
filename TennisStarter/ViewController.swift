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
    
    
    
    private var game = Game()
    private var set = Set ()
    private var match = Match()
    private var tiebreak = Tiebreak()
    
    var audioPlayer: AVAudioPlayer?
    
    private var player1GamesWon: Int = 0
    private var player2GamesWon: Int = 0
    private var player1SetsWon: Int = 0
    private var player2SetsWon: Int = 0
    
    private var isPlayer1Serving: Bool = true
    private var totalGamesPlayed = 0
    private var tiebreakPointCount = 0

    
    
    
    
    
    
    /********Methods*********/
    @IBAction func p1AddPointPressed(_ sender: UIButton) {
        
        if set.isTiebrake() {
            tiebreak.addPointToPlayer1()
            tiebreakPointCount += 1
            
            updateScoresLabelTiebreak()
            updateGamesLabel()
            checkMatchCompletion()

        }
        else {
            
            game.addPointToPlayer1()
            updateScoresLabel()
            updateGamesLabel()
            checkMatchCompletion()
        }
    }

    @IBAction func p2AddPointPressed(_ sender: UIButton) {
        if set.isTiebrake() {
            tiebreak.addPointToPlayer2()
            updateScoresLabelTiebreak()
            updateGamesLabel()
            checkMatchCompletion()
//            return
        }
        else {
            
            game.addPointToPlayer2()
            updateScoresLabel()
            updateGamesLabel()
            checkMatchCompletion()
        }
    }
    
    @IBAction func restartPressed(_ sender: AnyObject) {
        game = Game()  // Creates a new game instance, resetting the points
        set = Set()
        
        totalGamesPlayed = 0
        updateServerColour()


        updateScoresLabel() // Update labels to reflect reset state
        updateGamesLabel()
        checkMatchCompletion()
    }
    
    func playServerChangeSound() {
        guard let url = Bundle.main.url(forResource: "sound", withExtension: "wav") else {
            print("⚠️ sound.wav not found")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("⚠️ Could not play sound: \(error.localizedDescription)")
        }
    }

    
    func updateTiebreakServer() {
        if tiebreakPointCount == 1 {
            toggleServer()
        } else if tiebreakPointCount > 1 && (tiebreakPointCount - 1) % 2 == 0 {
            toggleServer()
        }
        updateServerColour()
    }

    
    func updateServerColour() {
        isPlayer1Serving = totalGamesPlayed % 2 == 0
        
        // Reset both to default first
        p1NameLabel.textColor = .label
        p2NameLabel.textColor = .label

        if isPlayer1Serving {
            playServerChangeSound()
            p1NameLabel.textColor = .purple
        } else {
            playServerChangeSound()
            p2NameLabel.textColor = .purple
        }
        
//        if isPlayer1Serving {
//            p1NameLabel.textColor = .purple
//            p2NameLabel.textColor = .label
//        } else {
//            p1NameLabel.textColor = .label
//            p2NameLabel.textColor = .purple
//        }
    }
    
    func toggleServer() {
        isPlayer1Serving.toggle()
        playServerChangeSound()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial server color
        updateServerColour()
        
        // Any other initial UI setup
        updateScoresLabel()
        updateGamesLabel()
        updateSetLabels()
        updatePreviousSetLabels()
    }

    
    
    
    func updateScoresLabel() {
        p1PointsLabel.text = game.player1Score()
        p2PointsLabel.text = game.player2Score()
    }

    func updateScoresLabelTiebreak() {
        p1PointsLabel.text = "\(tiebreak.player1Score())"
        p2PointsLabel.text = "\(tiebreak.player2Score())"
    }
    
    func disableButtons() {
        p1Button.isEnabled = false
        p2Button.isEnabled = false
    }
    
    func updateSetLabels() {
        p1SetsLabel.text = "\(player1SetsWon)"
        p2SetsLabel.text = "\(player2SetsWon)"
    }
    
    func lastSetGameTie() {
        if match.getSetsCount() == 4 {
            if set.isTiebrake() {
                if tiebreak.player1WinsFinalSet() {
                    set.addGameToPlayer1()
                }
                else {
                    set.addGameToPlayer2()
                }
                
            }
        }
    }

    
    func updateGamesLabel() {
        
        lastSetGameTie()

        if set.isTiebrake() {
            if tiebreak.complete() {
                if tiebreak.player1Won() {
                    set.addGameToPlayer1() // final game to win set
                } else {
                    set.addGameToPlayer2()
                }
                
                // Update labels
                p1GamesLabel.text = "\(set.getPlayer1GamesWon())"
                p2GamesLabel.text = "\(set.getPlayer2GamesWon())"

                if tiebreak.complete() {
                    if tiebreak.player1Won() {
                        player1SetsWon += 1
                    } else {
                        player2SetsWon += 1
                    }
                    updateSetLabels()
                    set.resetGame()
                    p1GamesLabel.text = "\(set.getPlayer1GamesWon())"
                    p2GamesLabel.text = "\(set.getPlayer2GamesWon())"
                    checkMatchWinner()
                    updatePreviousSetLabels()
                }
                
                tiebreak = Tiebreak()
                tiebreakPointCount = 0
            }

        } else if game.player1Won() || game.player2Won() {
            if game.player1Won() {
                set.addGameToPlayer1()
            } else {
                set.addGameToPlayer2()
            }
            
            toggleServer()
            totalGamesPlayed += 1
            updateServerColour()
            game = Game()

            p1GamesLabel.text = "\(set.getPlayer1GamesWon())"
            p2GamesLabel.text = "\(set.getPlayer2GamesWon())"

            if set.complete() {
                if set.player1WonSet() {
                    player1SetsWon += 1
                } else {
                    player2SetsWon += 1
                }
                updateSetLabels()
                set.resetGame()
                checkMatchWinner()
                updatePreviousSetLabels()
            }
        }
    }
    
    func updatePreviousSetLabels() {
        let scores = set.getPreviousSetScores()
        
        var p1Scores: [String] = []
        var p2Scores: [String] = []
        
        for (p1, p2) in scores {
            p1Scores.append("\(p1)")
            p2Scores.append("\(p2)")
        }
        
        p1PreviousSetsLabel.text = p1Scores.joined(separator: ", ")
        p2PreviousSetsLabel.text = p2Scores.joined(separator: ", ")
    }

    // Reset the UI and match state
    func resetUI() {
        p1SetsLabel.text = "\(match.getPlayer1SetsWon())"
        p2SetsLabel.text = "\(match.getPlayer2SetsWon())"
        p1GamesLabel.text = "0"
        p2GamesLabel.text = "0"
        p1PointsLabel.text = "0"
        p2PointsLabel.text = "0"
        set.resetGame()
        game = Game()
    }

    func checkMatchWinner() {
        let setsToWin = 3 // or 2 for best-of-3
        if player1SetsWon == setsToWin {
            // Player 1 wins
            disableButtons()
        } else if player2SetsWon == setsToWin {
            // Player 2 wins
            disableButtons()
        }
    }

    func checkMatchCompletion() {
        if match.matchComplete() {
            disableButtons()
        }
    }
}
