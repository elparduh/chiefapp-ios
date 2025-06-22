import Foundation

struct DogApiResponse: Decodable {
  let dogName: String?
  let description: String?
  let age: Int?
  let image: String?
}

extension DogApiResponse {

  func toDog() -> Dog {
    Dog(name: dogName ?? "",
        description: description ?? "",
        age: age ?? 0,
        imageUrl: image ?? "")
  }
}

extension Array where Element == DogApiResponse {

  func toDogList() -> [Dog] {
    self.map { $0.toDog() }
  }
}
