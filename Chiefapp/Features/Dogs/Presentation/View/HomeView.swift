import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: DogsViewModel

    var body: some View {
        NavigationView {
            VStack {
                content
            }
            .navigationTitle("Chief & Co.")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.loadDogs()
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView("Loading dogs...")
                .progressViewStyle(CircularProgressViewStyle())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let errorMessage = viewModel.errorMessage {
            VStack(spacing: 16) {
                Text("Error:")
                    .font(.headline)
                Text(errorMessage)
                    .multilineTextAlignment(.center)
                Button("Retry") {
                    Task {
                        await viewModel.loadDogs()
                    }
                }
                .padding(.top)
                .buttonStyle(.bordered)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            ScrollView {
                LazyVStack(spacing: 12) {
                  ForEach(viewModel.dogUiList, id: \.id) { dogUi in
                    DogCardView(dogUi: dogUi)
                            .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
        }
    }
}
