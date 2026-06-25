import SwiftUI

public struct DashboardView: View {
    @StateObject public var viewModel: DashboardViewModel
    
    public init(viewModel: DashboardViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack {
            DashboardTheme.bgPrimary.ignoresSafeArea()
            
            if viewModel.isLoading {
                ProgressView("Loading Dashboard...")
                    .foregroundColor(DashboardTheme.textPrimary)
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else if let summary = viewModel.summary {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        // MARK: - Header
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(DashboardTheme.bgTertiary)
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Circle().stroke(DashboardTheme.neonCyan.opacity(0.5), lineWidth: 2)
                                    )
                                Image(systemName: "person.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(DashboardTheme.neonCyan)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Welcome back")
                                    .font(.system(size: 14))
                                    .foregroundColor(DashboardTheme.textSecondary)
                                Text("Hello, Vinay 👋")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(DashboardTheme.textPrimary)
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 12) {
                                Button(action: {}) {
                                    ZStack {
                                        Circle()
                                            .fill(DashboardTheme.bgSecondary)
                                            .frame(width: 40, height: 40)
                                        Image(systemName: "bell")
                                            .foregroundColor(DashboardTheme.textPrimary)
                                    }
                                }
                            }
                        }
                        .padding(.top, 10)
                        
                        // MARK: - Stats Grid
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
                            ProgressStatCard(
                                title: "Success Rate",
                                valueText: String(format: "%.0f%%", summary.successRate),
                                progress: summary.successRate / 100.0,
                                color: DashboardTheme.neonGreen,
                                iconName: "checkmark.circle",
                                subtitle: "Offers received"
                            )
                            
                            ProgressStatCard(
                                title: "Interview Rate",
                                valueText: String(format: "%.0f%%", summary.interviewRate),
                                progress: summary.interviewRate / 100.0,
                                color: DashboardTheme.neonCyan,
                                iconName: "chart.line.uptrend.xyaxis",
                                 subtitle: "Shortlisted"
                            )
                            
                            CountStatCard(
                                title: "Total Applied",
                                count: summary.totalApplications,
                                color: DashboardTheme.neonPurple,
                                badgeText: "+\(summary.activeThisWeek) this week",
                                badgeIcon: nil
                            )
                            
                            CountStatCard(
                                title: "Active",
                                count: summary.statusBreakdown["in_progress"] ?? summary.statusBreakdown["applied"] ?? 0,
                                color: DashboardTheme.neonYellow,
                                badgeText: "In progress",
                                badgeIcon: "clock"
                            )
                        }
                        
                        // MARK: - Application Timeline
                        // MOCK DATA for now since the view model doesn't fetch timeline yet
                        ApplicationTimelineView(data: [
                            ChartDataPoint(label: "M31", value: 0),
                            ChartDataPoint(label: "J1", value: 1),
                            ChartDataPoint(label: "J2", value: 1),
                            ChartDataPoint(label: "J3", value: 2),
                            ChartDataPoint(label: "J4", value: 2),
                            ChartDataPoint(label: "J5", value: 3),
                            ChartDataPoint(label: "J6", value: 3),
                            ChartDataPoint(label: "J7", value: 4),
                            ChartDataPoint(label: "J8", value: 4),
                            ChartDataPoint(label: "J9", value: 4)
                        ])
                        
                        // MARK: - Top Companies
                        TopCompaniesView(companies: summary.topCompanies.map { comp in
                            CompanyStat(
                                name: comp.company,
                                appsCount: comp.count,
                                iconColor: DashboardTheme.neonCyan,
                                progressColor: DashboardTheme.neonPurple,
                                progress: min(1.0, Double(comp.count) / 5.0) // Mocking progress based on count
                            )
                        })
                        
                        // Extra padding for the custom tab bar
                        Spacer().frame(height: 100)
                    }
                    .padding(.horizontal, 20)
                }
            } else {
                Text("No data available.")
                    .foregroundColor(DashboardTheme.textPrimary)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchSummary()
            }
        }
    }
}
