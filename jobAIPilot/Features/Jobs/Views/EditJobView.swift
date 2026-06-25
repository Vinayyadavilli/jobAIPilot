import SwiftUI

public struct EditJobView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: JobsViewModel
    
    let job: JobResponse
    @State private var company: String
    @State private var role: String
    @State private var status: JobStatus
    
    public init(viewModel: JobsViewModel, job: JobResponse) {
        self.viewModel = viewModel
        self.job = job
        _company = State(initialValue: job.company)
        _role = State(initialValue: job.role)
        _status = State(initialValue: job.status)
    }
    
    public var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Job Details")) {
                    TextField("Company Name", text: $company)
                    TextField("Role", text: $role)
                    
                    Picker("Status", selection: $status) {
                        Text("Applied").tag(JobStatus.applied)
                        Text("Interviewing").tag(JobStatus.interviewing)
                        Text("Offered").tag(JobStatus.offered)
                        Text("Rejected").tag(JobStatus.rejected)
                        Text("Withdrawn").tag(JobStatus.withdrawn)
                    }
                }
                
                if let error = viewModel.errorMessage {
                    Section {
                        Text(error)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Edit Job")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task {
                            let success = await viewModel.updateJob(id: job.id, company: company, role: role, status: status)
                            if success {
                                dismiss()
                            }
                        }
                    }
                    .disabled(company.isEmpty || role.isEmpty || viewModel.isLoading)
                }
            }
        }
    }
}
