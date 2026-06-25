//
//  AppTextField.swift
//  jobAIPilot
//
//  Reusable text fields with floating label, validation, icons,
//  secure toggle, and character counter.
//
//  Usage:
//    AppTextField("Email", text: $email, icon: "envelope")
//    AppTextField("Password", text: $password, isSecure: true)
//    AppTextField("Bio", text: $bio, axis: .vertical, characterLimit: 200)
//

import SwiftUI

// MARK: - AppTextField

struct AppTextField: View {
    
    let title: String
    @Binding var text: String
    let icon: String?
    let trailingIcon: String?
    let trailingAction: (() -> Void)?
    let isSecure: Bool
    let keyboardType: UIKeyboardType
    let autocapitalization: TextInputAutocapitalization
    let submitLabel: SubmitLabel
    let axis: Axis
    let characterLimit: Int?
    let validation: ValidationState
    let helperText: String?
    let isDisabled: Bool
    let onSubmit: (() -> Void)?
    let fieldHeight: CGFloat
    
    @State private var isSecureVisible = false
    @FocusState private var isFocused: Bool
    
    init(
        _ title: String,
        text: Binding<String>,
        icon: String? = nil,
        trailingIcon: String? = nil,
        trailingAction: (() -> Void)? = nil,
        isSecure: Bool = false,
        keyboardType: UIKeyboardType = .default,
        autocapitalization: TextInputAutocapitalization = .sentences,
        submitLabel: SubmitLabel = .done,
        axis: Axis = .horizontal,
        characterLimit: Int? = nil,
        validation: ValidationState = .none,
        helperText: String? = nil,
        isDisabled: Bool = false,
        fieldHeight: CGFloat = 56,
        onSubmit: (() -> Void)? = nil
    ) {
        self.title = title
        self._text = text
        self.icon = icon
        self.trailingIcon = trailingIcon
        self.trailingAction = trailingAction
        self.isSecure = isSecure
        self.keyboardType = keyboardType
        self.autocapitalization = autocapitalization
        self.submitLabel = submitLabel
        self.axis = axis
        self.characterLimit = characterLimit
        self.validation = validation
        self.helperText = helperText
        self.isDisabled = isDisabled
        self.onSubmit = onSubmit
        self.fieldHeight = fieldHeight
    }
    
    // MARK: Computed
    
    private var borderColor: Color {
        switch validation {
        case .error:    return AppTheme.Colors.error
        case .success:  return AppTheme.Colors.success
        case .warning:  return AppTheme.Colors.warning
        case .none:     return isFocused ? AppTheme.Colors.borderFocused : AppTheme.Colors.border
        }
    }
    
    private var helperColor: Color {
        switch validation {
        case .error(let msg):   return msg != nil ? AppTheme.Colors.error : AppTheme.Colors.textTertiary
        case .success:          return AppTheme.Colors.success
        case .warning:          return AppTheme.Colors.warning
        case .none:             return AppTheme.Colors.textTertiary
        }
    }
    
    private var validationMessage: String? {
        switch validation {
        case .error(let msg):   return msg
        case .success(let msg): return msg
        case .warning(let msg): return msg
        case .none:             return nil
        }
    }
    
    private var displayMessage: String? {
        validationMessage ?? helperText
    }
    
    // MARK: Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.xxs) {
            // Label
            if !text.isEmpty || isFocused {
                Text(title)
                    .font(AppTheme.Typography.caption1)
                    .foregroundColor(isFocused ? AppTheme.Colors.primary : AppTheme.Colors.textSecondary)
                    .transition(.asymmetric(
                        insertion: .move(edge: .bottom).combined(with: .opacity),
                        removal: .opacity
                    ))
            }
            
            // Input Row
            HStack(spacing: AppTheme.Spacing.xs) {
                // Leading icon
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(isFocused ? AppTheme.Colors.primary : AppTheme.Colors.textTertiary)
                        .frame(width: 20)
                        .animation(AppTheme.Animation.quick, value: isFocused)
                }
                
