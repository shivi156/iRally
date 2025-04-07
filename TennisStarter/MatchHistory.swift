import Foundation

struct MatchHistory: Codable {
    let date: Date
    let player1SetScores: [Int]
    let player2SetScores: [Int]
}

//func saveMatchToHistory() {
//    let scores = set.getPreviousSetScores()
//    let p1 = scores.map { $0.0 }
//    let p2 = scores.map { $0.1 }
//    
//    let history = MatchHistory(date: Date(), player1SetScores: p1, player2SetScores: p2)
//
//    var allMatches = loadMatchHistory()
//    allMatches.append(history)
//
//    if let data = try? JSONEncoder().encode(allMatches) {
//        UserDefaults.standard.set(data, forKey: "matchHistory")
//    }
//}



