class Match {
    private var player1SetsWon: Int = 0
    private var player2SetsWon: Int = 0
    private var setsToWin: Int = 3
    
    func addSetToPlayer1() {
        if !matchComplete() { player1SetsWon += 1 }
    }
    
    func addSetToPlayer2() {
        if !matchComplete() { player2SetsWon += 1 }
    }
    
    func matchComplete() -> Bool {
        return player1SetsWon == setsToWin || player2SetsWon == setsToWin
    }
    
    func getPlayer1SetsWon() -> Int { return player1SetsWon }
    func getPlayer2SetsWon() -> Int { return player2SetsWon }
    func getSetsCount() -> Int { return player1SetsWon + player2SetsWon }
}
//class Match {
//    private var player1SetsWon: Int = 0
//    private var player2SetsWon: Int = 0
//    private var setsToWin: Int = 3
//    
//    func addSetToPlayer1() {
//        if matchComplete() {return}
//        return player1SetsWon += 1
//    }
//    
//    func addSetToPlayer2() {
//        if matchComplete() {return}
//        return player2SetsWon += 1
//    }
//
//    func matchComplete() -> Bool {
//        return player1SetsWon == setsToWin
//        || player2SetsWon == setsToWin
//    }
//    
//    func getSetsCount() -> Int {
//        return player1SetsWon + player2SetsWon
//    }
//    
//    
//    func getPlayer1SetsWon() -> Int {
//        return player1SetsWon
//    }
//    
//    func getPlayer2SetsWon() -> Int {
//        return player2SetsWon
//    }
//}
