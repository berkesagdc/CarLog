import SwiftUI
import SwiftData

struct FuelListView: View {

    let car: Car

    @Environment(\.modelContext) private var modelContext
    @State private var showAddFuel = false

    private var currentMonthFuelLogs: [FuelLog] {

        let calendar = Calendar.current

        return car.fuelLogs.filter {
            calendar.isDate($0.date, equalTo: Date(), toGranularity: .month)
        }
    }

    private var currentMonthTitle: String {

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "MMMM yyyy"

        return formatter.string(from: Date()).capitalized
    }

    private var totalLiters: Double {

        currentMonthFuelLogs.reduce(0) {
            $0 + (Double($1.liters) ?? 0)
        }
    }

    private var totalPrice: Double {

        currentMonthFuelLogs.reduce(0) {
            $0 + (Double($1.totalPrice) ?? 0)
        }
    }

    private var totalLogs: Int {

        currentMonthFuelLogs.count
    }

    var body: some View {

        Group {

            if car.fuelLogs.isEmpty {

                ContentUnavailableView(
                    "Henüz yakıt kaydı yok",
                    systemImage: "fuelpump",
                    description: Text("İlk yakıt kaydını ekleyebilirsin.")
                )

            } else {

                List {

                    Section {

                        VStack(alignment: .leading, spacing: 22) {

                            Text("📊 \(currentMonthTitle) Yakıt Özeti")
                                .font(.headline)

                            VStack(alignment: .leading, spacing: 4) {

                                Text("Toplam Harcama")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)

                                Text(String(format: "%.0f ₺", totalPrice))
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }

                            VStack(alignment: .leading, spacing: 4) {

                                Text("Toplam Yakıt")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)

                                Text(String(format: "%.1f L", totalLiters))
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }

                            VStack(alignment: .leading, spacing: 4) {

                                Text("Yakıt Kaydı")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)

                                Text("\(totalLogs)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                        }
                        .padding(.vertical, 8)
                    }

                    ForEach(car.fuelLogs.sorted(by: { $0.date > $1.date })) { fuel in

                        VStack(alignment: .leading, spacing: 8) {

                            Label("\(fuel.liters) L", systemImage: "fuelpump.fill")
                                .font(.headline)
                                .foregroundStyle(.green)

                            Label("\(fuel.totalPrice) ₺", systemImage: "turkishlirasign.circle.fill")
                                .foregroundStyle(.orange)

                            if let price = fuel.pricePerLiter {

                                Text(String(format: "%.2f ₺ / L", price))
                                    .font(.body)
                                    .foregroundStyle(.blue)
                            }

                            Text("\(fuel.mileage) km")
                                .foregroundStyle(.secondary)

                            Text(fuel.date.formatted(date: .long, time: .omitted))
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete { indexSet in

                        let sortedFuelLogs = car.fuelLogs.sorted(by: { $0.date > $1.date })

                        for index in indexSet {
                            modelContext.delete(sortedFuelLogs[index])
                        }

                        try? modelContext.save()
                    }
                }
            }
        }
        .navigationTitle("Yakıt Geçmişi")
        .toolbar {

            ToolbarItem(placement: .topBarTrailing) {

                Button {

                    showAddFuel = true

                } label: {

                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddFuel) {

            AddFuelView(car: car)
        }
    }
}

#Preview {

    FuelListView(
        car: Car(
            brand: "BMW",
            model: "430",
            year: "2022",
            plate: "34 BRK 034",
            mileage: "22000"
        )
    )
}
