import NetworkKit

// MARK: - Login Request

/// Sends user credentials to the server and expects a TokenResponse back.
struct LoginRequest: NetworkRequest {
    typealias Response = TokenResponse
    
    let path = "/auth/login"
    let method: HTTPMethod = .POST
    
    let email: String
    let password: String
    
    private struct Body: Encodable {
        let email: String
        let password: String
    }
    
    var body: Encodable? {
        Body(email: email, password: password)
    }
}

// MARK: - Register Request

/// Sends user registration data to the server and expects a UserResponse back.
struct RegisterRequest: NetworkRequest {
    typealias Response = UserResponse
    
    let path = "/auth/register"
    let method: HTTPMethod = .POST
    
    let name: String
    let email: String
    let password: String
    
    private struct Body: Encodable {
        let name: String
        let email: String
        let password: String
    }
    
    var body: Encodable? {
        Body(name: name, email: email, password: password)
    }
}
