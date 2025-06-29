import SwiftUI

struct DogCardView: View {
  let dogUi: DogUi

  var body: some View {
    HStack(alignment: .center, spacing: .point16) {
      AsyncImage(url: URL(string: dogUi.imageUrl)) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fill)
      } placeholder: {
        Color.Palette.gray66.opacity(.point0_3)
      }
      .frame(width: .point100, height: .point140)
      .clipShape(RoundedRectangle(cornerRadius: .point12))
      .shadow(radius: .point4)

      VStack(alignment: .leading, spacing: .point8) {
        Text(dogUi.name)
          .font(.title3.bold())
          .foregroundColor(Color.Palette.gray33)
        Text(dogUi.description)
          .font(.subheadline)
          .foregroundColor(Color.Palette.gray66)
          .lineLimit(.three)

        Text(dogUi.ageText)
          .font(.subheadline.weight(.semibold))
          .foregroundColor(Color.Palette.gray33)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding()
    .frame(maxWidth: .infinity, minHeight: .point160, alignment: .leading)
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: .point16))
    .shadow(color: .black.opacity(.point0_05), radius: .point4, x: .point0, y: .point2)
  }
}
