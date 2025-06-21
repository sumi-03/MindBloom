//
//  MomentViewModel.swift
//  MindBloom
//
//  Created by 임수미 on 6/22/25.
//

import Foundation

@MainActor
final class MomentViewModel: ObservableObject {
    @Published var moments: [MomentResponse] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let repository: MomentRepositoryProtocol = MomentRepository()
    
    func fetchMoments(for date: Date) {
        Task {
            isLoading = true
            errorMessage = nil
            
            do {
                let dateString = formatDateForAPI(date)
                let fetchedMoments = try await repository.fetchMoments(for: dateString)
                moments = fetchedMoments
            } catch {
                errorMessage = error.localizedDescription
                moments = []
            }
            
            isLoading = false
        }
    }
    
    func uploadMoment(date: Date, text: String, imageData: Data) {
        Task {
            isLoading = true
            errorMessage = nil
            
            do {
                try await repository.uploadMoment(date: date, text: text, imageData: imageData)
                // 업로드 후 다시 목록 조회
                await fetchMoments(for: date)
            } catch {
                errorMessage = error.localizedDescription
            }
            
            isLoading = false
        }
    }
    
    func deleteMoment(id: Int) async throws {
        isLoading = true
        errorMessage = nil
        
        do {
            try await repository.deleteMoment(id: id)
            
            // 삭제 후 현재 목록에서도 제거
            moments.removeAll { $0.id == id }
            
        } catch {
            errorMessage = error.localizedDescription
            throw error
        }
    }
        
    func formatDateForAPI(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: date)
    }
}
