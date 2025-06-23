import Foundation

struct DogApiResponse: Decodable {
  let dogName: String?
  let description: String?
  let age: Int?
  let image: String?
}

extension DogApiResponse {

  func toDog() -> Dog {
    Dog(name: dogName ?? .empty,
        description: description ?? .empty,
        age: age ?? .zero,
        imageUrl: image ?? .empty)
  }
}

extension Array where Element == DogApiResponse {

  func toDogList() -> [Dog] {
    self.map { $0.toDog() }
  }
}
