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
        }
        else {
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
    
    private func isFinalSet() -> Bool {
        return player1SetsWon + player2SetsWon == 4
    }

    private func shouldPlayTiebreak() -> Bool {
        let p1Games = set.getPlayer1GamesWon()
        let p2Games = set.getPlayer2GamesWon()
        
        if isFinalSet() {
            return p1Games == 12 && p2Games == 12
        } else {
            return p1Games == 6 && p2Games == 6
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
        } else if shouldPlayTiebreak() {
            // Only start tiebreak if conditions are met
            startTiebreak()
        }
    }
    
    private func startTiebreak() {
        tiebreak = Tiebreak()
        tiebreakPointCount = 0
        updateTiebreakServer()
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
            match.addSetToPlayer1()
            player1SetsWon += 1
        } else {
            set.addGameToPlayer2()
            player2GamesWon += 1
            match.addSetToPlayer2()
            player2SetsWon += 1
        }
        

        if set.complete() {
            handleSetCompletion()
        } else {
            
            toggleServer()
            totalGamesPlayed += 1
        }

        tiebreak = Tiebreak()
        set = Set()
        game = Game()
        tiebreakPointCount = 0
    }
    
    private func handleSetCompletion() {
        let currentSetScore = (set.getPlayer1GamesWon(), set.getPlayer2GamesWon())
        allPreviousSetScores.append(currentSetScore)
        
        let isFinalSet = (player1SetsWon + player2SetsWon == 4)
        
        if isFinalSet {
            // In the final set, start tiebreak at 12-12
            if currentSetScore.0 == 12 && currentSetScore.1 == 12 {
                startTiebreak()
            } else {
                awardSetToWinner()
            }
        } else {
            // In regular sets, start tiebreak at 6-6
            if currentSetScore.0 == 6 && currentSetScore.1 == 6 {
                startTiebreak()
            } else {
                awardSetToWinner()
            }
        }
        
        // reset for the next set
        if !match.matchComplete() {
            resetForNewSet()
        }
    }
    
    private func awardSetToWinner() {
        if set.player1WonSet() {
            match.addSetToPlayer1()
            player1SetsWon += 1
        } else {
            match.addSetToPlayer2()
            player2SetsWon += 1
        }
    }
    
    private func resetForNewSet() {
        set = Set()
        player1GamesWon = 0
        player2GamesWon = 0
        game = Game()
        isPlayer1Serving = !isPlayer1Serving
    }
    
    private func startTiebreakInFinalSet() {
        tiebreak = Tiebreak()
        tiebreakPointCount = 0
        updateTiebreakServer()
    }
    
    func getPreviousSetScores() -> [(Int, Int)] {
        return allPreviousSetScores
    }
    
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
    
    // code adapted from Nelson, 2024
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
    // end of adapted code

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
