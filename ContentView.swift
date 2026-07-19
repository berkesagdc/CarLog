import SwiftUI
import SwiftData

struct ContentView: View {

    @State private var showAddCar = false
    @State private var carToDelete: Car?

    @Environment(\.modelContext) private var modelContext

    @Query private var cars: [Car]

    var body: some View {

        NavigationStack {

            List {

                Section {

                    VStack(spacing: 20) {

                        Image(systemName: "car.fill")
                            .font(.system(size: 70))
                            .foregroundStyle(.blue)

                        Text("CarLog")
                            .font(.largeTitle)
                            .bold()

                        Text("Araç bakımını takip etmenin en kolay yolu")
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)

                        if let firstCar = cars.first {

                            Text("\(firstCar.brand) \(firstCar.model)")
                                .font(.title2.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)

                            NextMaintenanceCard(car: firstCar)

                            AverageConsumptionCard(car: firstCar)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .listRowSeparator(.hidden)

                }

                Section("Araçlar") {

                    ForEach(cars) { car in

                        NavigationLink {

                            CarDetailView(car: car)

                        } label: {

                            CarCardView(car: car)
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .padding(.vertical, 6)
                        .swipeActions {

                            Button(role: .destructive) {

                                carToDelete = car

                            } label: {

                                Label("Sil", systemImage: "trash")
                            }
                        }
                    }
                }

                Section {

                    Button {

                        showAddCar = true

                    } label: {

                        Label("Araç Ekle", systemImage: "plus")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Dashboard")
            .sheet(isPresented: $showAddCar) {

                AddCarView()
            }
            .confirmationDialog(
                "Bu aracı silmek istediğinize emin misiniz?",
                isPresented: Binding(
                    get: { carToDelete != nil },
                    set: { if !$0 { carToDelete = nil } }
                )
            ) {

                Button("Sil", role: .destructive) {

                    if let carToDelete {

                        modelContext.delete(carToDelete)

                        try? modelContext.save()

                        self.carToDelete = nil
                    }
                }

                Button("Vazgeç", role: .cancel) {

                    carToDelete = nil
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
