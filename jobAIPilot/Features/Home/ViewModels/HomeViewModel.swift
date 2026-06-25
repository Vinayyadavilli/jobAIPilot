import Foundation
import NetworkKit
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var dataStatus: String = "Waiting for data..."
    
    private let client: NetworkClientProtocol
    
    init(client: NetworkClientProtocol) {
        self.client = client
    }
    
    func fetchData() async {
        // Example usage:
        // let request = MyCustomRequest(...)
        // do {
        //     let response = try await client.send(request)
        //     self.dataStatus = "Loaded successfully!"
        // } catch {
        //     self.dataStatus = "Error: \(error.localizedDescription)"
        // }
        
        self.dataStatus = "Architecture Ready! Define a NetworkRequest to test."
    }
}
