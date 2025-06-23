import SwiftUI

struct DogCardView: View {
  let dogUi: DogUi

  var body: some View {
    HStack(alignment: .center, spacing: 16) {
      AsyncImage(url: URL(string: dogUi.imageUrl)) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fill)
      } placeholder: {
        Color.gray.opacity(0.3)
      }
      .frame(width: 100, height: 140)
      .clipShape(RoundedRectangle(cornerRadius: 12))
      .shadow(radius: 4)

      VStack(alignment: .leading, spacing: 8) {
        Text(dogUi.name)
          .font(.title3.bold())

        Text(dogUi.description)
          .font(.subheadline)
          .foregroundColor(.secondary)
          .lineLimit(3)

        Text(dogUi.ageText)
          .font(.subheadline.weight(.semibold))
          .foregroundColor(.primary)
      }
      .frame(maxWidth: .infinity, alignment: .leading) // 🔧 garantiza que use todo el espacio
    }
    .padding()
    .frame(maxWidth: .infinity, minHeight: 160, alignment: .leading) // 🔧 asegura ancho y altura uniforme
    .background(Color(.white))
    .clipShape(RoundedRectangle(cornerRadius: 16))
    .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
  }
}
