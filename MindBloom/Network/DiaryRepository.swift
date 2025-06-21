//
//  DiaryRepository.swift
//  MindBloom
//
//  Created by 임수미 on 6/21/25.
//

import Foundation

protocol DiaryRepositoryProtocol {
    func createMindDiary(_ dto: MindDiaryRequest) async throws -> MindDiaryResponse
}

final class DiaryRepository: DiaryRepositoryProtocol {
    func createMindDiary(_ dto: MindDiaryRequest) async throws -> MindDiaryResponse {
        try await APIService.shared.requestJSON(
            endpoint: .createMindDiary,
            body: dto
        )
    }
}
extension DiaryRepositoryProtocol {
    func createGratitudeDiary(_ dto: GratitudeDiaryRequest) async throws -> GratitudeDiaryResponse {
        try await APIService.shared.requestJSON(
            endpoint: .createGratitudeDiary,
            body: dto
        )
    }
}
