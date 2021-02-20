//
//  ViewController.swift
//  DeckOCardsGym
//
//  Created by Keith Taffs on 02/11/2020.
//

import UIKit

var suits = [[0, "suit.heart.fill", UIColor.red, "H", "Hearts", "Push Ups"],
             [1, "suit.club.fill", UIColor.black, "C", "Clubs", "Squats"],
             [2, "suit.diamond.fill", UIColor.red, "D", "Diamonds", "Burpees"],
             [3, "suit.spade.fill", UIColor.black, "S", "Spades", "Sit Ups"]]

var cards = [[Int(), String(), String(), Int()]]
var cardsCompleted = 0
var repsCompleted = 0
var heartReps = 0
var clubReps = 0
var diamondReps = 0
var spadeReps = 0
var timer: Timer?
var timeElapsed = 0.0
var timerRunning: Bool?

class ViewController: UIViewController {	
    
    @IBOutlet var cardBorder: UIView!
    @IBOutlet var imgTopLeft: UIImageView!
    @IBOutlet var imgBottomRight: UIImageView!
    @IBOutlet var lblTopLeft: UILabel!
    @IBOutlet var lblBottomRight: UILabel!
    @IBOutlet weak var lblExercise: UILabel!
    @IBOutlet weak var lblCardsCompleted: UILabel!
    @IBOutlet weak var lblRepsCompleted: UILabel!
    @IBOutlet weak var fullCardView: UIView!
    @IBOutlet weak var btnStopWorkout: UIBarButtonItem!
    @IBOutlet weak var btnRefreshPack: UIBarButtonItem!
    @IBOutlet weak var btnSummary: UIButton!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cardsCompleted = 0
        repsCompleted = 0
        heartReps = 0
        clubReps = 0
        diamondReps = 0
        spadeReps = 0
        lblCardsCompleted.text = String(cardsCompleted)
        lblRepsCompleted.text = String(repsCompleted)
        timerRunning = false
        startNew()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imgBottomRight.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        lblBottomRight.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        btnSummary.alpha = 0
        btnSummary.isEnabled = false
    }
    
    @IBAction func refreshPack(_ sender: Any) {
        lblExercise.isUserInteractionEnabled = true
        cardsCompleted = 0
        repsCompleted = 0
        heartReps = 0
        clubReps = 0
        diamondReps = 0
        spadeReps = 0
        lblCardsCompleted.text = String(cardsCompleted)
        lblRepsCompleted.text = String(repsCompleted)
        startNew()
    }
    
    @IBAction func endWorkout(_ sender: Any) {
        lblCardsCompleted.text = String(cardsCompleted)
        lblRepsCompleted.text = String(repsCompleted)
        workoutFinished()
    }
    
    @IBAction func didTapExerciseLabel(_ sender: UITapGestureRecognizer) {
        lblCardsCompleted.text = String(cardsCompleted)
        lblRepsCompleted.text = String(repsCompleted)
        newDeal()
    }
    
    @IBAction func didTapSummaryBtn(_ sender: UIButton) {
        
    }
    
    
    //MARK: - Create Card Array
    func createCardArray(){
        cards.removeAll()
        for s in 0...3 {
            for i in 2...14 {
                switch i {
                case 2...10:
                    cards += [[Int(s), String(i), String("\(i)\(suits[s][3])"), Int(i)]]
                case 11:
                    cards += [[Int(s), String("J"), String("J\(suits[s][3])"), 11]]
                case 12:
                    cards += [[Int(s), String("Q"), String("Q\(suits[s][3])"), 12]]
                case 13:
                    cards += [[Int(s), String("K"), String("K\(suits[s][3])"), 13]]
                case 14:
                    cards += [[Int(s), String("A"), String("A\(suits[s][3])"), 14]]
                default:
                    print("Error generating cards")
                    break
                }
            }
        }
        cards.shuffle()
    }
    
    @objc func runTimedCode() {
        timeElapsed += 1
        print(timeElapsed)
    }
    
    //MARK: - New Deal
    func newDeal(){
        if timerRunning == false {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        timerRunning = true
        }
            
        cardFlip()
        btnStopWorkout.isEnabled = true
        btnRefreshPack.isEnabled = false
        
        if cards.count >= 1 {
            let num = Int(arc4random_uniform(UInt32(cards.count)))
            let num2 = cards[num][0] as! Int
            cardsCompleted += 1
            repsCompleted += Int(cards[num][3] as! Int)
            imgBottomRight.image = UIImage(systemName: suits[num2][1] as! String)
            imgTopLeft.image = UIImage(systemName: suits[num2][1] as! String)
            lblBottomRight.text = cards[num][1] as? String
            lblTopLeft.text = cards[num][1] as? String
            cardBorder.backgroundColor = suits[num2][2] as? UIColor
            imgBottomRight.tintColor = suits[num2][2] as? UIColor
            imgTopLeft.tintColor = suits[num2][2] as? UIColor
            lblExercise.text = String("\(cards[num][3] as! Int)\n\(suits[num2][5] as! String)")
            switch Int(suits[num2][0] as! Int) {
            case 0:
                heartReps += Int(cards[num][3] as! Int)
            case 1:
                clubReps += Int(cards[num][3] as! Int)
            case 2:
                diamondReps += Int(cards[num][3] as! Int)
            case 3:
                spadeReps += Int(cards[num][3] as! Int)
            default:
                print("Error determining exercise")
                break
            }
            cards.remove(at: num)
        } else {
            workoutFinished()
        }
    }
    

    
    //MARK: - Workout Finished
    func workoutFinished(){
        cardFlip()
        cards.removeAll()
        imgBottomRight.image = UIImage(systemName: "checkmark.seal.fill")
        imgTopLeft.image = UIImage(systemName: "checkmark.seal.fill")
        lblBottomRight.text = ""
        lblTopLeft.text = ""
        cardBorder.backgroundColor = .systemGreen
        imgBottomRight.tintColor = .systemGreen
        imgTopLeft.tintColor = .systemGreen
        lblExercise.text = "Workout\nFinished"
        lblExercise.isUserInteractionEnabled = false
        btnStopWorkout.isEnabled = false
        btnRefreshPack.isEnabled = true
        summaryButtonIn()
        timer?.invalidate()
        timerRunning = false
    }
    
    //MARK: - New Workout
    func startNew(){
        cardFlip()
        createCardArray()
        imgBottomRight.image = UIImage(systemName: "checkmark.seal.fill")
        imgTopLeft.image = UIImage(systemName: "checkmark.seal.fill")
        lblBottomRight.text = ""
        lblTopLeft.text = ""
        cardBorder.backgroundColor = .systemGreen
        imgBottomRight.tintColor = .systemGreen
        imgTopLeft.tintColor = .systemGreen
        lblExercise.text = "New\nWorkout"
        lblExercise.isUserInteractionEnabled = true
        btnStopWorkout.isEnabled = false
        btnRefreshPack.isEnabled = false
        btnSummary.alpha = 0
        btnSummary.isEnabled = false
        timeElapsed = 0
    }
    
    //MARK: - cardFlip
    func cardFlip(){
        UIView.animate(withDuration: 0.25, delay: 0, options: .transitionFlipFromRight, animations: {
            self.fullCardView.transform = CGAffineTransform(scaleX: -1, y: 1)
        }, completion: nil)
        self.fullCardView.transform = CGAffineTransform(scaleX: 1, y: 1)
    }
    
    //MARK: - summaryButtonIn
    func summaryButtonIn(){
        btnSummary.isEnabled = true
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations:{
                        self.btnSummary.alpha = 1}, completion: nil)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.repeat, .autoreverse, .allowUserInteraction], animations:{
            self.btnSummary.transform = CGAffineTransform(scaleX: 1.075, y: 1.075)
        }, completion: { (finished) in
            self.btnSummary.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
}
