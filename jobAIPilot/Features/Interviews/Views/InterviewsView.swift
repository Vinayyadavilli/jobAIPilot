import SwiftUI

public struct InterviewsView: View {
    @StateObject public var viewModel: InterviewsViewModel
    @StateObject private var jobsViewModel = DIContainer.shared.makeJobsViewModel()
    @State private var showingAddInterview = false
    @State private var interviewToEdit: InterviewResponse?
    
    
    public init(viewModel: InterviewsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading Interviews...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else if viewModel.interviews.isEmpty {
                    Text("No interviews scheduled.")
                        .foregroundColor(.gray)
                } else {
                    List(viewModel.interviews) { interview in
                        VStack(alignment: .leading) {
                            Text(interview.interviewType.rawValue.capitalized + " Interview")
                                .font(.headline)
                            if let round = interview.round {
                                Text("Round: \(round)")
                                    .font(.subheadline)
                            }
                            Text("Status: \(interview.status.rawValue.capitalized)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                Task {
                                    await viewModel.deleteInterview(id: interview.id)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button {
                                interviewToEdit = interview
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.blue)
                        }
                    }
                }
            }
            .navigationTitle("Interviews")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddInterview = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddInterview) {
                AddInterviewView(viewModel: viewModel, jobsViewModel: jobsViewModel)
            }
            .sheet(item: $interviewToEdit) { interview in
                EditInterviewView(viewModel: viewModel, interview: interview)
            }
            .onAppear {
                Task {
                    await viewModel.fetchInterviews()
                }
            }
        }
    }
}
