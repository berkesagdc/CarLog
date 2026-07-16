import SwiftUI
import SwiftData

private let fuelDateFormatter: DateFormatter = {

    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "tr_TR")
    formatter.calendar = Calendar(identifier: .gregorian)
    formatter.dateFormat = "d MMMM yyyy"

    return formatter
}()

struct FuelListView: View {

    let car: Car

    var totalLiters: Double {
        car.fuelLogs.reduce(0) { total, fuel in
            total + (Double(fuel.liters) ?? 0)
        }
    }

    var totalPrice: Double {
        car.fuelLogs.reduce(0) { total, fuel in
            total + (Double(fuel.totalPrice) ?? 0)
        }
    }

    var totalLogs: Int {
        car.fuelLogs.count
    }

    @Environment(\.modelContext) private var modelContext
    @State private var showAddFuel = false

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

                        VStack(alignment: .leading, spacing: 16) {

                            Text("📊 Yakıt Özeti")
                                .font(.headline)

                            HStack {

                                VStack(alignment: .leading) {

                                    Text("Toplam Yakıt")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)

                                    Text(String(format: "%.1f L", totalLiters))
                                        .font(.title3)
                                        .fontWeight(.bold)
                                }

                                Spacer()

                                VStack(alignment: .trailing) {

                                    Text("Toplam Harcama")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)

                                    Text(String(format: "%.0f ₺", totalPrice))
                                        .font(.title3)
                                        .fontWeight(.bold)
                                }
                            }

                            Divider()

                            HStack {

                                Text("Yakıt Kaydı")

                                Spacer()

                                Text("\(totalLogs)")
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

                        for index in indexSet {

                            let fuel = car.fuelLogs.sorted(by: { $0.date > $1.date })[index]
                            modelContext.delete(fuel)
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