                // Text input
                Group {
                    if isSecure && !isSecureVisible {
                        SecureField(title, text: $text)
                            .submitLabel(submitLabel)
                    } else {
                        TextField(title, text: $text, axis: axis)
                            .keyboardType(keyboardType)
                            .textInputAutocapitalization(autocapitalization)
                            .submitLabel(submitLabel)
                    }
                }
                .font(AppTheme.Typography.body)
                .focused($isFocused)
                .disabled(isDisabled)
                .onSubmit { onSubmit?() }
                
                // Secure toggle
                if isSecure {
                    Button(action: { isSecureVisible.toggle() }) {
                        Image(systemName: isSecureVisible ? "eye.slash.fill" : "eye.fill")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(AppTheme.Colors.textTertiary)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                // Trailing icon / action
                if let trailingIcon {
                    Button(action: { trailingAction?() }) {
                        Image(systemName: trailingIcon)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(AppTheme.Colors.textTertiary)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .disabled(trailingAction == nil)
                }
                
                // Validation indicator
                validationIcon
            }
            .padding(.horizontal, AppTheme.Spacing.md)
            .padding(.vertical, AppTheme.Spacing.sm + 2)
            .frame(minHeight: fieldHeight)
            .background(
                isDisabled
                    ? AppTheme.Colors.surface.opacity(0.5)
                    : AppTheme.Colors.inputBackground
            )
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.Radius.medium, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.Radius.medium, style: .continuous)
                    .strokeBorder(borderColor, lineWidth: isFocused ? 1.5 : 1)
            )
            .animation(AppTheme.Animation.quick, value: isFocused)
            .animation(AppTheme.Animation.quick, value: validation)
            
            // Helper / Validation message + Character counter
            HStack {
                if let displayMessage {
                    Text(displayMessage)
                        .font(AppTheme.Typography.caption1)
                        .foregroundColor(helperColor)
                        .transition(.opacity)
                }
                
                Spacer()
                
                if let characterLimit {
                    Text("\(text.count)/\(characterLimit)")
                        .font(AppTheme.Typography.caption2)
                        .foregroundColor(
                            text.count > characterLimit
                                ? AppTheme.Colors.error
                                : AppTheme.Colors.textTertiary
                        )
                }
            }
            .animation(AppTheme.Animation.quick, value: displayMessage)
        }
    }
    
    // MARK: Validation Icon
    
    @ViewBuilder
    private var validationIcon: some View {
        switch validation {
        case .success:
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(AppTheme.Colors.success)
                .font(.system(size: 16))
                .transition(.scale.combined(with: .opacity))
        case .error:
            Image(systemName: "exclamationmark.circle.fill")
                .foregroundColor(AppTheme.Colors.error)
                .font(.system(size: 16))
                .transition(.scale.combined(with: .opacity))
        case .warning:
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(AppTheme.Colors.warning)
                .font(.system(size: 16))
                .transition(.scale.combined(with: .opacity))
        case .none:
            EmptyView()
        }
    }
}

// MARK: - Validation State

enum ValidationState: Equatable {
    case none
    case success(String? = nil)
    case error(String? = nil)
    case warning(String? = nil)
}

// MARK: - Preview

#Preview("Text Fields") {
    ScrollView {
        VStack(spacing: 20) {
            AppTextField(
                "Email Address",
                text: .constant("vinay@example.com"),
                icon: "envelope",
                keyboardType: .emailAddress,
                autocapitalization: .never,
                validation: .success("Looks good!")
            )
            
            AppTextField(
                "Password",
                text: .constant("secret"),
                icon: "lock",
                isSecure: true
            )
            
            AppTextField(
                "Username",
                text: .constant("v"),
                icon: "person",
                validation: .error("Too short — minimum 3 characters")
            )
            
            AppTextField(
                "Company",
                text: .constant(""),
                icon: "building.2",
                helperText: "Optional"
            )
            
            AppTextField(
                "Bio",
                text: .constant("I love building iOS apps!"),
                axis: .vertical,
                characterLimit: 200
            )
            
            AppTextField(
                "Disabled field",
                text: .constant("Can't edit me"),
                isDisabled: true
            )
        }
        .padding()
    }
}
