import SwiftUI

public struct JobRowView: View {
    let job: JobResponse
    let onEdit: () -> Void
    let onDelete: () -> Void
    
    public init(job: JobResponse, onEdit: @escaping () -> Void, onDelete: @escaping () -> Void) {
        self.job = job
        self.onEdit = onEdit
        self.onDelete = onDelete
    }
    
    // Determine status color
    private var statusColor: Color {
        switch job.status {
        case .applied:
            return DashboardTheme.neonCyan
        case .interviewing:
            return DashboardTheme.neonGreen
        case .offered:
            return DashboardTheme.neonYellow
        case .rejected:
            return Color(hex: "F43F5E") // Red
        case .withdrawn:
            return DashboardTheme.textSecondary
        case .all:
            return DashboardTheme.textPrimary
        }
    }
    
    private var statusText: String {
        switch job.status {
        case .interviewing:
            return "Interview" // Match mockup exact text
        default:
            return job.status.rawValue.capitalized
        }
    }
    
    // Icon based on the job category/role
    private var categoryIcon: String {
        let roleLower = job.role.lowercased()
        
        if roleLower.contains("ios") || roleLower.contains("apple") || roleLower.contains("swift") {
            return "applelogo"
        } else if roleLower.contains("android") || roleLower.contains("mobile") {
            return "smartphone"
        } else if roleLower.contains("web") || roleLower.contains("html") || roleLower.contains("frontend") || roleLower.contains("front-end") || roleLower.contains("react") || roleLower.contains("angular") || roleLower.contains("vue") {
            return "chevron.left.forwardslash.chevron.right"
        } else if roleLower.contains("backend") || roleLower.contains("back-end") || roleLower.contains("server") || roleLower.contains("api") || roleLower.contains("node") || roleLower.contains("python") || roleLower.contains("java") || roleLower.contains("golang") {
            return "server.rack"
        } else if roleLower.contains("data") || roleLower.contains("machine learning") || roleLower.contains("ai") || roleLower.contains("artificial intelligence") {
            return "chart.bar.fill"
        } else if roleLower.contains("design") || roleLower.contains("ui") || roleLower.contains("ux") {
            return "paintpalette.fill"
        } else if roleLower.contains("manager") || roleLower.contains("lead") || roleLower.contains("director") || roleLower.contains("product") {
            return "person.3.fill"
        } else {
            return "briefcase.fill"
        }
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            // Company Icon Placeholder
            ZStack {
                Circle()
                    .fill(DashboardTheme.bgTertiary)
                    .frame(width: 48, height: 48)
                
                Image(systemName: categoryIcon)
                    .font(.system(size: 20))
                    .foregroundColor(DashboardTheme.textPrimary.opacity(0.8))
            }
            
            // Job Details
            VStack(alignment: .leading, spacing: 4) {
                Text(job.role)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(DashboardTheme.textPrimary)
                
                Text(job.company)
                    .font(.system(size: 14))
                    .foregroundColor(DashboardTheme.textSecondary)
            }
            
            Spacer()
            
            // Status Badge
            Text(statusText)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(statusColor)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(statusColor.opacity(0.1))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(statusColor.opacity(0.4), lineWidth: 1)
                )
            
            // Ellipsis Menu
            Menu {
                Button(action: onEdit) {
                    Label("Edit", systemImage: "pencil")
                }
                
                Button(role: .destructive, action: onDelete) {
                    Label("Delete", systemImage: "trash")
                }
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(DashboardTheme.textSecondary)
                    .padding(.leading, 8)
                    .frame(height: 30) // Larger tap target
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(DashboardTheme.bgSecondary)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(DashboardTheme.textPrimary.opacity(0.05), lineWidth: 1)
        )
    }
}
