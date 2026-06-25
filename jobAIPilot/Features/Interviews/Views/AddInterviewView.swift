import SwiftUI

public struct AddInterviewView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: InterviewsViewModel
    @ObservedObject var jobsViewModel: JobsViewModel
    
    @State private var jobId: String = ""
    @State private var interviewType: InterviewType = .technical
    @State private var roundString: String = ""
    @State private var scheduledAt: Date = Date()
    
    public var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Interview Details")) {
                    Picker("Select Job", selection: $jobId) {
                        if jobsViewModel.jobs.isEmpty {
                            Text("No Jobs Found").tag("")
                        } else {
                            ForEach(jobsViewModel.jobs) { job in
                                Text("\(job.company) - \(job.role)").tag(job.id)
                            }
                        }
                    }
                    
                    Picker("Type", selection: $interviewType) {
                        Text("Technical").tag(InterviewType.technical)
                        Text("HR").tag(InterviewType.hr)
                        Text("Video").tag(InterviewType.video)
                        Text("Phone").tag(InterviewType.phone)
                        Text("In Person").tag(InterviewType.inPerson)
                    }
                    
                    TextField("Round (Number)", text: $roundString)
                        .keyboardType(.numberPad)
                    
                    DatePicker("Date & Time", selection: $scheduledAt, displayedComponents: [.date, .hourAndMinute])
                }
                
                if let error = viewModel.errorMessage {
                    Section {
                        Text(error)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Add Interview")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let formatter = ISO8601DateFormatter()
                        let dateStr = formatter.string(from: scheduledAt)
                        
                        Task {
                            let success = await viewModel.createInterview(
                                jobId: jobId,
                                type: interviewType,
                                round: roundString.isEmpty ? nil : roundString,
                                scheduledAt: dateStr
                            )
                            if success {
                                dismiss()
                            }
                        }
                    }
                    .disabled(jobId.isEmpty || viewModel.isLoading)
                }
            }
            .onAppear {
                Task {
                    await jobsViewModel.fetchJobs()
                    if let firstJob = jobsViewModel.jobs.first, jobId.isEmpty {
                        jobId = firstJob.id
                    }
                }
            }
        }
    }
}
