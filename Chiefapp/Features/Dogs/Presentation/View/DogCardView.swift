import SwiftUI

struct DogCardView: View {
  let dog: Dog

  var body: some View {
    HStack(alignment: .center, spacing: 16) {
      AsyncImage(url: URL(string: dog.imageUrl)) { image in
        image.resizable()
          .aspectRatio(contentMode: .fill)
      } placeholder: {
        Color.gray.opacity(0.3)
      }
      .frame(width: 100, height: 140)
      .clipShape(RoundedRectangle(cornerRadius: 12))
      .shadow(radius: 4)

      VStack(alignment: .leading, spacing: 8) {
        Text(dog.name)
          .font(.title3.bold())

        Text(dog.description)
          .font(.subheadline)
          .foregroundColor(.secondary)
          .lineLimit(3)

        Text("Almost \(dog.age) years")
          .font(.subheadline.weight(.semibold))
          .foregroundColor(.primary)
      }
    }
    .padding()
    .background(Color(.systemBackground))
    .clipShape(RoundedRectangle(cornerRadius: 16))
    .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
  }
}
