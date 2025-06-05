class Tiebreak: TiebreakProtocol {
    
    private var player1Points = 0
    private var player2Points = 0
    
    func addPointToPlayer1() { player1Points += 1 }
    func addPointToPlayer2() { player2Points += 1 }
    
    func player1Score() -> Int { return player1Points }
    func player2Score() -> Int { return player2Points }
    
    func player1Won() -> Bool {
        return player1Points >= 7 && (player1Points - player2Points) >= 2
    }
    
    func player2Won() -> Bool {
        return player2Points >= 7 && (player2Points - player1Points) >= 2
    }
    
    func complete() -> Bool {
        return player1Won() || player2Won()
    }
    
    func reset() {
        player1Points = 0
        player2Points = 0
    }
}
