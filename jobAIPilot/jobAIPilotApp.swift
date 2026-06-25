//
//  jobAIPilotApp.swift
//  jobAIPilot
//
//  Created by vinay yadavilli on 09/06/26.
//

import SwiftUI
import NetworkKit

@main
struct jobAIPilotApp: App {
    
    init() {
        // Set up the global network configuration
        NetworkConfiguration.shared.configure(with: .init(
            baseURL: URL(string: "http://13.233.129.171/api/v1")!,
            environment: .development
        ))
    }
    @AppStorage("accessToken") var accessToken: String = ""
    @AppStorage("refreshToken") var refreshToken: String = ""

    var body: some Scene {
        WindowGroup {
            Group {
                if accessToken.isEmpty {
                    LoginView(viewModel: DIContainer.shared.makeLoginViewModel())
                        .onOpenURL { url in
                            handleDeepLink(url)
                        }
                } else {
                    MainTabView()
                        .onOpenURL { url in
                            handleDeepLink(url)
                        }
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("NetworkClientUnauthorized"))) { _ in
                // Auto-logout when token expires or gets rejected
                self.accessToken = ""
                self.refreshToken = ""
            }
        }
    }
    
    private func handleDeepLink(_ url: URL) {
        guard url.scheme == "jobpilot", url.host == "auth", url.path == "/verified" else { return }
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let queryItems = components?.queryItems {
            if let access = queryItems.first(where: { $0.name == "access_token" })?.value,
               let refresh = queryItems.first(where: { $0.name == "refresh_token" })?.value {
                self.accessToken = access
                self.refreshToken = refresh
            }
        }
    }
}
