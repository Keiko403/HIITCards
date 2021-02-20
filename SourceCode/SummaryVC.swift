//
//  SummaryVC.swift
//  DeckOCardsGym
//
//  Created by Keith Taffs on 19/02/2021.
//

import UIKit

var endTimer = "0"

class SummaryVC: UIViewController {
    
    @IBOutlet weak var lblExercise0: UILabel!
    @IBOutlet weak var lblExercise1: UILabel!
    @IBOutlet weak var lblExercise2: UILabel!
    @IBOutlet weak var lblExercise3: UILabel!
    @IBOutlet weak var lblSumTotalCards: UILabel!
    @IBOutlet weak var lblSumTotalReps: UILabel!
    @IBOutlet weak var lblSumTimer: UILabel!
    @IBOutlet weak var lblSumHeartReps: UILabel!
    @IBOutlet weak var lblSumClubReps: UILabel!
    @IBOutlet weak var lblSumDiamondReps: UILabel!
    @IBOutlet weak var lblSumSpadeReps: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.systemTeal.cgColor, UIColor.systemGreen.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.layer.insertSublayer(gradient, at: 0)
        
        timeString(time: timeElapsed)
        
        lblExercise0.text = suits[0][5] as? String ?? "Unknown"
        lblExercise1.text = suits[1][5] as? String ?? "Unknown"
        lblExercise2.text = suits[2][5] as? String ?? "Unknown"
        lblExercise3.text = suits[3][5] as? String ?? "Unknown"
        lblSumTotalCards.text = String(cardsCompleted)
        lblSumTotalReps.text = String(repsCompleted)
        lblSumTimer.text = String(endTimer)
        lblSumHeartReps.text = String(heartReps)
        lblSumClubReps.text = String(clubReps)
        lblSumDiamondReps.text = String(diamondReps)
        lblSumSpadeReps.text = String(spadeReps)
    }
    
    @IBAction func dismissSummaryVC(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func timeString(time: TimeInterval) -> String {
        let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60

        // return formated string
        endTimer = String(format: "%02i:%02i:%02i", hour, minute, second)
        return String(format: "%02i:%02i:%02i", hour, minute, second)
    }
}
