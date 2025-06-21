import Foundation

struct Dog: Identifiable {
  let id = UUID()
  let name: String
  let description: String
  let age: Int
  let imageUrl: String
}
