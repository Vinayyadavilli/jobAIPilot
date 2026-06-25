import Foundation
import SwiftUI
import Combine

@MainActor
public final class JobsViewModel: ObservableObject {
    private let jobService: JobServiceProtocol
    
    @Published public var jobs: [JobResponse] = []
    @Published public var errorMessage: String?
    @Published public var isLoading: Bool = false
    
    public init(jobService: JobServiceProtocol) {
        self.jobService = jobService
    }
    
    public func fetchJobs() async {
        isLoading = true
        errorMessage = nil
        do {
            let response = try await jobService.getJobs(request: GetJobsRequest())
            jobs = response.jobs
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    public func createJob(company: String, role: String, status: JobStatus) async -> Bool {
        isLoading = true
        errorMessage = nil
        do {
            let request = JobCreateRequest(company: company, role: role, status: status)
            _ = try await jobService.createJob(request: request)
            await fetchJobs()
            return true
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            return false
        }
    }
    
    public func updateJob(id: String, company: String, role: String, status: JobStatus) async -> Bool {
        isLoading = true
        errorMessage = nil
        do {
            let request = JobUpdateRequest(jobId: id, company: company, role: role, status: status)
            _ = try await jobService.updateJob(request: request)
            await fetchJobs()
            return true
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            return false
        }
    }
    
    public func deleteJob(id: String) async -> Bool {
        isLoading = true
        errorMessage = nil
        do {
            let request = DeleteJobRequest(jobId: id)
            _ = try await jobService.deleteJob(request: request)
            await fetchJobs()
            return true
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            return false
        }
    }
}
