//
//  GratitudeDiaryViewController.swift
//  MindBloom
//
//  Created by 임수미 on 6/21/25.
//

import UIKit

final class GratitudeDiaryViewController: UIViewController {

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    
    var selectedDate: Date!  // DiaryViewController에서 전달됨

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gratitude2" {
            guard let nextVC = segue.destination as? GratitudeDiaryLastViewController else { return }

            nextVC.selectedDate = self.selectedDate
            nextVC.gratitude1 = textField1.text ?? ""
            nextVC.gratitude2 = textField2.text ?? ""
            nextVC.gratitude3 = textField3.text ?? ""
        }
    }
}
