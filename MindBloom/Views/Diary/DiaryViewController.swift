//
//  DiaryViewController.swift
//  MindBloom
//
//  Created by 임수미 on 6/4/25.
//

import UIKit

class DiaryViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mind1",
           let destinationVC = segue.destination as? MindDiaryViewController {
            destinationVC.selectedDate = datePicker.date
        }
        
        if segue.identifier == "gratitude1",
           let destinationVC = segue.destination as? GratitudeDiaryViewController{
            destinationVC.selectedDate = datePicker.date
        }
    }
    
    // 첫 화면으로 되돌아올 때 호출되는 IBAction
    @IBAction func unwindToDiary(_ segue: UIStoryboardSegue) {

    }
}
