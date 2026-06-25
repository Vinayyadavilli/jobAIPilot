//
//  AppText.swift
//  jobAIPilot
//
//  Reusable text view with semantic style variants.
//  Usage:
//    AppText("Welcome Back", style: .largeTitle)
//    AppText("Subtitle here", style: .body, color: .secondary)
//

import SwiftUI

// MARK: - AppText

struct AppText: View {
    
    let text: String
    let style: Style
    let color: Color
    let alignment: TextAlignment
    let lineLimit: Int?
    
    init(
        _ text: String,
        style: Style = .body,
        color: Color = AppTheme.Colors.textPrimary,
        alignment: TextAlignment = .leading,
        lineLimit: Int? = nil
    ) {
        self.text = text
        self.style = style
        self.color = color
        self.alignment = alignment
        self.lineLimit = lineLimit
    }
    
    var body: some View {
        Text(text)
            .font(style.font)
            .foregroundColor(color)
            .multilineTextAlignment(alignment)
            .lineLimit(lineLimit)
    }
}

// MARK: - Style Variants

extension AppText {
    enum Style {
        case largeTitle
        case title1
        case title2
        case title3
        case headline
        case body
        case callout
        case subheadline
        case footnote
        case caption1
        case caption2
        case button
        case buttonSmall
        
        var font: Font {
            switch self {
            case .largeTitle:   return AppTheme.Typography.largeTitle
            case .title1:       return AppTheme.Typography.title1
            case .title2:       return AppTheme.Typography.title2
            case .title3:       return AppTheme.Typography.title3
            case .headline:     return AppTheme.Typography.headline
            case .body:         return AppTheme.Typography.body
            case .callout:      return AppTheme.Typography.callout
            case .subheadline:  return AppTheme.Typography.subheadline
            case .footnote:     return AppTheme.Typography.footnote
            case .caption1:     return AppTheme.Typography.caption1
            case .caption2:     return AppTheme.Typography.caption2
            case .button:       return AppTheme.Typography.button
            case .buttonSmall:  return AppTheme.Typography.buttonSmall
            }
        }
    }
}

// MARK: - Attributed / Rich Text Variant

struct AppRichText: View {
    let attributedString: AttributedString
    let style: AppText.Style
    let color: Color
    
    init(
        _ attributedString: AttributedString,
        style: AppText.Style = .body,
        color: Color = AppTheme.Colors.textPrimary
    ) {
        self.attributedString = attributedString
        self.style = style
        self.color = color
    }
    
    var body: some View {
        Text(attributedString)
            .font(style.font)
            .foregroundColor(color)
    }
}

// MARK: - Gradient Text Variant

struct AppGradientText: View {
    let text: String
    let style: AppText.Style
    let gradient: LinearGradient
    
    init(
        _ text: String,
        style: AppText.Style = .title1,
        colors: [Color] = [AppTheme.Colors.primary, AppTheme.Colors.accent]
    ) {
        self.text = text
        self.style = style
        self.gradient = LinearGradient(
            colors: colors,
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    var body: some View {
        Text(text)
            .font(style.font)
            .foregroundStyle(gradient)
    }
}

// MARK: - Preview

#Preview("Text Styles") {
    ScrollView {
        VStack(alignment: .leading, spacing: 12) {
            AppText("Large Title", style: .largeTitle)
            AppText("Title 1", style: .title1)
            AppText("Title 2", style: .title2)
            AppText("Title 3", style: .title3)
            AppText("Headline", style: .headline)
            AppText("Body text goes here", style: .body)
            AppText("Callout text", style: .callout)
            AppText("Subheadline", style: .subheadline)
            AppText("Footnote", style: .footnote, color: AppTheme.Colors.textSecondary)
            AppText("Caption 1", style: .caption1, color: AppTheme.Colors.textTertiary)
            AppText("Caption 2", style: .caption2, color: AppTheme.Colors.textTertiary)
            
            Divider()
            
            AppGradientText("Gradient Title", style: .title1)
        }
        .padding()
    }
}
