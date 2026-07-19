import SwiftUI

struct NextMaintenanceCard: View {

    let car: Car

    private var nextMaintenance: Maintenance? {

        car.maintenances.min {
            MaintenanceCalculator.remainingMileage(
                currentMileage: car.mileage,
                maintenance: $0
            ) ?? Int.max
            <
            MaintenanceCalculator.remainingMileage(
                currentMileage: car.mileage,
                maintenance: $1
            ) ?? Int.max
        }
    }

    var body: some View {

        GroupBox {

            VStack(alignment: .leading, spacing: 8) {

                Label("Sonraki Bakım", systemImage: "wrench.and.screwdriver.fill")
                    .font(.headline)
                    .foregroundStyle(.blue)

                if let maintenance = nextMaintenance {

                    Text(maintenance.title)
                        .font(.title3)
                        .fontWeight(.semibold)

                    if let nextMileage = MaintenanceCalculator.nextMaintenanceMileage(for: maintenance) {
                        Text("Sonraki bakım: \(Formatters.kilometer(String(nextMileage)))")
                            .foregroundStyle(.secondary)
                    }

                    if let remaining = MaintenanceCalculator.remainingMileage(
                        currentMileage: car.mileage,
                        maintenance: maintenance
                    ) {

                        Text(
                            remaining >= 0
                            ? "\(Formatters.kilometer(String(remaining))) kaldı"
                            : "\(Formatters.kilometer(String(-remaining))) gecikti"
                        )
                        .font(.title3.bold())
                        .foregroundStyle(remaining >= 0 ? .green : .red)
                    }

                } else {

                    Text("Henüz bakım bilgisi yok")
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
