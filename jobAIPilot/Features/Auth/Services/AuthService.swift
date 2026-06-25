import Foundation
import NetworkKit

// MARK: - Auth Service Protocol

/// Defines the contract for authentication operations.
/// Any class conforming to this can be injected (real or mock for testing).
protocol AuthServiceProtocol {
    func login(request: LoginRequest) async throws -> TokenResponse
    func register(request: RegisterRequest) async throws -> UserResponse
}

// MARK: - Auth Service Implementation

/// Handles all authentication API calls using NetworkKit.
final class AuthService: AuthServiceProtocol {
    
    private let client: NetworkClientProtocol
    
    init(client: NetworkClientProtocol) {
        self.client = client
    }
    
    func login(request: LoginRequest) async throws -> TokenResponse {
        return try await client.send(request)
    }
    
    func register(request: RegisterRequest) async throws -> UserResponse {
        return try await client.send(request)
    }
}
