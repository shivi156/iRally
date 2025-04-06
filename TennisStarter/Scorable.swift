protocol Scorable {
    
    func addPointToPlayer1()
    func addPointToPlayer2()
    func player1Score() -> String
    func player2Score() -> String
    func player1Won() -> Bool
    func player2Won() -> Bool
    func complete() -> Bool
    func gamePointsForPlayer1() -> Int
    func gamePointsForPlayer2() -> Int
}
