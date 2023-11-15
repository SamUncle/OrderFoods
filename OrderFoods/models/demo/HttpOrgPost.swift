
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let hTTPOrgPost = try? JSONDecoder().decode(HTTPOrgPost.self, from: jsonData)

import Foundation

// MARK: - HTTPOrgPost
struct HTTPOrgPost: Codable {
    let args: Args
    let data: String
    let files, form: Args
    let headers: Headers
    let httpOrgPostJSON: JSON
    let origin: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case args, data, files, form, headers
        case httpOrgPostJSON = "json"
        case origin, url
    }
}

// MARK: - Args
struct Args: Codable {
}

// MARK: - Headers
struct Headers: Codable {
    let accept, acceptEncoding, acceptLanguage, contentLength: String
    let contentType, host, userAgent, xAmznTraceID: String

    enum CodingKeys: String, CodingKey {
        case accept = "Accept"
        case acceptEncoding = "Accept-Encoding"
        case acceptLanguage = "Accept-Language"
        case contentLength = "Content-Length"
        case contentType = "Content-Type"
        case host = "Host"
        case userAgent = "User-Agent"
        case xAmznTraceID = "X-Amzn-Trace-Id"
    }
}

// MARK: - JSON
struct JSON: Codable {
    let firstName, lastName: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
