class Game {
      
    /**
     This method will be called when player 1 wins a point and update the state of the instance of Game to reflect the change
     */
    func addPointToPlayer1(){
        
    }
    
    /**
     This method will be called when player 2 wins a point
     */
    func addPointToPlayer2(){
        
    }

    /**
     Returns the score for player 1, this will only ever be "0","15","30","40" or "A"
     If the game is complete, this should return an empty string
     */
    func player1Score() -> String {
        return ""
        
    }

    /**
     Returns the score for player 2, this will only ever be "0","15","30","40" or "A"
     If the game is complete, this should return an empty string
     */
    func player2Score() -> String {
        return ""
        
    }
    
    /**
     Returns true if player 1 has won the game, false otherwise
     */
    func player1Won() -> Bool{
        return false
        
    }
    
    /**
     Returns true if player 2 has won the game, false otherwise
     */
    func player2Won() -> Bool{
        return false
        
    }
    
    /**
     Returns true if the game is finished, false otherwise
     */
    func complete() ->Bool {
        return false
        
    }
    
    /**
     If player 1 would win the game if they won the next point, returns the number of points player 2 would need to win to equalise the score, otherwise returns 0
     e.g. if the score is 40:15 to player 1, player 1 would win if they scored the next point, and player 2 would need 2 points in a row to prevent that, so this method should return 2 in that case.
     */
    func gamePointsForPlayer1() -> Int{
        return 0
        
    }
    
    /**
     If player 2 would win the game if they won the next point, returns the number of points player 1 would need to win to equalise the score
     */
    func gamePointsForPlayer2() -> Int {
        return 0
        
    }
    
}

