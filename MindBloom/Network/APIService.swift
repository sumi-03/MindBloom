//
//  APIService.swift
//  MindBloom
//
//  Created by 임수미 on 6/21/25.
//

import Foundation
import FirebaseAuth

final class APIService {
    static let shared = APIService()
    private init() {}

    func request(
        endpoint: Endpoint,
        method: String = "GET",
        body: Data? = nil
    ) async throws -> (Data, URLResponse) {

        // Firebase 인증 토큰
        guard let user = Auth.auth().currentUser else {
            throw URLError(.userAuthenticationRequired)
        }
        let token = try await user.getIDToken()

        // URL 조립
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = method
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body

        let (data, response) = try await URLSession.shared.data(for: request)
        
        // HTTP 상태 코드 검증
        if let httpResponse = response as? HTTPURLResponse {
            guard 200...299 ~= httpResponse.statusCode else {
                throw URLError(.badServerResponse)
            }
        }
        
        #if DEBUG
        if let http = response as? HTTPURLResponse {
            print("🧾 \(method) status: \(http.statusCode)")
        }
        print("📥 \(method) response: \(String(data: data, encoding: .utf8) ?? "empty")")
        #endif
        
        return (data, response)
    }
    
    // DELETE 전용 메서드 추가
    func requestDelete(endpoint: Endpoint) async throws {
        let _ = try await request(endpoint: endpoint, method: "DELETE")
    }

    func requestJSON<Res: Decodable>(
        endpoint: Endpoint,
        method: String = "GET"
    ) async throws -> Res {

        // Firebase 인증 토큰
        guard let user = Auth.auth().currentUser else {
            throw URLError(.userAuthenticationRequired)
        }
        let token = try await user.getIDToken()

        var request = URLRequest(url: endpoint.url)
        request.httpMethod = method
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)

        // HTTP 상태 코드 검증
        if let httpResponse = response as? HTTPURLResponse {
            guard 200...299 ~= httpResponse.statusCode else {
                throw URLError(.badServerResponse)
            }
        }
        
        #if DEBUG
        if let http = response as? HTTPURLResponse {
            print("🧾 status: \(http.statusCode)")
        }
        print("📥 \(String(data: data, encoding: .utf8) ?? "")")
        #endif

        // 날짜 디코딩 전략 추가
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return try decoder.decode(Res.self, from: data)
    }
    
    func requestJSON<Req: Encodable, Res: Decodable>(
        endpoint: Endpoint,
        method: String = "POST",
        body: Req
    ) async throws -> Res {

        // 날짜가 포함될 수 있으니 ISO8601로 인코딩 (FastAPI 기본값과 호환)
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let jsonData = try encoder.encode(body)

        let (data, response) = try await request(
            endpoint: endpoint,
            method: method,
            body: jsonData
        )
        
        // 날짜 디코딩
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return try decoder.decode(Res.self, from: data)
    }
}
