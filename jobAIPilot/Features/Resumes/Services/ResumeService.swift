import Foundation
import NetworkKit

public protocol ResumeServiceProtocol {
    func enhanceUrl(request: EnhanceUrlRequest) async throws -> ResumeResponse
    func getResumes(request: GetResumesRequest) async throws -> ResumeListResponse
    func getResume(request: GetResumeRequest) async throws -> ResumeResponse
    func deleteResume(request: DeleteResumeRequest) async throws -> EmptyResponse
}

public final class ResumeService: ResumeServiceProtocol {
    private let client: NetworkClientProtocol
    
    public init(client: NetworkClientProtocol) {
        self.client = client
    }
    
    public func enhanceUrl(request: EnhanceUrlRequest) async throws -> ResumeResponse {
        return try await client.send(request)
    }
    
    public func getResumes(request: GetResumesRequest) async throws -> ResumeListResponse {
        return try await client.send(request)
    }
    
    public func getResume(request: GetResumeRequest) async throws -> ResumeResponse {
        return try await client.send(request)
    }
    
    public func deleteResume(request: DeleteResumeRequest) async throws -> EmptyResponse {
        return try await client.send(request)
    }
}
