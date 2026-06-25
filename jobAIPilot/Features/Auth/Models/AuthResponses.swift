import Foundation

// MARK: - Token Response (Login Success)

/// Represents a successful authentication response from the server.
/// NetworkKit uses `convertFromSnakeCase`, so we use camelCase properties.
struct TokenResponse: Decodable {
    let accessToken: String?
    let refreshToken: String?
    let tokenType: String?
}

// MARK: - User Response (Registration Success)

/// Represents the user object returned after registration.
struct UserResponse: Decodable {
    let id: String?
    let email: String?
    let name: String?
    let isEmailVerified: Bool?
    let createdAt: String?
    let updatedAt: String?
}
