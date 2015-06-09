//
//  ViewController.swift
//  TennisStarter
//
//  Created by Andrew Muncey on 09/06/2015.
//  Copyright (c) 2015 University of Chester. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBOutlet weak var p1NameLabel: UILabel!
    @IBOutlet weak var p2NameLabel: UILabel!
    
    
    @IBOutlet weak var p1PointsLabel: UILabel!
    @IBOutlet weak var p2PointsLabel: UILabel!
    
    @IBOutlet weak var p1GamesLabel: UILabel!
    @IBOutlet weak var p2GamesLabel: UILabel!
    
    @IBOutlet weak var p1SetsLabel: UILabel!
    @IBOutlet weak var p2SetsLabel: UILabel!
    
    @IBOutlet weak var p1PreviousSetsLabel: UILabel!
    @IBOutlet weak var p2PreviousSetsLabel: UILabel!
    
    
    @IBAction func p1AddPointPressed(sender: UIButton) {
    }

    @IBAction func p2AddPointPressed(sender: UIButton) {
    }
}

