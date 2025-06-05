protocol TiebreakProtocol {
    func addPointToPlayer1()
    func addPointToPlayer2()
    func player1Score() -> Int
    func player2Score() -> Int
    func player1Won() -> Bool
    func player2Won() -> Bool
    func complete() -> Bool
    func reset()
}
