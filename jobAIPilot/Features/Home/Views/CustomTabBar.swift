import SwiftUI

public enum TabSelection: Int, CaseIterable {
    case dashboard = 0
    case jobs
    case resumes // Now "AI"
    case notes
    case profile // Was interviews
    
    var title: String {
        switch self {
        case .dashboard: return "Dashboard"
        case .jobs: return "Jobs"
        case .resumes: return "AI"
        case .notes: return "Notes"
        case .profile: return "Profile"
        }
    }
    
    var iconName: String {
        switch self {
        case .dashboard: return "square.grid.2x2.fill"
        case .jobs: return "briefcase.fill"
        case .resumes: return "sparkles"
        case .notes: return "note.text"
        case .profile: return "person.fill"
        }
    }
}

public struct CustomTabBar: View {
    @Binding var selectedTab: TabSelection
    
    public var body: some View {
        HStack {
            ForEach(TabSelection.allCases, id: \.self) { tab in
                Spacer()
                
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedTab = tab
                    }
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: tab.iconName)
                            .font(.system(size: 20))
                        Text(tab.title)
                            .font(.system(size: 10, weight: .semibold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    .foregroundColor(selectedTab == tab ? DashboardTheme.textPrimary : DashboardTheme.textSecondary)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 10)
                    .background(
                        ZStack {
                            if selectedTab == tab {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(DashboardTheme.neonCyan.opacity(0.1))
                                
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(DashboardTheme.neonCyan, lineWidth: 1)
                                    .shadow(color: DashboardTheme.neonCyan.opacity(0.6), radius: 6)
                            }
                        }
                    )
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 16)
        .background(DashboardTheme.bgSecondary.opacity(0.95))
        .cornerRadius(32)
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(DashboardTheme.textPrimary.opacity(0.05), lineWidth: 1)
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
}
