import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    
    // MARK: - Published Properties (UI State)
    
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isSuccess = false
    
    // MARK: - Dependencies
    
    private let authService: AuthServiceProtocol
    
    // MARK: - Init
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    // MARK: - Computed Properties
    
    var isValid: Bool {
        !email.trimmingCharacters(in: .whitespaces).isEmpty && !password.isEmpty
    }
    
    // MARK: - Actions
    
    func login() async {
        guard isValid else { return }
        
        isLoading = true
        errorMessage = nil
        
        let request = LoginRequest(email: email, password: password)
        
        do {
            let response = try await authService.login(request: request)
            
            // Store tokens securely
            UserDefaults.standard.set(response.accessToken, forKey: "accessToken")
            UserDefaults.standard.set(response.refreshToken, forKey: "refreshToken")
            isSuccess = true
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
