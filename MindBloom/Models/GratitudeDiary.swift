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
    let user_id: String
    let date: Date
    let gratitude_1: String
    let gratitude_2: String
    let gratitude_3: String
    let gratitude_to_me: String
    let created_At: String
    let updated_at: String
}
