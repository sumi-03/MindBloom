//
//  MomentRepository.swift
//  MindBloom
//
//  Created by 임수미 on 6/22/25.
//

import Foundation

protocol MomentRepositoryProtocol {
    func fetchMoments(for date: String) async throws -> [MomentResponse]
    func uploadMoment(date: Date, text: String, imageData: Data) async throws
    func deleteMoment(id: Int) async throws
}

final class MomentRepository: MomentRepositoryProtocol {
    
    func fetchMoments(for date: String) async throws -> [MomentResponse] {
        try await APIService.shared.requestJSON(
            endpoint: .getMoments(date: date)
        )
    }
    
    func uploadMoment(date: Date, text: String, imageData: Data) async throws {
        try await MomentUploader.uploadMoment(date: date, text: text, imageData: imageData)
    }
    
    
    func deleteMoment(id: Int) async throws {
        try await APIService.shared.requestDelete(endpoint: .deleteMoment(id: id))
    }
}
