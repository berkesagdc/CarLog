import SwiftUI

struct AverageConsumptionCard: View {

    let car: Car

    private var averageConsumption: Double? {
        FuelCalculator.averageConsumption(for: car.fuelLogs)
    }

    var body: some View {

        GroupBox {

            VStack(alignment: .leading, spacing: 8) {

                Label("Ortalama Tüketim", systemImage: "fuelpump.fill")
                    .font(.headline)
                    .foregroundStyle(.orange)

                if let averageConsumption {

                    Text(Formatters.consumption(averageConsumption))
                        .font(.title3.bold())

                    Text("Yakıt kayıtlarına göre hesaplandı")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                } else {

                    Text("Yeterli yakıt kaydı yok")
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    Text("Preview")
}
