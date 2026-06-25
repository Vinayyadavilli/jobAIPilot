import Foundation

// MARK: - Auth Error

/// A clean, typed error enum for the Auth module.
/// This replaces messy NSError usage throughout the codebase.
enum AuthError: LocalizedError {
    case invalidCredentials
    case emailNotVerified(String)
    case serverError(String)
    case decodingFailed
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid email or password."
        case .emailNotVerified(let message):
            return message
        case .serverError(let message):
            return message
        case .decodingFailed:
            return "Failed to process server response."
        case .unknown:
            return "An unexpected error occurred."
        }
    }
}

// MARK: - Error Detail Dictionary

/// Represents the structured error detail returned by FastAPI
/// when the `detail` field is a dictionary (e.g., 403 email not verified).
struct ErrorDetailDict: Decodable {
    let code: String?
    let message: String?
    let hint: String?
}

// MARK: - Error Response

/// Handles FastAPI's polymorphic `detail` field.
/// FastAPI can return `detail` as either a plain String or a Dictionary.
struct ErrorResponse: Decodable {
    let detailMessage: String
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let stringDetail = try? container.decode(String.self, forKey: .detail) {
            self.detailMessage = stringDetail
        } else if let dictDetail = try? container.decode(ErrorDetailDict.self, forKey: .detail) {
            self.detailMessage = dictDetail.message ?? "An error occurred."
        } else {
            self.detailMessage = "Unknown error from server."
        }
    }
}
