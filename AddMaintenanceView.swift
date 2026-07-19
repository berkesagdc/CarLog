import SwiftUI
import SwiftData

struct AddMaintenanceView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let car: Car

    @State private var title = ""
    @State private var mileage = ""
    @State private var repeatMileage = ""
    @State private var note = ""

    private var formIsValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty &&
        Int(mileage) != nil &&
        Int(repeatMileage) != nil
    }

    var body: some View {

        NavigationStack {

            Form {

                Section("Bakım") {

                    TextField("Örneğin: Yağ Değişimi", text: $title)

                    TextField("Kilometre", text: $mileage)
                        .keyboardType(.numberPad)

                    TextField("Tekrar Aralığı (km)", text: $repeatMileage)
                        .keyboardType(.numberPad)

                    TextField("Not", text: $note)
                }
            }
            .navigationTitle("Bakım Ekle")
            .toolbar {

                ToolbarItem(placement: .topBarLeading) {

                    Button("İptal") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {

                    Button("Kaydet") {

                        let newMaintenance = Maintenance(
                            title: title,
                            date: Date(),
                            mileage: mileage,
                            repeatMileage: repeatMileage,
                            note: note
                        )

                        newMaintenance.car = car

                        modelContext.insert(newMaintenance)

                        try? modelContext.save()

                        dismiss()
                    }
                    .disabled(!formIsValid)
                }
            }
        }
    }
}

#Preview {
    Text("Preview")
}
