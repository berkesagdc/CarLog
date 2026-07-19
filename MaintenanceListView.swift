import SwiftUI
import SwiftData

private let maintenanceDateFormatter: DateFormatter = {

    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "tr_TR")
    formatter.calendar = Calendar(identifier: .gregorian)
    formatter.dateFormat = "d MMMM yyyy"

    return formatter
}()

struct MaintenanceListView: View {

    let car: Car

    @State private var selectedMaintenance: Maintenance?
    @State private var maintenanceToDelete: Maintenance?

    @Environment(\.modelContext) private var modelContext

    @State private var showAddMaintenance = false

    var body: some View {

        VStack {

            if car.maintenances.isEmpty {

                ContentUnavailableView(
                    "Henüz bakım kaydı yok",
                    systemImage: "wrench.and.screwdriver",
                    description: Text("İlk bakım kaydını ekleyebilirsin.")
                )

            } else {

                List {

                    ForEach(car.maintenances) { maintenance in

                        Button {

                            selectedMaintenance = maintenance

                        } label: {

                            VStack(alignment: .leading, spacing: 8) {

                                Text(maintenance.title)
                                    .font(.headline)

                                Text(maintenance.date, formatter: maintenanceDateFormatter)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)

                                Text(Formatters.kilometer(maintenance.mileage))
                                    .foregroundStyle(.secondary)

                                if let nextMileage = MaintenanceCalculator.nextMaintenanceMileage(for: maintenance) {
                                    Text("Sonraki Bakım: \(Formatters.kilometer(String(nextMileage)))")
                                        .font(.caption)
                                        .foregroundStyle(.blue)
                                }

                                if let remaining = MaintenanceCalculator.remainingMileage(
                                    currentMileage: car.mileage,
                                    maintenance: maintenance
                                ) {

                                    Text(
                                        remaining >= 0
                                        ? "Kalan: \(Formatters.kilometer(String(remaining)))"
                                        : "Gecikti: \(Formatters.kilometer(String(-remaining)))"
                                    )
                                    .font(.caption)
                                    .foregroundStyle(remaining >= 0 ? .green : .red)
                                }

                                if !maintenance.note.isEmpty {

                                    Text(maintenance.note)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .buttonStyle(.plain)
                        .swipeActions {

                            Button(role: .destructive) {

                                maintenanceToDelete = maintenance

                            } label: {

                                Label("Sil", systemImage: "trash")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Bakım Geçmişi")
        .toolbar {

            ToolbarItem(placement: .topBarTrailing) {

                Button {

                    showAddMaintenance = true

                } label: {

                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddMaintenance) {

            AddMaintenanceView(car: car)
        }
        .sheet(item: $selectedMaintenance) { maintenance in

            EditMaintenanceView(maintenance: maintenance)
        }
        .confirmationDialog(
            "Bu bakım kaydını silmek istediğinize emin misiniz?",
            isPresented: Binding(
                get: { maintenanceToDelete != nil },
                set: { if !$0 { maintenanceToDelete = nil } }
            ),
            titleVisibility: .visible
        ) {

            Button("Sil", role: .destructive) {

                if let maintenanceToDelete {

                    modelContext.delete(maintenanceToDelete)

                    try? modelContext.save()

                    self.maintenanceToDelete = nil
                }
            }

            Button("Vazgeç", role: .cancel) {

                maintenanceToDelete = nil
            }
        }
    }
}

#Preview {
    Text("Preview")
}
