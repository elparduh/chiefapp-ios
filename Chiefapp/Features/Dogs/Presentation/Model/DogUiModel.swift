import Foundation

struct DogUi: Identifiable, Equatable {
  let id = UUID()
  let name: String
  let description: String
  let ageText: String
  let imageUrl: String
}
