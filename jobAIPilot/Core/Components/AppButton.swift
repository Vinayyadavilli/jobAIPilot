//
//  AppButton.swift
//  jobAIPilot
//
//  Reusable button with multiple style variants, loading state,
//  leading/trailing icons, and haptic feedback.
//
//  Usage:
//    AppButton("Sign In", style: .primary) { await login() }
//    AppButton("Delete", style: .destructive, icon: "trash") { delete() }
//    AppButton("Cancel", style: .ghost) { dismiss() }
//    AppButton("Loading...", style: .primary, isLoading: true) { }
//

import SwiftUI

enum ButtonIcon {
    case system(String)
    case asset(String)
}

// MARK: - AppButton

struct AppButton: View {
    
    let title: String
    let style: Style
    let size: Size
    let icon: ButtonIcon?
    let iconPosition: IconPosition
    let isLoading: Bool
    let isDisabled: Bool
    let isFullWidth: Bool
    let action: () -> Void
    
    init(
        _ title: String,
        style: Style = .primary,
        size: Size = .regular,
        icon: ButtonIcon? = nil,
        iconPosition: IconPosition = .leading,
        isLoading: Bool = false,
        isDisabled: Bool = false,
        isFullWidth: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.size = size
        self.icon = icon
        self.iconPosition = iconPosition
        self.isLoading = isLoading
        self.isDisabled = isDisabled
        self.isFullWidth = isFullWidth
        self.action = action
    }
    
    @State private var isPressed = false
    
    private var effectivelyDisabled: Bool {
        isDisabled || isLoading
    }
    
    var body: some View {
        Button(action: {
            guard !effectivelyDisabled else { return }
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            action()
        }) {
            HStack(spacing: AppTheme.Spacing.xs) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: style.foreground))
                        .scaleEffect(0.9)
                } else {
//                    if let icon, iconPosition == .leading {
//                        Image(systemName: icon)
//                            .font(size.iconFont)
//                    }
                    
                    if let icon, iconPosition == .leading {
                        switch icon {
                        case .system(let name):
                            Image(systemName: name)
                                .font(size.iconFont)

                        case .asset(let name):
                            Image(name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                        }
                    }
                    
                    Text(title)
                        .font(size.textFont)
                    
//                    if let icon, iconPosition == .trailing {
//                        Image(systemName: icon)
//                            .font(size.iconFont)
//                    }
                    if let icon, iconPosition == .trailing {
                        switch icon {
                        case .system(let name):
                            Image(systemName: name)
                                .font(size.iconFont)

                        case .asset(let name):
                            Image(name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                        }
                    }
                }
            }
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .padding(.horizontal, size.horizontalPadding)
            .padding(.vertical, size.verticalPadding)
            .foregroundColor(effectivelyDisabled ? style.foreground.opacity(0.5) : style.foreground)
            .background(
                style.backgroundView
                    .opacity(effectivelyDisabled ? 0.4 : 1.0)
            )
            .clipShape(RoundedRectangle(cornerRadius: size.cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: size.cornerRadius, style: .continuous)
                    .strokeBorder(style.borderColor, lineWidth: style.borderWidth)
            )
            .appShadow(style.shadow)
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .animation(AppTheme.Animation.quick, value: isPressed)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(effectivelyDisabled)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
}

// MARK: - AppIconButton (Circle Icon Button)

struct AppIconButton: View {
    let icon: String
    let style: AppButton.Style
    let size: CGFloat
    let action: () -> Void
    
    init(
        icon: String,
        style: AppButton.Style = .secondary,
        size: CGFloat = 44,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.style = style
        self.size = size
        self.action = action
    }
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            action()
        }) {
            Image(systemName: icon)
                .font(.system(size: size * 0.4, weight: .medium))
                .foregroundColor(style.foreground)
                .frame(width: size, height: size)
                .background(style.backgroundView)
                .clipShape(Circle())
                .overlay(Circle().strokeBorder(style.borderColor, lineWidth: style.borderWidth))
                .appShadow(AppTheme.Shadow.small)
                .scaleEffect(isPressed ? 0.92 : 1.0)
                .animation(AppTheme.Animation.quick, value: isPressed)
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
}

// MARK: - Style

extension AppButton {
    enum Style {
        case primary
        case secondary
        case outline
        case ghost
        case destructive
        case success
        case gradient
        
