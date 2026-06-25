import SwiftUI

public struct ResumesView: View {
    @StateObject public var viewModel: ResumesViewModel
    @State private var showingAddResume = false
    @State private var driveUrl: String = ""

    public init(viewModel: ResumesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack {
            DashboardTheme.bgPrimary.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: - Header
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Powered by GPT-4o")
                            .font(.system(size: 12))
                            .foregroundColor(DashboardTheme.textSecondary)
                        Text("AI Resume Enhancer")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(DashboardTheme.textPrimary)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: -8) {
                        
                        Text("PRO")
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(.white) // PRO badge stays white
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(
                                LinearGradient(colors: [Color(hex: "5A58FF"), Color(hex: "00F0FF")], startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(10)
                            .offset(y: 4)
                            .shadow(color: Color(hex: "5A58FF").opacity(0.5), radius: 4, x: 0, y: 2)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 24)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        // MARK: - Drag and Drop Area
                        Button(action: {
                            showingAddResume = true
                        }) {
                            VStack(spacing: 12) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(LinearGradient(colors: [Color(hex: "292341"), Color(hex: "172B3C")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .frame(width: 64, height: 64)
                                    
                                    Image(systemName: "square.and.arrow.up")
                                        .font(.system(size: 24, weight: .medium))
                                        .foregroundColor(DashboardTheme.neonCyan)
                                }
                                .padding(.bottom, 4)
                                
                                Text("Upload Resume")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(DashboardTheme.textPrimary)
                                
                                Text("PDF or DOCX • Tap or drag & drop")
                                    .font(.system(size: 12))
                                    .foregroundColor(DashboardTheme.textSecondary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                            .background(DashboardTheme.bgPrimary) // Dark inside
                            .cornerRadius(24)
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [6, 4]))
                                    .foregroundColor(DashboardTheme.textSecondary.opacity(0.5))
                            )
                        }
                        
                        // MARK: - OR Divider
                        HStack(spacing: 16) {
                            Rectangle()
                                .fill(DashboardTheme.textSecondary.opacity(0.3))
                                .frame(height: 1)
                            
                            Text("OR")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(DashboardTheme.textSecondary)
                            
                            Rectangle()
                                .fill(DashboardTheme.textSecondary.opacity(0.3))
                                .frame(height: 1)
                        }
                        .padding(.horizontal, 20)
                        
                        // MARK: - URL Input
                        HStack(spacing: 12) {
                            Image(systemName: "link")
                                .foregroundColor(DashboardTheme.textSecondary)
                            
                            TextField("", text: $driveUrl, prompt: Text("Paste Google Drive / Dropbox URL...").foregroundColor(DashboardTheme.textSecondary))
                                .foregroundColor(DashboardTheme.textPrimary)
                                .font(.system(size: 14))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)
                        .background(DashboardTheme.bgSecondary)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(DashboardTheme.textPrimary.opacity(0.05), lineWidth: 1)
                        )
                        
                        // MARK: - Enhance Button
                        Button(action: {}) {
                            HStack(spacing: 8) {
                                Image(systemName: "sparkles")
                                Text("Enhance Resume")
                                    .fontWeight(.bold)
                                Image(systemName: "sparkles")
                            }
                            .foregroundColor(.white) // Button text stays white on gradient
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    colors: [Color(hex: "7C3AED"), DashboardTheme.neonCyan],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(16)
                            .shadow(color: DashboardTheme.neonCyan.opacity(0.3), radius: 10, x: 0, y: 0)
                        }
                        .padding(.top, 8)
                        
                        // MARK: - Feature Highlights
                        VStack(alignment: .leading, spacing: 16) {
                            FeatureRow(text: "Rewrites bullets using the STAR method")
                            FeatureRow(text: "Optimizes keywords for ATS systems")
                            FeatureRow(text: "Restructures layout for recruiter readability")
                        }
                        .padding(.top, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Extra padding for the custom tab bar
                        Spacer().frame(height: 100)
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
        .sheet(isPresented: $showingAddResume) {
            AddResumeView(viewModel: viewModel)
        }
    }
}

fileprivate struct FeatureRow: View {
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 16))
                .foregroundColor(DashboardTheme.neonGreen) // Using neonGreen for the checkmarks
            
            Text(text)
                .font(.system(size: 13))
                .foregroundColor(DashboardTheme.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
