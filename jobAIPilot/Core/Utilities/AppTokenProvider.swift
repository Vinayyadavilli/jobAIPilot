import Foundation
import NetworkKit

public final class AppTokenProvider: TokenProviding, @unchecked Sendable {
    public init() {}
    
    public var accessToken: String? {
        let token = UserDefaults.standard.string(forKey: "accessToken")
        return (token?.isEmpty == true) ? nil : token
    }
    
    public func refreshToken() async throws -> String {
        // Here you would implement your logic to use the refresh token
        // to request a new access token from the backend.
        // For now, we will throw an error to trigger a re-login flow if needed.
        throw URLError(.userAuthenticationRequired)
    }
}
