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

                    ForEach(car.fuelLogs.sorted(by: { $0.date > $1.date })) { fuel in
                        
                        VStack(alignment: .leading, spacing: 8) {

                            Text("\(fuel.liters) L")
                                .font(.headline)

                            Text("\(fuel.totalPrice) ₺")
                                .foregroundStyle(.secondary)
                            
                            if let price = fuel.pricePerLiter {

                                Text(String(format: "%.2f ₺ / L", price))
                                    .font(.caption)
                                    .foregroundStyle(.blue)
                            }

                            Text("\(fuel.mileage) km")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete { indexSet in

                        for index in indexSet {

                            modelContext.delete(car.fuelLogs[index])
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
