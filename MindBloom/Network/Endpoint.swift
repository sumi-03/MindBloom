//
//  Endpoint.swift
//  MindBloom
//
//  Created by 임수미 on 6/21/25.
//

import Foundation

enum Endpoint {
    static let base = "http://127.0.0.1:8000"

    case getMindDiary(date: String)
    case getGratitudeDiary(date: String)
    case getMoments(date: String)
    case createMindDiary
    case createGratitudeDiary
    case createMoment
    case deleteMoment(id: Int)
    
    var path: String {
        switch self {
        case .getMindDiary(let date): return "/mind/\(date)"
        case .getGratitudeDiary(let date): return "/gratitude/\(date)"
        case .getMoments(let date): return "/moments/\(date)"
        case .createMindDiary: return "/mind/"
        case .createGratitudeDiary: return "/gratitude/"
        case .createMoment: return "/moments/"
        case .deleteMoment(let id): return "/moments/\(id)"
        }
    }

    var url: URL { .init(string: Endpoint.base + path)!}
}
