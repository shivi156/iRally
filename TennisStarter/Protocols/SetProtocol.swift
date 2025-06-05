protocol SetProtocol {
    func addGameToPlayer1()
    func addGameToPlayer2()
    func isTiebrake() -> Bool
    func complete() -> Bool
    func player1WonSet() -> Bool
    func player2WonSet() -> Bool
    func saveCurrentSetScore()
    func getPreviousSetScores() -> [(Int, Int)]
    func resetGame()
}
