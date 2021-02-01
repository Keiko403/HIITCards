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

class ViewController: UIViewController {	
    
    @IBOutlet var cardBorder: UIView!
    @IBOutlet var imgTopLeft: UIImageView!
    @IBOutlet var imgBottomRight: UIImageView!
    @IBOutlet var lblTopLeft: UILabel!
    @IBOutlet var lblBottomRight: UILabel!
    @IBOutlet weak var lblExercise: UILabel!
    @IBOutlet weak var lblCardsCompleted: UILabel!
    @IBOutlet weak var lblRepsCompleted: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cardsCompleted = 0
        repsCompleted = 0
        lblCardsCompleted.text = String(cardsCompleted)
        lblRepsCompleted.text = String(repsCompleted)
        createCardArray()
        newDeal()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imgBottomRight.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        lblBottomRight.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    @IBAction func refreshPack(_ sender: Any) {
        cardsCompleted = 0
        repsCompleted = 0
        lblCardsCompleted.text = String(cardsCompleted)
        lblRepsCompleted.text = String(repsCompleted)
        createCardArray()
        newDeal()
    }	
    
    
    @IBAction func didTapExerciseLabel(_ sender: UITapGestureRecognizer) {
        lblCardsCompleted.text = String(cardsCompleted)
        lblRepsCompleted.text = String(repsCompleted)
        newDeal()
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
    
    
    //MARK: - New Deal
    func newDeal(){
        if cards.count >= 1 {
            let num = Int(arc4random_uniform(UInt32(cards.count)))
            let num2 = cards[num][0] as! Int
            cardsCompleted += 1
                //print(cardsCompleted)
            repsCompleted += Int(cards[num][3] as! Int)
                //print(repsCompleted)
            imgBottomRight.image = UIImage(systemName: suits[num2][1] as! String)
            imgTopLeft.image = UIImage(systemName: suits[num2][1] as! String)
            lblBottomRight.text = cards[num][1] as? String
            lblTopLeft.text = cards[num][1] as? String
            cardBorder.backgroundColor = suits[num2][2] as? UIColor
            imgBottomRight.tintColor = suits[num2][2] as? UIColor
            imgTopLeft.tintColor = suits[num2][2] as? UIColor
            lblExercise.text = String("\(cards[num][3] as! Int)\n\(suits[num2][5] as! String)")
            cards.remove(at: num)
        } else {
            workoutFinished()
        }
    }
    
    //MARK: - Workout Finished
    func workoutFinished(){
        imgBottomRight.image = UIImage(systemName: "checkmark.seal.fill")
        imgTopLeft.image = UIImage(systemName: "checkmark.seal.fill")
        lblBottomRight.text = ""
        lblTopLeft.text = ""
        cardBorder.backgroundColor = .systemGreen
        imgBottomRight.tintColor = .systemGreen
        imgTopLeft.tintColor = .systemGreen
        lblExercise.text = "Workout\nFinished"
    }
}

