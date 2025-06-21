//
//  RecordViewModel.swift
//  MindBloom
//
//  Created by 임수미 on 6/21/25.
//

import Foundation

@MainActor
final class RecordViewModel: ObservableObject {
    @Published var mindDiary: MindDiaryResponse?
    @Published var gratitudeDiary: GratitudeDiaryResponse?
    @Published var errorMessage: String?
    @Published var isLoading = false

    private let repo: DiaryRepositoryProtocol = DiaryRepository()

    func fetchMindDiary(date: Date) {
        Task {
            isLoading = true
            errorMessage = nil
            
            do {
                // 날짜를 서버 요구 형식(yyyy-MM-dd)으로 변환
                let dateString = formatDateForAPI(date)
                
                // API 호출
                let response = try await repo.fetchMindDiary(for: dateString)
                mindDiary = response
                
            } catch {
                errorMessage = error.localizedDescription
                mindDiary = nil
            }
            
            isLoading = false
        }
    }
    
    func fetchGratitudeDiary(date: Date) {
        Task {
            isLoading = true
            errorMessage = nil
            
            do {
                let dateString = formatDateForAPI(date)
                let response = try await repo.fetchGratitudeDiary(for: dateString)
                gratitudeDiary = response
                
            } catch {
                errorMessage = error.localizedDescription
                gratitudeDiary = nil
            }
            
            isLoading = false
        }
    }
    
    private func formatDateForAPI(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: date)
    }
}
