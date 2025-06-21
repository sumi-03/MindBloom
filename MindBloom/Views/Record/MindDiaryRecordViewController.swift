//
//  MindDiaryRecordViewController.swift
//  MindBloom
//
//  Created by 임수미 on 6/21/25.
//

import UIKit
import Combine

final class MindDiaryRecordViewController: UIViewController {
    
    var selectedDate: Date!
    
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var contentView: UITextView!
    
    private let viewModel = RecordViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.fetchMindDiary(date: selectedDate)
    }
    
    private func setupBindings() {
        viewModel.$mindDiary
            .receive(on: DispatchQueue.main)
            .sink { [weak self] diary in
                if let diary = diary {
                    self?.moodLabel.text = diary.mood
                    self?.contentView.text = diary.content
                } else {
                    self?.moodLabel.text = "데이터 없음"
                    self?.contentView.text = "데이터 없음"
                }
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                if let error = error {
                    print("MindDiary 불러오기 실패:", error)
                }
            }
            .store(in: &cancellables)
    }
}
