//
//  GratitudeDiaryViewModel.swift
//  MindBloom
//
//  Created by 임수미 on 6/21/25.
//

import Foundation

@MainActor
final class GratitudeDiaryViewModel: ObservableObject {
    @Published var isSaved = false
    @Published var errorMessage: String?

    private let repo: DiaryRepositoryProtocol = DiaryRepository()

    func save(date: Date, gratitude1: String, gratitude2: String, gratitude3: String, gratitudeToMe: String) {
        Task {
            do {
                let dto = GratitudeDiaryRequest(
                    date: date,
                    gratitude_1: gratitude1,
                    gratitude_2: gratitude2,
                    gratitude_3: gratitude3,
                    gratitude_to_me: gratitudeToMe
                )
                _ = try await repo.createGratitudeDiary(dto)
                isSaved = true
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
