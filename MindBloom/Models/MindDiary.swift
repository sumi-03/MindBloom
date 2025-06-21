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

// 서버에서 받을 응답 - CodingKeys로 일관성 유지
struct MindDiaryResponse: Codable {
    let id: Int
    let userId: String
    let date: String
    let mood: String
    let content: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case date
        case mood
        case content
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
