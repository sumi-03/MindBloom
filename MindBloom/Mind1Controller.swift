//
//  ViewController.swift
//  MindBloom
//
//  Created by 임수미 on 6/4/25.
//

import UIKit

class Mind1Controller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()      
    }

    /// 선택 상태에 따라 테두리를 갱신하는 헬퍼
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

    // 8개의 옵션 버튼을 한꺼번에 담을 배열
    @IBOutlet var weatherButtons: [UIButton]!

    // “다음으로” 버튼도 미리 연결
    @IBOutlet weak var nextButton: UIButton!
    
    
    @IBAction func weatherOptionTapped(_ sender: UIButton) {
        // 1) 다른 버튼은 모두 선택 해제
        for btn in weatherButtons {
            btn.isSelected = false
        }
        // 2) 탭된 버튼만 선택 상태로 변경
        sender.isSelected = true

        // 3) 테두리 갱신
        updateButtonBorders()
        
        // 4) '다음으로' 버튼 활성화
        nextButton.isEnabled = true
    }
    
}

