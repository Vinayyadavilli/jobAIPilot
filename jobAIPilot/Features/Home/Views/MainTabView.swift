import SwiftUI

public struct MainTabView: View {
    @State private var selectedTab: TabSelection = .dashboard
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            // Main Content Area
            TabView(selection: $selectedTab) {
                DashboardView(viewModel: DIContainer.shared.makeDashboardViewModel())
                    .tag(TabSelection.dashboard)
                
                JobsView(viewModel: DIContainer.shared.makeJobsViewModel())
                    .tag(TabSelection.jobs)
                
                ResumesView(viewModel: DIContainer.shared.makeResumesViewModel())
                    .tag(TabSelection.resumes)
                
                NotesView(viewModel: DIContainer.shared.makeNotesViewModel())
                    .tag(TabSelection.notes)
                
                ProfileView()
                    .tag(TabSelection.profile)
            }
            .tabViewStyle(.page(indexDisplayMode: .never)) // Allows swiping and hides default bar
            
            // Custom Floating Tab Bar
            CustomTabBar(selectedTab: $selectedTab)
        }
        .background(DashboardTheme.bgPrimary)
        .onAppear {
            // Optional: configure standard UIKit tab bar appearance if it ever shows up
            UITabBar.appearance().isHidden = true
        }
    }
}

#Preview {
    MainTabView()
}
