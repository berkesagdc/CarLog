import SwiftUI

struct CarCardView: View {

    let car: Car

    var body: some View {

        VStack(alignment: .leading, spacing: 14) {

            HStack {

                Image(systemName: "car.side.fill")
                    .font(.title2)
                    .foregroundStyle(.blue)

                Text("\(car.brand) \(car.model)")
                    .font(.headline)

                Spacer()
            }

            VStack(alignment: .leading, spacing: 4) {

                Text("Plaka")
                    .font(.caption2)
                    .foregroundStyle(.secondary)

                Text(car.plate)
                    .font(.title3)
                    .bold()
            }

            HStack {

                Label(car.year, systemImage: "calendar")

                Spacer()

                Label("\(car.mileage) km", systemImage: "speedometer")
            }
            .font(.caption)
            .foregroundStyle(.secondary)

            Divider()

            HStack {

                Label("\(car.maintenances.count) bakım kaydı",
                      systemImage: "wrench.and.screwdriver.fill")
                    .foregroundStyle(.orange)

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundStyle(.tertiary)
            }
            .font(.caption)

        }
        .padding()
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.08), radius: 10, y: 5)
    }
}

#Preview {
    CarCardView(
        car: Car(
            brand: "BMW",
            model: "430",
            year: "2022",
            plate: "34 BRK 034",
            mileage: "22000"
        )
    )
}
