//
//  DiaryRepository.swift
//  MindBloom
//
//  Created by 임수미 on 6/21/25.
//

import Foundation

protocol DiaryRepositoryProtocol {
    
    // Mind Diary
    func createMindDiary(_ dto: MindDiaryRequest) async throws -> MindDiaryResponse
    func fetchMindDiary(for date: String) async throws -> MindDiaryResponse
    
    // Gratitude Diary
    func createGratitudeDiary(_ dto: GratitudeDiaryRequest) async throws -> GratitudeDiaryResponse
    func fetchGratitudeDiary(for date: String) async throws -> GratitudeDiaryResponse
}

final class DiaryRepository: DiaryRepositoryProtocol {
    
    func createMindDiary(_ dto: MindDiaryRequest) async throws -> MindDiaryResponse {
        try await APIService.shared.requestJSON(
            endpoint: .createMindDiary,
            body: dto
        )
    }
    
    func fetchMindDiary(for date: String) async throws -> MindDiaryResponse {
        try await APIService.shared.requestJSON(
            endpoint: .getMindDiary(date: date)
        )
    }

    func createGratitudeDiary(_ dto: GratitudeDiaryRequest) async throws -> GratitudeDiaryResponse {
        try await APIService.shared.requestJSON(
            endpoint: .createGratitudeDiary,
            body: dto
        )
    }
    
    func fetchGratitudeDiary(for date: String) async throws -> GratitudeDiaryResponse {
        try await APIService.shared.requestJSON(
            endpoint: .getGratitudeDiary(date: date)
        )
    }
}
