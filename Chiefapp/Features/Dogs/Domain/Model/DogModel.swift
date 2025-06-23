import Foundation

struct Dog {
  let name: String
  let description: String
  let age: Int
  let imageUrl: String
}

extension Dog {

  func toDogUi() -> DogUi {
    DogUi(
      name: self.name,
      description: self.description,
      ageText: "\(self.age) years old",
      imageUrl: self.imageUrl
    )
  }
}

extension Array where Element == Dog {

  func toDogUiList() -> [DogUi] {
    self.map { $0.toDogUi() }
  }
}
