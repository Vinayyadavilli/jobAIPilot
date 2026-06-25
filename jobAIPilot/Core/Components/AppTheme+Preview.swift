//
//  AppTheme+Preview.swift
//  jobAIPilot
//
//  Xcode Canvas previews for all design tokens.
//

import SwiftUI

// MARK: - Preview Helpers

private struct ColorSwatch: View {
    let name: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(color)
                .frame(width: 44, height: 44)
                .overlay(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .strokeBorder(Color(UIColor.separator), lineWidth: 0.5)
                )
            
            Text(name)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color(UIColor.label))
            
            Spacer()
        }
    }
}

private struct SpacingBar: View {
    let name: String
    let value: CGFloat
    
    var body: some View {
        HStack(spacing: 8) {
            Text("\(name) (\(Int(value)))")
                .font(.system(size: 12, weight: .medium, design: .monospaced))
                .frame(width: 100, alignment: .leading)
            
            RoundedRectangle(cornerRadius: 4)
                .fill(AppTheme.Colors.primary.opacity(0.7))
                .frame(width: value * 3, height: 16)
        }
    }
}

private struct RadiusPreview: View {
    let name: String
    let radius: CGFloat
    
    var body: some View {
        VStack(spacing: 4) {
            RoundedRectangle(cornerRadius: radius, style: .continuous)
                .fill(AppTheme.Colors.primaryLight)
                .overlay(
                    RoundedRectangle(cornerRadius: radius, style: .continuous)
                        .strokeBorder(AppTheme.Colors.primary, lineWidth: 1.5)
                )
                .frame(width: 56, height: 56)
            
            Text(name)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
    }
}

private struct ShadowPreviewBox: View {
    let name: String
    let shadow: ShadowStyle
    
