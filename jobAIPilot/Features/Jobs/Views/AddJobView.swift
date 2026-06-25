import SwiftUI

public struct AddJobView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: JobsViewModel
    
    @State private var company: String = ""
    @State private var role: String = ""
    @State private var status: JobStatus = .applied
    
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
            .navigationTitle("Add Job")
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
                            let success = await viewModel.createJob(company: company, role: role, status: status)
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
