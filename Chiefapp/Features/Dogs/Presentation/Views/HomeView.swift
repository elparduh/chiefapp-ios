import SwiftUICore
import SwiftUI

struct HomeView: View {
  @ObservedObject var viewModel: DogsViewModel

  var body: some View {
    NavigationView {
      VStack {
        content
      }
      .background(Color.Palette.lightGrayF8)
      .navigationTitle("Chief & Co.")
      .navigationBarTitleDisplayMode(.inline)
      .task {
        await viewModel.loadDogs()
      }
    }
  }

  @ViewBuilder
  private var content: some View {
    switch viewModel.uiState {
    case .initial, .loading:
      ProgressView("Loading dogs...")
        .progressViewStyle(CircularProgressViewStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)

    case .failure(let message):
      VStack(spacing: .point16) {
        Text("Error:")
          .font(.headline)
        Text(message)
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

    case .success(let dogs):
      if dogs.isEmpty {
        VStack(spacing: .point16) {
          Image(systemName: "tray")
            .font(.system(size: .point40))
            .foregroundColor(Color.Palette.gray66)

          Text("No dogs available to display.")
            .font(.headline)
            .foregroundColor(Color.Palette.gray33)

          Button("Retry") {
            Task {
              await viewModel.loadDogs()
            }
          }
          .padding(.top)
          .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
      } else {
        ScrollView {
          LazyVStack(spacing: .point12) {
            ForEach(dogs, id: \.id) { dogUi in
              DogCardView(dogUi: dogUi)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            }
          }
          .padding(.top)
          .background(Color.Palette.lightGrayF8)
        }
      }
    }
  }
}
