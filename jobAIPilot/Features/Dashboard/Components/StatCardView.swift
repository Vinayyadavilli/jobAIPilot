import SwiftUI

// MARK: - Progress Circular Ring
public struct CircularProgressRing: View {
    let progress: Double
    let color: Color
    
    public var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.15), lineWidth: 6)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    color,
                    style: StrokeStyle(lineWidth: 6, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .shadow(color: color.opacity(0.8), radius: 6, x: 0, y: 0)
            
            Text("\(Int(progress * 100))%")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(DashboardTheme.textPrimary)
        }
        .frame(width: 50, height: 50)
    }
}

// MARK: - Progress Stat Card (Top Row)
public struct ProgressStatCard: View {
    let title: String
    let valueText: String
    let progress: Double
    let color: Color
    let iconName: String
    let subtitle: String
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(DashboardTheme.textSecondary)
                    Text(valueText)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(color)
                        .shadow(color: color.opacity(0.5), radius: 4, x: 0, y: 0)
                }
                Spacer()
                CircularProgressRing(progress: progress, color: color)
            }
            
            HStack(spacing: 6) {
                Image(systemName: iconName)
                    .font(.system(size: 10))
                Text(subtitle)
                    .font(.system(size: 12))
            }
            .foregroundColor(color)
        }
        .padding(16)
        .background(DashboardTheme.bgSecondary)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color.opacity(0.3), lineWidth: 1)
        )
    }
}

// MARK: - Count Stat Card (Bottom Row)
public struct CountStatCard: View {
    let title: String
    let count: Int
    let color: Color
    let badgeText: String
    let badgeIcon: String?
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    if title == "Active" {
                        Circle()
                            .fill(color)
                            .frame(width: 8, height: 8)
                            .shadow(color: color, radius: 4)
                    }
                    Text(title)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(DashboardTheme.textSecondary)
                }
                
                Text("\(count)")
                    .font(.system(size: 32, weight: .heavy))
                    .foregroundColor(DashboardTheme.textPrimary)
            }
            
            HStack(spacing: 4) {
                if let badgeIcon = badgeIcon {
                    Image(systemName: badgeIcon)
                        .font(.system(size: 10))
                }
                Text(badgeText)
                    .font(.system(size: 10, weight: .semibold))
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(color.opacity(0.15))
            .foregroundColor(color)
            .cornerRadius(12)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(DashboardTheme.bgSecondary)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
    }
}
