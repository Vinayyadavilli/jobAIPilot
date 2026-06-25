import SwiftUI

public struct NotesView: View {
    @StateObject public var viewModel: NotesViewModel
    @StateObject private var jobsViewModel = DIContainer.shared.makeJobsViewModel()
    @State private var showingAddNote = false
    @State private var noteToEdit: NoteResponse?
    
    public init(viewModel: NotesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack {
            DashboardTheme.bgPrimary.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: - Header
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Quick Capture")
                            .font(.system(size: 14))
                            .foregroundColor(DashboardTheme.textSecondary)
                        Text("My Notes")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(DashboardTheme.textPrimary)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 12) {
                        Button(action: {
                            showingAddNote = true
                        }) {
                            ZStack {
                                Circle()
                                    .fill(DashboardTheme.neonCyan.opacity(0.1))
                                    .frame(width: 32, height: 32)
                                Image(systemName: "plus")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(DashboardTheme.neonCyan)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 20)
                
                // MARK: - List
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Loading Notes...")
                        .foregroundColor(DashboardTheme.textPrimary)
                    Spacer()
                } else if let error = viewModel.errorMessage {
                    Spacer()
                    Text("Error: \(error)")
                        .foregroundColor(Color(hex: "F43F5E"))
                    Spacer()
                } else if viewModel.notes.isEmpty {
                    Spacer()
                    Text("No notes found.")
                        .foregroundColor(DashboardTheme.textSecondary)
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.notes) { note in
                                let companyName = jobsViewModel.jobs.first(where: { $0.id == note.jobId })?.company
                                
                                NoteRowView(
                                    note: note,
                                    companyName: companyName,
                                    onEdit: {
                                        noteToEdit = note
                                    },
                                    onDelete: {
                                        Task {
                                            await viewModel.deleteNote(id: note.id)
                                        }
                                    }
                                )
                            }
                            
                            // Extra padding for the custom tab bar
                            Spacer().frame(height: 100)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddNote) {
            AddNoteView(viewModel: viewModel, jobsViewModel: jobsViewModel)
        }
        .sheet(item: $noteToEdit) { note in
            EditNoteView(viewModel: viewModel, note: note)
        }
        .onAppear {
            Task {
                await jobsViewModel.fetchJobs()
                await viewModel.fetchNotes()
            }
        }
    }
}
