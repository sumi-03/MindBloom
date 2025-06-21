//
//  Endpoint.swift
//  MindBloom
//
//  Created by 임수미 on 6/21/25.
//

import Foundation

enum Endpoint {
    static let base = "http://127.0.0.1:8000"

    case createMindDiary
    case createGratitudeDiary
    case createMoment
    
    var path: String {
        switch self {
        case .createMindDiary: return "/mind/"
        case .createGratitudeDiary: return "/gratitude/"
        case .createMoment: return "/moments/"
            
        }
    }

    var url: URL { .init(string: Endpoint.base + path)! }
}
