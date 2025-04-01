class Game {

    private var player1Points: Int = 0
    private var player2Points: Int = 0

    /**
     This method will be called when player 1 wins a point and update the state of the instance of Game to reflect the change
     */
    func addPointToPlayer1(){
        // This makes both their scores at least 40.
        if player1Points >= 3 && player2Points >= 3 {
            // They both have the same points (40), player 1 scores -> gets advantage
            if player1Points == player2Points {
                player1Points += 1
            }
            // if player 2 is ahead meaning advantage and player 1 scores -> 40 - 40
            else if player2Points > player1Points {
                player2Points -= 1
            }
            else {
                player1Points += 1
            }
            
        } else {
            player1Points += 1
        }
    }
    
    
    /**
     This method will be called when player 2 wins a point
     */
    func addPointToPlayer2(){
        if player1Points >= 3 && player2Points >= 3 {
            // deuce
            if player1Points == player2Points {
                player2Points += 1
            }
            else if player1Points > player2Points {
                player1Points -= 1
            }
            else {
                player2Points += 1
            }
        } else {
            player2Points += 1
        }
    }

    /**
     Returns the score for player 1, this will only ever be "0","15","30","40" or "A"
     If the game is complete, this should return an empty string
     */
    func player1Score() -> String {
        if complete() {
            return ""
        }
        else if (player1Points >= 4) && ((player1Points - player2Points) <= 2) {
            return "A"
        }
        return ["0", "15", "30", "40"][min(player1Points, 3)]
    }

    /**
     Returns the score for player 2, this will only ever be "0","15","30","40" or "A"
     If the game is complete, this should return an empty string
     */
    func player2Score() -> String {
        if complete() {
            return ""
        }
        else if (player2Points >= 4) && ((player2Points - player1Points) <= 2) {
            return "A"
        }
        return ["0", "15", "30", "40"][min(player2Points, 3)]
    }

    /**
     Returns true if player 1 has won the game, false otherwise
     */
    func player1Won() -> Bool{
        if (player1Points >= 4) && ((player1Points - player2Points) >= 2) {
            return true
        }
        return false
    }
    
    /**
     Returns true if player 2 has won the game, false otherwise
     */
    func player2Won() -> Bool{
        if (player2Points >= 4) && ((player2Points - player1Points) >= 2) {
            return true
        }
        return false
    }
    
    /**
     Returns true if the game is finished, false otherwise
     */
    func complete() ->Bool {
        if player1Won() || player2Won() {
            return true
        }
        return false
    }
    
    /**
     If player 1 would win the game if they won the next point, returns the number of points player 2 would need to win to equalise the score, otherwise returns 0
     e.g. if the score is 40:15 to player 1, player 1 would win if they scored the next point, and player 2 would need 2 points in a row to prevent that, so this method should return 2 in that case.
     */
    func gamePointsForPlayer1() -> Int {
        if player1Points >= 3 && player1Points > player2Points && !complete() {
            return player1Points - player2Points
        }
        return 0
    }
    
    /**
     If player 2 would win the game if they won the next point, returns the number of points player 1 would need to win to equalise the score
     */
    func gamePointsForPlayer2() -> Int {
        if player2Points >= 3 && player2Points > player1Points && !complete() {
            return player2Points - player1Points
        }
        return 0
        
    }
    
}
