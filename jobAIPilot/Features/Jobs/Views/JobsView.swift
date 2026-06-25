import SwiftUI

public struct JobsView: View {
    @StateObject public var viewModel: JobsViewModel
    @State private var showingAddJob = false
    @State private var jobToEdit: JobResponse?

    public init(viewModel: JobsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack {
            DashboardTheme.bgPrimary.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: - Header
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Tracking")
                            .font(.system(size: 14))
                            .foregroundColor(DashboardTheme.textSecondary)
                        Text("My Applications")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 12) {
                        Button(action: {
                            showingAddJob = true
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
                    ProgressView("Loading Jobs...")
                        .foregroundColor(DashboardTheme.textPrimary)
                    Spacer()
                } else if let error = viewModel.errorMessage {
                    Spacer()
                    Text("Error: \(error)")
                        .foregroundColor(Color(hex: "F43F5E"))
                    Spacer()
                } else if viewModel.jobs.isEmpty {
                    Spacer()
                    Text("No jobs found.")
                        .foregroundColor(DashboardTheme.textSecondary)
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.jobs) { job in
                                JobRowView(
                                    job: job,
                                    onEdit: {
                                        jobToEdit = job
                                    },
                                    onDelete: {
                                        Task {
                                            await viewModel.deleteJob(id: job.id)
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
        .sheet(isPresented: $showingAddJob) {
            AddJobView(viewModel: viewModel)
        }
        .sheet(item: $jobToEdit) { job in
            EditJobView(viewModel: viewModel, job: job)
        }
        .onAppear {
            Task {
                await viewModel.fetchJobs()
            }
        }
    }
}
