//
//  MindDiaryViewModel.swift
//  MindBloom
//
//  Created by 임수미 on 6/21/25.
//

import Foundation

@MainActor
final class MindDiaryViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var isSaved = false

    private let repo: DiaryRepositoryProtocol = DiaryRepository()

    func save(date: Date, mood: String, thought: String) {
        Task {
            do {
                let dto = MindDiaryRequest(
                    date: date,
                    mood: mood,
                    content: thought
                )
                _ = try await repo.createMindDiary(dto)
                isSaved = true
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
