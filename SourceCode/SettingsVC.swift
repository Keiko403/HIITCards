//
//  SettingsVC.swift
//  DeckOCardsGym
//
//  Created by Keith Taffs on 07/11/2020.
//

import UIKit

class SettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellIdentifier")
        }
        cell?.imageView?.image = UIImage(systemName: suits[indexPath.row][1] as! String)
        cell?.imageView?.tintColor = (suits[indexPath.row][2] as? UIColor)
        cell?.imageView?.backgroundColor = .white
        cell?.textLabel?.text = (suits[indexPath.row][4] as! String)
        cell?.detailTextLabel?.text = (suits[indexPath.row][5] as! String)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alert = UIAlertController(title: (suits[indexPath.row][4] as! String), message: "Enter Exercise", preferredStyle: .alert)
        alert.addTextField{(exercise) in
            exercise.text = ""
            exercise.placeholder = (suits[indexPath.row][5] as! String)
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Done", style: .default){[unowned self] action in
            let newExercise = (alert.textFields![0].text ?? "")
            
            if newExercise != "" {
                suits[indexPath.row][5] = newExercise
            } else {
                return
            }
        tblSuits.reloadData()
        })
        self.present(alert, animated: true)
    }
    
    @IBOutlet weak var tblSuits: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
