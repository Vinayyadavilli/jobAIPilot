import Foundation
import SwiftUI
import Combine

@MainActor
public final class InterviewsViewModel: ObservableObject {
    private let interviewService: InterviewServiceProtocol
    
    @Published public var interviews: [InterviewResponse] = []
    @Published public var errorMessage: String?
    @Published public var isLoading: Bool = false
    
    public init(interviewService: InterviewServiceProtocol) {
        self.interviewService = interviewService
    }
    
    public func fetchInterviews() async {
        isLoading = true
        errorMessage = nil
        do {
            let response = try await interviewService.getInterviews(request: GetInterviewsRequest())
            interviews = response.interviews
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    public func createInterview(jobId: String, type: InterviewType, round: String?, scheduledAt: String) async -> Bool {
        isLoading = true
        errorMessage = nil
        do {
            let request = InterviewCreateRequest(jobId: jobId, round: round, interviewType: type, scheduledAt: scheduledAt)
            _ = try await interviewService.createInterview(request: request)
            await fetchInterviews()
            return true
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            return false
        }
    }
    
    public func updateInterview(id: String, round: String?, type: InterviewType, scheduledAt: String) async -> Bool {
        isLoading = true
        errorMessage = nil
        do {
            let request = InterviewUpdateRequest(interviewId: id, round: round, interviewType: type, scheduledAt: scheduledAt)
            _ = try await interviewService.updateInterview(request: request)
            await fetchInterviews()
            return true
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            return false
        }
    }
    
    public func deleteInterview(id: String) async -> Bool {
        isLoading = true
        errorMessage = nil
        do {
            let request = DeleteInterviewRequest(interviewId: id)
            _ = try await interviewService.deleteInterview(request: request)
            await fetchInterviews()
            return true
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            return false
        }
    }
}
