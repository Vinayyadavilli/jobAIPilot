import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Welcome to jobAIPilot")
                .font(.headline)
            
            Text(viewModel.dataStatus)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Button("Fetch Data") {
                Task {
                    await viewModel.fetchData()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    // For preview, we can inject a mock client or a real one if needed.
    // In a real app, you might want a MockNetworkClient conforming to NetworkClientProtocol
    // HomeView(viewModel: HomeViewModel(client: MockNetworkClient()))
    HomeView(viewModel: DIContainer.shared.makeHomeViewModel())
}
