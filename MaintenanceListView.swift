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

                                Text("\(maintenance.mileage) km")
                                    .foregroundStyle(.secondary)

                                Text(maintenance.note)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .buttonStyle(.plain)
                    }
                    .onDelete(perform: deleteMaintenance)
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
    }

    private func deleteMaintenance(at offsets: IndexSet) {

        for index in offsets {

            let maintenance = car.maintenances[index]

            modelContext.delete(maintenance)
        }

        try? modelContext.save()
    }
}

#Preview {
    Text("Preview")
}
