//
//  GratitudeDiary.swift
//  MindBloom
//
//  Created by 임수미 on 6/21/25.
//

import Foundation

struct GratitudeDiaryRequest: Codable {
    let date: Date
    let gratitude_1: String
    let gratitude_2: String
    let gratitude_3: String
    let gratitude_to_me: String
}

struct GratitudeDiaryResponse: Codable {
    let id: Int
    let userId: String
    let date: String
    let gratitude1: String
    let gratitude2: String
    let gratitude3: String
    let gratitudeToMe: String
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case userId         = "user_id"
        case date
        case gratitude1     = "gratitude_1"
        case gratitude2     = "gratitude_2"
        case gratitude3     = "gratitude_3"
        case gratitudeToMe  = "gratitude_to_me"
        case createdAt      = "created_at"
        case updatedAt      = "updated_at"
    }
}
