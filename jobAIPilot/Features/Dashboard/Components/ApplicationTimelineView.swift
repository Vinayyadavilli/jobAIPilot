import SwiftUI
import Charts

public struct ChartDataPoint: Identifiable {
    public let id = UUID()
    public let label: String
    public let value: Double
}

public struct ApplicationTimelineView: View {
    let data: [ChartDataPoint]
    
    public init(data: [ChartDataPoint]) {
        self.data = data
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Application Timeline")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(DashboardTheme.textPrimary)
            
            Chart(data) { point in
                LineMark(
                    x: .value("Date", point.label),
                    y: .value("Count", point.value)
                )
                .foregroundStyle(DashboardTheme.neonCyan)
                .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                // iOS 16+ shadow equivalent for charts is a bit tricky, 
                // but we can achieve the glow with a secondary thicker line or just rely on AreaMark.
                
                AreaMark(
                    x: .value("Date", point.label),
                    y: .value("Count", point.value)
                )
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            DashboardTheme.neonCyan.opacity(0.4),
                            DashboardTheme.neonCyan.opacity(0.0)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .chartYAxis {
                AxisMarks(position: .leading, values: .automatic(desiredCount: 5)) { value in
                    AxisValueLabel()
                        .foregroundStyle(DashboardTheme.textSecondary)
                }
            }
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 7)) { value in
                    AxisValueLabel()
                        .foregroundStyle(DashboardTheme.textSecondary)
                }
            }
            .frame(height: 180)
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
