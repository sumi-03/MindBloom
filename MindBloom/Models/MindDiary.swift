//
//  MindDiary.swift
//  MindBloom
//
//  Created by 임수미 on 6/21/25.
//

import Foundation

// 서버로 보낼 JSON
struct MindDiaryRequest: Codable {
    let date: Date // "2025-06-21"
    let mood: String // ex) "VERY_GOOD"
    let content: String
}

// 서버에서 받을 응답 예시
struct MindDiaryResponse: Codable {
    let id: Int
    let date: String
    let mood: String
    let content: String
    let created_At: String
    let updated_at: String
}
