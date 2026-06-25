import SwiftUI

public struct ProfileView: View {
    @AppStorage("accessToken") var accessToken: String = ""
    @AppStorage("refreshToken") var refreshToken: String = ""
    
    public init() {}
    
    public var body: some View {
        ZStack {
            DashboardTheme.bgPrimary.ignoresSafeArea()
            
            VStack(spacing: 24) {
                // MARK: - Header
                HStack {
                    Text("Profile")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(DashboardTheme.textPrimary)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                // Profile Avatar Placeholder
                ZStack {
                    Circle()
                        .fill(DashboardTheme.bgSecondary)
                        .frame(width: 100, height: 100)
                        .overlay(
                            Circle().stroke(DashboardTheme.neonCyan.opacity(0.3), lineWidth: 2)
                        )
                    
                    Image(systemName: "person.fill")
                        .font(.system(size: 40))
                        .foregroundColor(DashboardTheme.neonCyan)
                }
                .padding(.top, 40)
                
                Text("User Profile")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(DashboardTheme.textPrimary)
                
                Spacer()
                
                // MARK: - Logout Button
                Button(action: {
                    logout()
                }) {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Log Out")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(DashboardTheme.textPrimary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color(hex: "F43F5E")) // Red color for logout
                    .cornerRadius(16)
                    .shadow(color: Color(hex: "F43F5E").opacity(0.3), radius: 10, x: 0, y: 0)
                }
                .padding(.horizontal, 20)
                
                // Extra padding for the custom tab bar
                Spacer().frame(height: 100)
            }
        }
    }
    
    private func logout() {
        // Clear tokens to trigger app state change back to LoginView
        accessToken = ""
        refreshToken = ""
    }
}
