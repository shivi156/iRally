import AVFoundation

class MatchManager {
    
    private(set) var game = Game()
    private(set) var set = Set()
    private(set) var match = Match()
    private(set) var tiebreak = Tiebreak()
    
    private var audioPlayer: AVAudioPlayer?
    private var isPlayer1Serving = true
    private var totalGamesPlayed = 0
    private var tiebreakPointCount = 0
    
    var player1GamesWon: Int = 0
    var player2GamesWon: Int = 0
    var player1SetsWon: Int = 0
    var player2SetsWon: Int = 0
    private var allPreviousSetScores: [(Int, Int)] = []

    
    func addPointToPlayer1() {
        if set.isTiebrake() {
            tiebreak.addPointToPlayer1()
            tiebreakPointCount += 1
            updateTiebreakServer()
        } else {
            game.addPointToPlayer1()
        }
        checkGameCompletion()
    }
    
    func addPointToPlayer2() {
        if set.isTiebrake() {
            tiebreak.addPointToPlayer2()
            tiebreakPointCount += 1
            updateTiebreakServer()
        } else {
            game.addPointToPlayer2()
        }
        checkGameCompletion()
    }
    
    private func checkGameCompletion() {
        if set.isTiebrake() {
            handleTiebreakCompletion()
        } else if game.complete() {
            handleGameCompletion()
        }
    }
    
    private func handleGameCompletion() {
        
        if game.player1Won() {
            set.addGameToPlayer1()
            player1GamesWon += 1
        } else {
            set.addGameToPlayer2()
            player2GamesWon += 1
        }
        
        toggleServer()
        totalGamesPlayed += 1
        game = Game()
        
        if set.complete() {
            handleSetCompletion()
        }
    }
    
    private func handleTiebreakCompletion() {
        guard tiebreak.complete() else { return }
        
        // Record the tiebreak score
        let tiebreakScore = (tiebreak.player1Score(), tiebreak.player2Score())
        allPreviousSetScores.append(tiebreakScore)  // Add tiebreak score to previous scores

        // The tiebreak has determined the winner, add the tiebreak winner to the set
        if tiebreak.player1Won() {
            set.addGameToPlayer1()
            player1GamesWon += 1
            match.addSetToPlayer1()  // Add the set win to the match after tiebreak
            player1SetsWon += 1
        } else {
            set.addGameToPlayer2()
            player2GamesWon += 1
            match.addSetToPlayer2()  // Add the set win to the match after tiebreak
            player2SetsWon += 1
        }
        
        // Now, check if the set is complete after the tiebreak
        if set.complete() {
            handleSetCompletion() // Call to handle any further actions after the set completion
        } else {
            // If somehow set is not complete (shouldn't happen for tiebreak), just proceed
            toggleServer()
            totalGamesPlayed += 1
        }

        // Reset for next potential tiebreak
        tiebreak = Tiebreak()
        set = Set()
        game = Game()
        tiebreakPointCount = 0
    }

    private func handleSetCompletion() {
        let currentSetScore = (set.getPlayer1GamesWon(), set.getPlayer2GamesWon())
        allPreviousSetScores.append(currentSetScore)
        
        if player1SetsWon == 3 || player2SetsWon == 3 {
            return
        }
        
        let isFinalSet = player1SetsWon == 2 && player2SetsWon == 2
        
        
        if isFinalSet {
            // If the score reaches 12-12, start a tie-break
            if set.getPlayer1GamesWon() == 12 && set.getPlayer2GamesWon() == 12 {
                startTiebreakInFinalSet()
            } else if abs(set.getPlayer1GamesWon() - set.getPlayer2GamesWon()) >= 2 {
                // Final set: player must win by 2 clear games (e.g., 7-5, 8-6)
                if set.player1WonSet() {
                    match.addSetToPlayer1()
                    player1SetsWon += 1
                } else {
                    match.addSetToPlayer2()
                    player2SetsWon += 1
                }
            }
        } else {
            if set.player1WonSet() {
                match.addSetToPlayer1()
                player1SetsWon += 1
            } else {
                match.addSetToPlayer2()
                player2SetsWon += 1
            }
            
        }
        

        
        // Reset for new set
        set = Set()
        player1GamesWon = 0
        player2GamesWon = 0
        game = Game()
        isPlayer1Serving = !isPlayer1Serving // Alternate serve for new set
    }
    
    private func startTiebreakInFinalSet() {
        
        tiebreak = Tiebreak()
        tiebreakPointCount = 0
        updateTiebreakServer()
    }
    
    func getPreviousSetScores() -> [(Int, Int)] {
        return allPreviousSetScores
    }
    

    
    // MARK: - Helper Methods
    private func toggleServer() {
        isPlayer1Serving.toggle()
        playSound()
    }
    
    private func updateTiebreakServer() {
        if tiebreakPointCount == 1 {
            toggleServer()
        } else if tiebreakPointCount > 1 && (tiebreakPointCount - 1) % 2 == 0 {
            toggleServer()
        }
    }
    
    private func playSound() {
        if let soundURL = Bundle.main.url(forResource: "Sound", withExtension: "wav") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }

    func resetMatch() {
        game = Game()
        set = Set()
        match = Match()
        tiebreak = Tiebreak()
        
        player1GamesWon = 0
        player2GamesWon = 0
        player1SetsWon = 0
        player2SetsWon = 0
        
        isPlayer1Serving = true
        totalGamesPlayed = 0
        tiebreakPointCount = 0
    }
    
    // MARK: - State Checks
    func isMatchComplete() -> Bool {
        return match.matchComplete()
    }
    
    func shouldDisableButtons() -> Bool {
        return match.matchComplete()
    }
    
    func isPlayer1CurrentlyServing() -> Bool {
        return isPlayer1Serving
    }
    
}
