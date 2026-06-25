import Foundation
import NetworkKit

@MainActor
final class DIContainer {
    static let shared = DIContainer()
    
    let networkClient: NetworkClientProtocol
    
    private init() {
        // Build the network client, adding any interceptors if needed
        self.networkClient = NetworkClientBuilder()
            .setSession(.shared)
            .add(requestInterceptor: AuthInterceptor(tokenProvider: AppTokenProvider()))
            .build()
    }
    
    // MARK: - Services
    
    private lazy var authService: AuthServiceProtocol = {
        return AuthService(client: networkClient)
    }()
    
    private lazy var dashboardService: DashboardServiceProtocol = {
        return DashboardService(client: networkClient)
    }()
    
    private lazy var jobService: JobServiceProtocol = {
        return JobService(client: networkClient)
    }()
    
    private lazy var interviewService: InterviewServiceProtocol = {
        return InterviewService(client: networkClient)
    }()
    
    private lazy var noteService: NoteServiceProtocol = {
        return NoteService(client: networkClient)
    }()
    
    private lazy var resumeService: ResumeServiceProtocol = {
        return ResumeService(client: networkClient)
    }()
    
    // MARK: - ViewModels
    
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(client: networkClient)
    }
    
    func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel(authService: authService)
    }
    
    func makeRegisterViewModel() -> RegisterViewModel {
        return RegisterViewModel(authService: authService)
    }
    
    func makeDashboardViewModel() -> DashboardViewModel {
        return DashboardViewModel(dashboardService: dashboardService)
    }
    
    func makeJobsViewModel() -> JobsViewModel {
        return JobsViewModel(jobService: jobService)
    }
    
    func makeInterviewsViewModel() -> InterviewsViewModel {
        return InterviewsViewModel(interviewService: interviewService)
    }
    
    func makeNotesViewModel() -> NotesViewModel {
        return NotesViewModel(noteService: noteService)
    }
    
    func makeResumesViewModel() -> ResumesViewModel {
        return ResumesViewModel(resumeService: resumeService)
    }
}
