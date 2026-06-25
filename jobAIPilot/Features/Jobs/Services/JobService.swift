import Foundation
import NetworkKit

public protocol JobServiceProtocol {
    func createJob(request: JobCreateRequest) async throws -> JobResponse
    func getJobs(request: GetJobsRequest) async throws -> JobListResponse
    func getJob(request: GetJobRequest) async throws -> JobResponse
    func updateJob(request: JobUpdateRequest) async throws -> JobResponse
    func deleteJob(request: DeleteJobRequest) async throws -> EmptyResponse
}

public final class JobService: JobServiceProtocol {
    private let client: NetworkClientProtocol
    
    public init(client: NetworkClientProtocol) {
        self.client = client
    }
    
    public func createJob(request: JobCreateRequest) async throws -> JobResponse {
        return try await client.send(request)
    }
    
    public func getJobs(request: GetJobsRequest) async throws -> JobListResponse {
        return try await client.send(request)
    }
    
    public func getJob(request: GetJobRequest) async throws -> JobResponse {
        return try await client.send(request)
    }
    
    public func updateJob(request: JobUpdateRequest) async throws -> JobResponse {
        return try await client.send(request)
    }
    
    public func deleteJob(request: DeleteJobRequest) async throws -> EmptyResponse {
        return try await client.send(request)
    }
}
