import SwiftUI
import SwiftData

struct AddFuelView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let car: Car

    @State private var mileage = ""
    @State private var liters = ""
    @State private var totalPrice = ""

    var body: some View {

        NavigationStack {

            Form {

                Section("Yakıt Bilgileri") {

                    TextField("Kilometre", text: $mileage)
                        .keyboardType(.numberPad)

                    TextField("Litre", text: $liters)
                        .keyboardType(.decimalPad)

                    TextField("Toplam Ücret", text: $totalPrice)
                        .keyboardType(.decimalPad)
                }
            }

            .navigationTitle("Yakıt Ekle")

            .toolbar {

                ToolbarItem(placement: .topBarLeading) {

                    Button("İptal") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {

                    Button("Kaydet") {

                        let fuel = FuelLog(
                            mileage: mileage,
                            liters: liters,
                            totalPrice: totalPrice
                        )

                        fuel.car = car
                        
                        car.mileage = mileage

                        modelContext.insert(fuel)

                        try? modelContext.save()

                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    Text("Preview")
}
