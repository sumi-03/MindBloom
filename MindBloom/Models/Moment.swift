//
//  Moment.swift
//  MindBloom
//
//  Created by 임수미 on 6/22/25.
//

import Foundation

// 백엔드 응답용 모델
struct MomentResponse: Codable {
    let id: Int
    let userId: String
    let date: String
    let text: String
    let image: MomentImage
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case date
        case text
        case image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct MomentImage: Codable {
    let id: Int
    let momentId: Int
    let url: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case momentId = "moment_id"
        case url
        case createdAt = "created_at"
    }
    
    // 전체 이미지 URL 생성
    var fullImageURL: String {
        return "http://127.0.0.1:8000\(url)"
    }
}
