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

    private func request(
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

        return try await URLSession.shared.data(for: request)
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
        
        return try JSONDecoder().decode(Res.self, from: data)
    }
}
