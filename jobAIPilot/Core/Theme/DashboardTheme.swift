import SwiftUI
import UIKit

public extension Color {
    init(light: Color, dark: Color) {
        self.init(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor(dark)
            default:
                return UIColor(light)
            }
        })
    }
}

public enum DashboardTheme {
    // MARK: - Background Colors
    public static let bgPrimary = Color(light: Color(hex: "F8FAFC"), dark: Color(hex: "0D0F16"))
    public static let bgSecondary = Color(light: Color(hex: "FFFFFF"), dark: Color(hex: "171A24"))
    public static let bgTertiary = Color(light: Color(hex: "F1F5F9"), dark: Color(hex: "222533"))
    
    // MARK: - Accent/Neon Colors
    public static let neonGreen = Color(hex: "20D489")
    public static let neonCyan = Color(hex: "00F0FF")
    public static let neonPurple = Color(hex: "8B5CF6")
    public static let neonYellow = Color(hex: "F59E0B")
    
    // MARK: - Text Colors
    public static let textPrimary = Color(light: Color.black, dark: Color.white)
    public static let textSecondary = Color(light: Color(hex: "64748B"), dark: Color(hex: "94A3B8"))
    
    // MARK: - Gradients
    public static let greenGradient = LinearGradient(colors: [neonGreen, neonGreen.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
    public static let cyanGradient = LinearGradient(colors: [neonCyan, neonCyan.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
    public static let purpleGradient = LinearGradient(colors: [neonPurple, neonPurple.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
    public static let yellowGradient = LinearGradient(colors: [neonYellow, neonYellow.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
}
