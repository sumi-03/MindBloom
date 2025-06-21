//
//  GratitudeDiaryRecordViewController.swift
//  MindBloom
//
//  Created by 임수미 on 6/21/25.
//

import UIKit
import Combine

@MainActor
final class GratitudeDiaryRecordViewController: UIViewController {

    var selectedDate: Date!

    @IBOutlet weak var gratitude1TextView: UITextView!
    @IBOutlet weak var gratitude2TextView: UITextView!
    @IBOutlet weak var gratitude3TextView: UITextView!
    @IBOutlet weak var gratitudeToMeTextView: UITextView!

    private let viewModel = RecordViewModel()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.fetchGratitudeDiary(date: selectedDate)
    }

    private func setupBindings() {
        viewModel.$gratitudeDiary
            .receive(on: DispatchQueue.main)
            .sink { [weak self] diary in
                if let diary = diary {
                    self?.gratitude1TextView.text = diary.gratitude1
                    self?.gratitude2TextView.text = diary.gratitude2
                    self?.gratitude3TextView.text = diary.gratitude3
                    self?.gratitudeToMeTextView.text = diary.gratitudeToMe
                } else {
                    self?.gratitude1TextView.text = "데이터 없음"
                    self?.gratitude2TextView.text = "데이터 없음"
                    self?.gratitude3TextView.text = "데이터 없음"
                    self?.gratitudeToMeTextView.text = "데이터 없음"
                }
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                if let error = error {
                    print("GratitudeDiary 불러오기 실패:", error)
                }
            }
            .store(in: &cancellables)
    }
}
