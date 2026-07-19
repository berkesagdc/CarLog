import SwiftUI
import SwiftData

struct CarDetailView: View {

    let car: Car

    @State private var showEditCar = false

    var body: some View {

        Form {

            Section("Araç Bilgileri") {

                Label(car.plate, systemImage: "number")

                Label(Formatters.kilometer(car.mileage), systemImage: "speedometer")

                Label(car.year, systemImage: "calendar")
                
                Label("\(car.fuelLogs.count) Yakıt Kaydı", systemImage: "fuelpump")

                Label("\(car.maintenances.count) Bakım Kaydı", systemImage: "wrench.and.screwdriver")

                NavigationLink {

                    MaintenanceListView(car: car)

                } label: {

                    Label("Bakım Geçmişi", systemImage: "wrench.and.screwdriver")
                        .font(.headline)
                }
                .padding(.top)

                NavigationLink {

                    FuelListView(car: car)

                } label: {

                    Label("Yakıt Geçmişi", systemImage: "fuelpump")
                        .font(.headline)
                }
            }
        }
        .navigationTitle("\(car.brand) \(car.model)")
        .toolbar {

            ToolbarItem(placement: .topBarTrailing) {

                Button {

                    showEditCar = true

                } label: {

                    Image(systemName: "pencil")
                }
            }
        }
        .sheet(isPresented: $showEditCar) {

            EditCarView(car: car)
        }
    }
}

#Preview {

    CarDetailView(
        car: Car(
            brand: "BMW",
            model: "430",
            year: "2022",
            plate: "34 BRK 034",
            mileage: "22000"
        )
    )
}
