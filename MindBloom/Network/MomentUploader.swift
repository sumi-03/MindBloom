//
//  MomentUploader.swift
//  MindBloom
//
//  Created by 임수미 on 6/21/25.
//

import Foundation
import FirebaseAuth

enum MomentUploader {

    // 모먼트 업로드
    static func uploadMoment(date: Date, text: String, imageData: Data) async throws {
        // Firebase 토큰
        guard let user = Auth.auth().currentUser else {
            throw URLError(.userAuthenticationRequired)
        }
        let token = try await user.getIDToken()

        // URL
        let url = Endpoint.createMoment.url   // "/moments/"

        // 요청 설정
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        // multipart 바디 작성
        request.httpBody = createMultipartBody(boundary: boundary, date: date, text: text, imageData: imageData)

        // 전송
        let (_, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }

    private static func createMultipartBody(boundary: String, date: Date, text: String, imageData: Data) -> Data {
        var body = Data()

        // 날짜를 "YYYY-MM-DD"로 변환
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        df.timeZone = TimeZone(secondsFromGMT: 0)
        let dateString = df.string(from: date)

        // 텍스트 필드들
        appendFormField(&body, boundary: boundary, name: "date", value: dateString)
        appendFormField(&body, boundary: boundary, name: "text", value: text)

        // 이미지 파일
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"image_file\"; filename=\"moment.jpg\"\r\n")
        body.append("Content-Type: image/jpeg\r\n\r\n")
        body.append(imageData)
        body.append("\r\n")

        // 마무리
        body.append("--\(boundary)--\r\n")
        return body
    }

    private static func appendFormField(_ body: inout Data, boundary: String, name: String, value: String) {
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n")
        body.append("\(value)\r\n")
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
