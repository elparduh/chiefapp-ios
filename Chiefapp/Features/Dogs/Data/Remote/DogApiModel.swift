import Foundation

struct DogApiResponse: Decodable {
  let dogName: String?
  let description: String?
  let age: Int?
  let image: String?
}
