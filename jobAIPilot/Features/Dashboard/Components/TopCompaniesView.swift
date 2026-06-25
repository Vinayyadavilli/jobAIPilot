import SwiftUI

public struct CompanyStat: Identifiable {
    public let id = UUID()
    public let name: String
    public let appsCount: Int
    public let iconColor: Color
    public let progressColor: Color
    public let progress: Double
}

public struct TopCompaniesView: View {
    let companies: [CompanyStat]
    
    public init(companies: [CompanyStat]) {
        self.companies = companies
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Top Companies")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(DashboardTheme.textPrimary)
            
            VStack(spacing: 24) {
                ForEach(companies) { company in
                    HStack(spacing: 16) {
                        // Icon circle
                        ZStack {
                            Circle()
                                .fill(company.iconColor.opacity(0.15))
                                .frame(width: 40, height: 40)
                            
                            Circle()
                                .fill(
                                    RadialGradient(
                                        colors: [company.iconColor, company.iconColor.opacity(0.8)],
                                        center: .center,
                                        startRadius: 0,
                                        endRadius: 15
                                    )
                                )
                                .frame(width: 24, height: 24)
                                .shadow(color: company.iconColor.opacity(0.6), radius: 5)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(company.name)
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(DashboardTheme.textPrimary)
                                Spacer()
                                Text("\(company.appsCount) app\(company.appsCount > 1 ? "s" : "")")
                                    .font(.system(size: 12))
                                    .foregroundColor(DashboardTheme.textSecondary)
                            }
                            
                            // Progress bar
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(DashboardTheme.textPrimary.opacity(0.1))
                                    .frame(height: 6)
                                
                                Capsule()
                                    .fill(
                                        LinearGradient(
                                            colors: [company.progressColor, company.progressColor.opacity(0.5)],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(width: max(0, CGFloat(company.progress) * 200), height: 6) // using a hardcoded max width estimate
                                    .shadow(color: company.progressColor.opacity(0.6), radius: 3)
                            }
                        }
                    }
                }
            }
        }
        .padding(20)
        .background(DashboardTheme.bgSecondary)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(DashboardTheme.textPrimary.opacity(0.05), lineWidth: 1)
        )
    }
}
