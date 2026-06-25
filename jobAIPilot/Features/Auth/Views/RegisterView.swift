import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel: RegisterViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: RegisterViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
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
                AppText("Create Account", style: .largeTitle)
                
                AppText("Join jobAIPilot today", style: .subheadline, color: AppTheme.Colors.textSecondary)
            }
            .padding(.bottom, AppTheme.Spacing.xxl)
            
            // Form Fields
            VStack(spacing: AppTheme.Spacing.md) {
                AppTextField("Full Name", text: $viewModel.name,
                             icon: "person")
                
                AppTextField("Email", text: $viewModel.email,
                             icon: "envelope",
                             keyboardType: .emailAddress,
                             autocapitalization: .never)
                
                AppTextField("Password", text: $viewModel.password,
                             icon: "lock",
                             isSecure: true)
            }
            
            // Error Message
            if let errorMessage = viewModel.errorMessage {
                AppText(errorMessage, style: .footnote, color: AppTheme.Colors.error, alignment: .center)
            }
            
            // Success Message
            if viewModel.isSuccess {
                AppText("Account created! Please check your email to verify.", style: .footnote, color: AppTheme.Colors.success, alignment: .center)
            }
            
            // Register Button
            AppButton("Create Account", style: .gradient) {}
            
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
            .padding(.top, AppTheme.Spacing.md)
            
            Spacer()
            
            // Navigation Back to Login
            Button {
                dismiss()
            } label: {
                HStack {
                    AppText("Already have an account?", style: .body, color: AppTheme.Colors.textSecondary)
                    AppText("Sign In", style: .button, color: AppTheme.Colors.primary)
                }
            }
        }
        .padding(AppTheme.Spacing.md)
        .navigationBarBackButtonHidden(true) // Hide default back button for custom UI
    }
}

#Preview {
    RegisterView(viewModel: DIContainer.shared.makeRegisterViewModel())
}
