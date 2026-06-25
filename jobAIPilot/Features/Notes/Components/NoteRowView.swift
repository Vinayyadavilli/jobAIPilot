import SwiftUI

public struct NoteRowView: View {
    let note: NoteResponse
    let companyName: String?
    let onEdit: () -> Void
    let onDelete: () -> Void
    
    public init(note: NoteResponse, companyName: String?, onEdit: @escaping () -> Void, onDelete: @escaping () -> Void) {
        self.note = note
        self.companyName = companyName
        self.onEdit = onEdit
        self.onDelete = onDelete
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                if let companyName = companyName, !companyName.isEmpty {
                    Text(companyName)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(DashboardTheme.neonCyan)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(DashboardTheme.neonCyan.opacity(0.1))
                        .cornerRadius(8)
                }
                
                Spacer()
                
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
                        .frame(width: 30, height: 30)
                }
            }
            
            Text(note.content)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(DashboardTheme.textPrimary)
                .lineSpacing(6)
                .multilineTextAlignment(.leading)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(DashboardTheme.bgSecondary)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(DashboardTheme.textPrimary.opacity(0.05), lineWidth: 1)
        )
    }
}
