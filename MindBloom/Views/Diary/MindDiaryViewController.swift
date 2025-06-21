//
//  MindDiaryViewController.swift
//  MindBloom
//
//  Created by 임수미 on 6/4/25.
//

import UIKit

class MindDiaryViewController: UIViewController {
    
    var selectedDate: Date!
    private var selectedMood: String?
    
    // 8개의 옵션 버튼을 한꺼번에 담을 배열
    @IBOutlet var weatherButtons: [UIButton]!

    // '다음으로' 버튼도 미리 연결
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // 선택 상태에 따라 테두리 색을 갱신
    func updateButtonBorders() {
        for btn in weatherButtons {
            if btn.isSelected {
                btn.layer.borderWidth = 2
                btn.layer.borderColor = UIColor.red.cgColor
            } else {
                btn.layer.borderWidth = 0
            }
        }
    }
    
    
    
    @IBAction func weatherOptionTapped(_ sender: UIButton) {
        // 다른 버튼은 모두 선택 해제
        for btn in weatherButtons {
            btn.isSelected = false
        }
        // 탭된 버튼만 선택 상태로 변경
        sender.isSelected = true

        // 테두리 갱신
        updateButtonBorders()
        
        // 선택한 기분 문자열 저장
        selectedMood = sender.titleLabel?.text
        
        // '다음으로' 버튼 활성화
        nextButton.isEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mind2" {
            if let nextVC = segue.destination as? MindDiaryLastViewController {
                nextVC.selectedDate = self.selectedDate   // 캘린더에서 고른 날짜
                nextVC.selectedMood = self.selectedMood   // 예: "맑음"
            }
        }
    }
    

}