    var body: some View {
        VStack(spacing: 6) {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(UIColor.systemBackground))
                .frame(width: 80, height: 60)
                .appShadow(shadow)
            
            Text(name)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
    }
}

// MARK: - Preview

#Preview("AppTheme – Design Tokens") {
    ScrollView {
        VStack(alignment: .leading, spacing: 28) {
            
            // ── Colors ──────────────────────────────
            
            Text("Colors")
                .font(AppTheme.Typography.title2)
            
            Group {
                Text("Brand")
                    .font(AppTheme.Typography.caption1)
                    .foregroundColor(AppTheme.Colors.textTertiary)
                    .textCase(.uppercase)
                
                ColorSwatch(name: "Primary", color: AppTheme.Colors.primary)
                ColorSwatch(name: "Primary Dark", color: AppTheme.Colors.primaryDark)
                ColorSwatch(name: "Primary Light", color: AppTheme.Colors.primaryLight)
                ColorSwatch(name: "Accent", color: AppTheme.Colors.accent)
            }
            
            Group {
                Text("Semantic")
                    .font(AppTheme.Typography.caption1)
                    .foregroundColor(AppTheme.Colors.textTertiary)
                    .textCase(.uppercase)
                
                ColorSwatch(name: "Error", color: AppTheme.Colors.error)
                ColorSwatch(name: "Error Light", color: AppTheme.Colors.errorLight)
                ColorSwatch(name: "Success", color: AppTheme.Colors.success)
                ColorSwatch(name: "Success Light", color: AppTheme.Colors.successLight)
                ColorSwatch(name: "Warning", color: AppTheme.Colors.warning)
                ColorSwatch(name: "Warning Light", color: AppTheme.Colors.warningLight)
            }
            
            Group {
                Text("Surfaces")
                    .font(AppTheme.Typography.caption1)
                    .foregroundColor(AppTheme.Colors.textTertiary)
                    .textCase(.uppercase)
                
                ColorSwatch(name: "Background", color: AppTheme.Colors.background)
                ColorSwatch(name: "Surface", color: AppTheme.Colors.surface)
                ColorSwatch(name: "Input Background", color: AppTheme.Colors.inputBackground)
                ColorSwatch(name: "Border", color: AppTheme.Colors.border)
            }
            
            Group {
                Text("Text")
                    .font(AppTheme.Typography.caption1)
                    .foregroundColor(AppTheme.Colors.textTertiary)
                    .textCase(.uppercase)
                
                ColorSwatch(name: "Text Primary", color: AppTheme.Colors.textPrimary)
                ColorSwatch(name: "Text Secondary", color: AppTheme.Colors.textSecondary)
                ColorSwatch(name: "Text Tertiary", color: AppTheme.Colors.textTertiary)
                ColorSwatch(name: "Placeholder", color: AppTheme.Colors.placeholder)
            }
            
            Divider()
            
            // ── Typography ──────────────────────────
            
            Text("Typography")
                .font(AppTheme.Typography.title2)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Large Title – 34pt").font(AppTheme.Typography.largeTitle)
                Text("Title 1 – 28pt").font(AppTheme.Typography.title1)
                Text("Title 2 – 22pt").font(AppTheme.Typography.title2)
                Text("Title 3 – 20pt").font(AppTheme.Typography.title3)
                Text("Headline – 17pt").font(AppTheme.Typography.headline)
                Text("Body – 17pt").font(AppTheme.Typography.body)
                Text("Callout – 16pt").font(AppTheme.Typography.callout)
                Text("Subheadline – 15pt").font(AppTheme.Typography.subheadline)
                Text("Footnote – 13pt").font(AppTheme.Typography.footnote)
                Text("Caption 1 – 12pt").font(AppTheme.Typography.caption1)
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("Caption 2 – 11pt").font(AppTheme.Typography.caption2)
                Text("Button – 17pt").font(AppTheme.Typography.button)
                Text("Button Small – 15pt").font(AppTheme.Typography.buttonSmall)
            }
            
            Divider()
            
            // ── Spacing ─────────────────────────────
            
            Text("Spacing")
                .font(AppTheme.Typography.title2)
            
            VStack(alignment: .leading, spacing: 6) {
                SpacingBar(name: "xxxs", value: AppTheme.Spacing.xxxs)
                SpacingBar(name: "xxs", value: AppTheme.Spacing.xxs)
                SpacingBar(name: "xs", value: AppTheme.Spacing.xs)
                SpacingBar(name: "sm", value: AppTheme.Spacing.sm)
                SpacingBar(name: "md", value: AppTheme.Spacing.md)
                SpacingBar(name: "lg", value: AppTheme.Spacing.lg)
                SpacingBar(name: "xl", value: AppTheme.Spacing.xl)
                SpacingBar(name: "xxl", value: AppTheme.Spacing.xxl)
                SpacingBar(name: "xxxl", value: AppTheme.Spacing.xxxl)
            }
            
            Divider()
            
            // ── Radii ───────────────────────────────
            
            Text("Corner Radii")
                .font(AppTheme.Typography.title2)
            
            HStack(spacing: 16) {
                RadiusPreview(name: "Small (8)", radius: AppTheme.Radius.small)
                RadiusPreview(name: "Medium (12)", radius: AppTheme.Radius.medium)
                RadiusPreview(name: "Large (16)", radius: AppTheme.Radius.large)
                RadiusPreview(name: "XL (24)", radius: AppTheme.Radius.extraLarge)
            }
            
            Divider()
            
            // ── Shadows ─────────────────────────────
            
            Text("Shadows")
                .font(AppTheme.Typography.title2)
            
            HStack(spacing: 24) {
                ShadowPreviewBox(name: "Small", shadow: AppTheme.Shadow.small)
                ShadowPreviewBox(name: "Medium", shadow: AppTheme.Shadow.medium)
                ShadowPreviewBox(name: "Large", shadow: AppTheme.Shadow.large)
            }
            .padding(.vertical, 12)
        }
        .padding()
    }
}
