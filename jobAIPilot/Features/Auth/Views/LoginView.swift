import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel
    
    // In a real app, you might use a coordinator or navigation stack to manage routing.
    @State private var navigateToHome = false
    @State private var showRegister = false
    
    init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: AppTheme.Spacing.xl) {
                // Header
                VStack(spacing: AppTheme.Spacing.xs) {
                    Image(systemName: "apple.intelligence")
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [AppTheme.Colors.primary, AppTheme.Colors.accent],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 64, height: 64)
                        .background(
                            RoundedRectangle(cornerRadius: AppTheme.Radius.medium, style: .continuous)
                                .fill(AppTheme.Colors.primaryLight.opacity(0.5))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: AppTheme.Radius.medium, style: .continuous)
                                .strokeBorder(AppTheme.Colors.primary.opacity(0.2), lineWidth: 1)
                        )
                        .appShadow(AppTheme.Shadow.small)
                        .padding(.bottom, AppTheme.Spacing.xs)
                    
                    AppText("Welcome Back", style: .largeTitle)
                    
                    AppText("Sign in to continue", style: .subheadline, color: AppTheme.Colors.textSecondary)
                }
                .padding(.bottom, AppTheme.Spacing.xxl)
                
                // Form Fields
                VStack(spacing: AppTheme.Spacing.md) {
                    AppTextField("Email", text: $viewModel.email,
                                 icon: "envelope",
                                 keyboardType: .emailAddress,
                                 autocapitalization: .never)
                    
                    AppTextField("Password", text: $viewModel.password,
                                 icon: "lock",
                                 isSecure: true)
                }
                HStack {
                    Spacer()
                    AppButton("Forgot Password?", style: .ghost, size: .small, isFullWidth: false) { }
                }
                
                // Error Message
                if let errorMessage = viewModel.errorMessage {
                    AppText(errorMessage, style: .footnote, color: AppTheme.Colors.error, alignment: .center)
                }
                
                // Login Button
                AppAsyncButton("Sign In", style: .gradient, isDisabled: false) {
                    await viewModel.login()
                }
                .padding(.top, AppTheme.Spacing.md)
                
                HStack(spacing: 16) {
                    Rectangle()
                        .fill(Color(.systemGray4))
                        .frame(height: 1)
                    AppText("Or Continue with" , style: .footnote, color: .secondary)
                        .layoutPriority(1)
                    Rectangle()
                        .fill(Color(.systemGray4))
                        .frame(height: 1)
                }
                AppButton("Continue with Google",style: .outline ,icon: .asset("Google")) {

                }
                
                Spacer()
                // Navigation to Register
                Button {
                    showRegister = true
                } label: {
                    HStack {
                        AppText("Don't have an account?", style: .body, color: AppTheme.Colors.textSecondary)
                        AppText("Sign Up", style: .button, color: AppTheme.Colors.primary)
                    }
                }
            }
            .padding(AppTheme.Spacing.md)
            .navigationDestination(isPresented: $showRegister) {
                // We inject the Auth Service to the Register View Model using DIContainer
                RegisterView(viewModel: DIContainer.shared.makeRegisterViewModel())
            }
            .navigationDestination(isPresented: $viewModel.isSuccess) {
                // Navigate to Home View on success
                // In a proper routing setup, this would change the root view of the app
                AppText("Home Screen (Authenticated)", style: .body)
            }
        }
    }
}

#Preview {
    LoginView(viewModel: DIContainer.shared.makeLoginViewModel())
}
