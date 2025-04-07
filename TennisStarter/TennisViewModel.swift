//import Foundation
//import AVFoundation
//
//class TennisViewModel {
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
//    func player1Point() {
//        if set.isTiebrake() {
//            tiebreak.addPointToPlayer1()
//            tiebreakPointCount += 1
//
////            updateScoresLabelTiebreak()
////            updateGamesLabel()
////            checkMatchCompletion()
//        }
//        else {
//            game.addPointToPlayer1()
////            updateScoresLabel()
////            updateGamesLabel()
////            checkMatchCompletion()
//        }
//    }
//    }
//    
////
//////    var audioPlayer: AVAudioPlayer?
////    var externalWindow: UIWindow?
////    
////    private var player1GamesWon: Int = 0
////    private var player2GamesWon: Int = 0
////    private var player1SetsWon: Int = 0
////    private var player2SetsWon: Int = 0
////    
////    private var isPlayer1Serving: Bool = true
////    private var totalGamesPlayed = 0
////    private var tiebreakPointCount = 0
////    
////    func player1Point() {
////        if set.isTiebrake() {
////            tiebreak.addPointToPlayer1()
////            tiebreakPointCount += 1
////            
////            updateScoresLabelTiebreak()
////            updateGamesLabel()
////            checkMatchCompletion()
////            
////        }
////        
////        else {
////            game.addPointToPlayer1()
////            updateScoresLabel()
////            updateGamesLabel()
////            checkMatchCompletion()
////        }
////    }
////    
////}
////
//////import Foundation
//////
//////class TennisViewModel {
//////
//////    private var game = Game()
//////    private var set = Set()
//////    private var match = Match()
//////    
//////    private var totalGamesPlayed = 0
//////    private var isPlayer1Serving = true
//////
//////    // Callbacks for UI updates
//////    var scoreUpdate: ((String, String) -> Void)?
//////    var gameStatusUpdate: ((String, String) -> Void)?
//////    var setStatusUpdate: ((Int, Int) -> Void)?
//////    var matchStatusUpdate: ((Int, Int) -> Void)?
//////    var serverUpdate: ((Bool) -> Void)?
//////
//////    // Add point to player 1
//////    func addPointToPlayer1() {
//////        game.addPointToPlayer1()
//////        updateScores()
//////    }
//////
//////    // Add point to player 2
//////    func addPointToPlayer2() {
//////        game.addPointToPlayer2()
//////        updateScores()
//////    }
//////
//////    // Update the score labels
//////    private func updateScores() {
//////        scoreUpdate?(game.player1Score(), game.player2Score())
//////        gameStatusUpdate?(game.player1Score(), game.player2Score())
//////        updateGamesLabel()
//////    }
//////
//////    // Update games won
//////    private func updateGamesLabel() {
//////        if game.player1Won() || game.player2Won() {
//////            if game.player1Won() {
//////                set.addGameToPlayer1()
//////            } else {
//////                set.addGameToPlayer2()
//////            }
//////            toggleServer()
//////            totalGamesPlayed += 1
//////            game = Game() // Reset game
//////            
//////            if set.complete() {
//////                updateSetStatus()
//////                set.resetGame()
//////                checkMatchWinner()
//////            }
//////        }
//////    }
//////
//////    // Update set status labels
//////    private func updateSetStatus() {
//////        setStatusUpdate?(set.getPlayer1GamesWon(), set.getPlayer2GamesWon())
//////    }
//////
//////    // Update match status
//////    private func updateMatchStatus() {
//////        matchStatusUpdate?(match.getPlayer1SetsWon(), match.getPlayer2SetsWon())
//////    }
//////
//////    // Handle server switching
//////    private func toggleServer() {
//////        isPlayer1Serving.toggle()
//////        serverUpdate?(isPlayer1Serving)
//////    }
//////
//////    // Reset match
//////    func resetMatch() {
//////        game = Game()
//////        set = Set()
//////        match = Match()
//////        updateScores()
//////        updateSetStatus()
//////        updateMatchStatus()
//////    }
//////}
