protocol MatchProtocol {
    func addSetToPlayer1()
    func addSetToPlayer2()
    func matchComplete() -> Bool
    func getPlayer1SetsWon() -> Int
    func getPlayer2SetsWon() -> Int
    func getSetsCount() -> Int
}
