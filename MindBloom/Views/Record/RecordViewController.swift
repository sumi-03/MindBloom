//
//  RecordViewController.swift
//  MindBloom
//
//  Created by 임수미 on 6/20/25.
//

import UIKit

class RecordViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    private let viewModel = RecordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "record1",
           let nextVC = segue.destination as? MindDiaryRecordViewController {
            nextVC.selectedDate = datePicker.date
        }
        if segue.identifier == "record2",
           let nextVC = segue.destination as? GratitudeDiaryRecordViewController {
            nextVC.selectedDate = datePicker.date
        }
        if segue.identifier == "record3",
           let nextVC = segue.destination as? MomentRecordViewController {
            nextVC.selectedDate = datePicker.date
        }
    }
    
    // 첫 화면으로 되돌아올 때 호출되는 IBAction
    @IBAction func unwindToRecord(_ segue: UIStoryboardSegue) {
        
    }
}
