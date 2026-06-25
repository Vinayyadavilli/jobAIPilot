import Foundation
import SwiftUI
import Combine

@MainActor
public final class ResumesViewModel: ObservableObject {
    private let resumeService: ResumeServiceProtocol
    
    @Published public var resumes: [ResumeResponse] = []
    @Published public var errorMessage: String?
    @Published public var isLoading: Bool = false
    
    public init(resumeService: ResumeServiceProtocol) {
        self.resumeService = resumeService
    }
    
    public func fetchResumes() async {
        isLoading = true
        errorMessage = nil
        do {
            let response = try await resumeService.getResumes(request: GetResumesRequest())
            resumes = response.resumes
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    public func enhanceResume(url: String) async -> Bool {
        isLoading = true
        errorMessage = nil
        do {
            let request = EnhanceUrlRequest(url: url)
            _ = try await resumeService.enhanceUrl(request: request)
            await fetchResumes()
            return true
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            return false
        }
    }
    
    public func deleteResume(id: String) async -> Bool {
        isLoading = true
        errorMessage = nil
        do {
            let request = DeleteResumeRequest(resumeId: id)
            _ = try await resumeService.deleteResume(request: request)
            await fetchResumes()
            return true
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            return false
        }
    }
}