        @ViewBuilder
        var backgroundView: some View {
            switch self {
            case .primary:      AppTheme.Colors.primary
            case .secondary:    AppTheme.Colors.surface
            case .outline:      Color.clear
            case .ghost:        Color.clear
            case .destructive:  AppTheme.Colors.error
            case .success:      AppTheme.Colors.success
            case .gradient:
                LinearGradient(
                    colors: [AppTheme.Colors.primary, AppTheme.Colors.accent],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            }
        }
        
        var foreground: Color {
            switch self {
            case .primary:      return AppTheme.Colors.textOnPrimary
            case .secondary:    return AppTheme.Colors.textPrimary
            case .outline:      return AppTheme.Colors.primary
            case .ghost:        return AppTheme.Colors.primary
            case .destructive:  return AppTheme.Colors.textOnPrimary
            case .success:      return AppTheme.Colors.textOnPrimary
            case .gradient:     return AppTheme.Colors.textOnPrimary
            }
        }
        
        var borderColor: Color {
            switch self {
            case .outline:      return AppTheme.Colors.primary.opacity(0.5)
            case .secondary:    return AppTheme.Colors.border
            default:            return .clear
            }
        }
        
        var borderWidth: CGFloat {
            switch self {
            case .outline, .secondary: return 1
            default: return 0
            }
        }
        
        var shadow: ShadowStyle {
            switch self {
            case .primary, .destructive, .success, .gradient:
                return AppTheme.Shadow.small
            default:
                return ShadowStyle(color: .clear, radius: 0, x: 0, y: 0)
            }
        }
    }
}

// MARK: - Size

extension AppButton {
    enum Size {
        case small
        case regular
        case large
        
        var textFont: Font {
            switch self {
            case .small:    return AppTheme.Typography.buttonSmall
            case .regular:  return AppTheme.Typography.button
            case .large:    return AppTheme.Typography.button
            }
        }
        
        var iconFont: Font {
            switch self {
            case .small:    return .system(size: 13, weight: .semibold)
            case .regular:  return .system(size: 15, weight: .semibold)
            case .large:    return .system(size: 17, weight: .semibold)
            }
        }
        
        var horizontalPadding: CGFloat {
            switch self {
            case .small:    return AppTheme.Spacing.sm
            case .regular:  return AppTheme.Spacing.md
            case .large:    return AppTheme.Spacing.xl
            }
        }
        
        var verticalPadding: CGFloat {
            switch self {
            case .small:    return AppTheme.Spacing.xs
            case .regular:  return AppTheme.Spacing.sm + 2
            case .large:    return AppTheme.Spacing.md
            }
        }
        
        var cornerRadius: CGFloat {
            switch self {
            case .small:    return AppTheme.Radius.small
            case .regular:  return AppTheme.Radius.medium
            case .large:    return AppTheme.Radius.large
            }
        }
    }
    
    enum IconPosition {
        case leading
        case trailing
    }
}

// MARK: - Async AppButton Convenience

struct AppAsyncButton: View {
    let title: String
    let style: AppButton.Style
    let size: AppButton.Size
    let icon: ButtonIcon?
    let iconPosition: AppButton.IconPosition
    let isDisabled: Bool
    let isFullWidth: Bool
    let asyncAction: () async -> Void
    
    @State private var isLoading = false
    
    init(
        _ title: String,
        style: AppButton.Style = .primary,
        size: AppButton.Size = .regular,
        icon: ButtonIcon? = nil,
        iconPosition: AppButton.IconPosition = .leading,
        isDisabled: Bool = false,
        isFullWidth: Bool = true,
        action: @escaping () async -> Void
    ) {
        self.title = title
        self.style = style
        self.size = size
        self.icon = icon
        self.iconPosition = iconPosition
        self.isDisabled = isDisabled
        self.isFullWidth = isFullWidth
        self.asyncAction = action
    }
    
    var body: some View {
        AppButton(
            title,
            style: style,
            size: size,
            icon: icon,
            iconPosition: iconPosition,
            isLoading: isLoading,
            isDisabled: isDisabled,
            isFullWidth: isFullWidth
        ) {
            Task {
                isLoading = true
                await asyncAction()
                isLoading = false
            }
        }
    }
}

// MARK: - Preview

#Preview("Button Styles") {
    ScrollView {
        VStack(spacing: 16) {
            AppButton("Primary Button", style: .primary) { }
            AppButton("Secondary", style: .secondary) { }
            AppButton("Outline", style: .outline, icon: .system("trash"), iconPosition: .trailing) { }
            AppButton("Ghost", style: .ghost) { }
            AppButton("Gradient", style: .gradient) { }
            AppButton("Delete Account", style: .destructive, icon: .system("trash")) { }
            AppButton("Confirmed", style: .success, icon: .system("checkmark")) { }
            AppButton("Loading…", style: .primary, isLoading: true) { }
            AppButton("Disabled", style: .primary, isDisabled: true) { }
            
            Divider()
            
            HStack(spacing: 12) {
                AppButton("Small", style: .primary, size: .small, isFullWidth: false) { }
                AppButton("Regular", style: .primary, size: .regular, isFullWidth: false) { }
                AppButton("Large", style: .primary, size: .large, isFullWidth: false) { }
            }
            
            Divider()
            
            HStack(spacing: 12) {
                AppIconButton(icon: "heart.fill", style: .primary) { }
                AppIconButton(icon: "square.and.arrow.up", style: .secondary) { }
                AppIconButton(icon: "ellipsis", style: .ghost) { }
            }
        }
        .padding()
    }
}
