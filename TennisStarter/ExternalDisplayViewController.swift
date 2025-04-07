import UIKit

class ExternalDisplayViewController: UIViewController {
    
    let p1ScoreLabel = UILabel()
    let p2ScoreLabel = UILabel()
    let gameLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupLabels()
    }

    func setupLabels() {
        [p1ScoreLabel, p2ScoreLabel, gameLabel].forEach {
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 48, weight: .bold)
            $0.textColor = .white
            view.addSubview($0)
        }

        p1ScoreLabel.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 100)
        p2ScoreLabel.frame = CGRect(x: 0, y: 250, width: view.bounds.width, height: 100)
        gameLabel.frame = CGRect(x: 0, y: 400, width: view.bounds.width, height: 100)
    }

    func updateScores(p1: String, p2: String, game: String) {
        p1ScoreLabel.text = "Player 1: \(p1)"
        p2ScoreLabel.text = "Player 2: \(p2)"
        gameLabel.text = "Game Score: \(game)"
    }
}
