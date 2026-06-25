import Foundation
import NetworkKit

public protocol InterviewServiceProtocol {
    func createInterview(request: InterviewCreateRequest) async throws -> InterviewResponse
    func getInterviews(request: GetInterviewsRequest) async throws -> InterviewListResponse
    func getInterview(request: GetInterviewRequest) async throws -> InterviewResponse
    func updateInterview(request: InterviewUpdateRequest) async throws -> InterviewResponse
    func deleteInterview(request: DeleteInterviewRequest) async throws -> EmptyResponse
}

public final class InterviewService: InterviewServiceProtocol {
    private let client: NetworkClientProtocol
    
    public init(client: NetworkClientProtocol) {
        self.client = client
    }
    
    public func createInterview(request: InterviewCreateRequest) async throws -> InterviewResponse {
        return try await client.send(request)
    }
    
    public func getInterviews(request: GetInterviewsRequest) async throws -> InterviewListResponse {
        return try await client.send(request)
    }
    
    public func getInterview(request: GetInterviewRequest) async throws -> InterviewResponse {
        return try await client.send(request)
    }
    
    public func updateInterview(request: InterviewUpdateRequest) async throws -> InterviewResponse {
        return try await client.send(request)
    }
    
    public func deleteInterview(request: DeleteInterviewRequest) async throws -> EmptyResponse {
        return try await client.send(request)
    }
}
