import SwiftUI
import SwiftData

struct FuelListView: View {

    let car: Car
    
    @State private var showAddFuel = false

    var body: some View {

        ContentUnavailableView(
            "Henüz yakıt kaydı yok",
            systemImage: "fuelpump",
            description: Text("İlk yakıt kaydını ekleyebilirsin.")
        )
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
