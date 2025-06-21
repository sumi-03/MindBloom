//
//  GratitudeDiaryLastViewController.swift
//  MindBloom
//
//  Created by 임수미 on 6/21/25.
//
import UIKit
import Combine

final class GratitudeDiaryLastViewController: UIViewController {
    
    @IBOutlet weak var gratitudeToMeTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var selectedDate: Date!
    var gratitude1: String!
    var gratitude2: String!
    var gratitude3: String!

    private let viewModel = GratitudeDiaryViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.$isSaved
            .sink { [weak self] saved in
                if saved { self?.dismiss(animated: true) }
            }
            .store(in: &cancellables)
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        viewModel.save(
            date: selectedDate,
            gratitude1: gratitude1,
            gratitude2: gratitude2,
            gratitude3: gratitude3,
            gratitudeToMe: gratitudeToMeTextView.text ?? ""
        )
    }
}
