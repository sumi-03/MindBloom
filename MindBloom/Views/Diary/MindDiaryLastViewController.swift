//
//  MindDiaryLastViewController.swift
//  MindBloom
//
//  Created by 임수미 on 6/21/25.
//

import UIKit
import Combine

final class MindDiaryLastViewController: UIViewController {

    @IBOutlet weak var thoughtTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!

    // 이전 화면에서 주입
    var selectedDate: Date!
    var selectedMood: String!

    private let viewModel = MindDiaryViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.$isSaved.sink { [weak self] done in
            if done { self?.dismiss(animated: true) }
        }
        .store(in: &cancellables)
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        viewModel.save(
            date: selectedDate,
            mood: selectedMood,
            thought: thoughtTextView.text ?? ""
        )
    }
}
