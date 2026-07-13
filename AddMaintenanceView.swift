import SwiftUI
import SwiftData

struct AddMaintenanceView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let car: Car

    @State private var title = ""
    @State private var mileage = ""
    @State private var note = ""

    var body: some View {

        NavigationStack {

            Form {

                Section("Bakım") {

                    TextField("Örneğin: Yağ Değişimi", text: $title)

                    TextField("Kilometre", text: $mileage)

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
                            note: note
                        )

                        newMaintenance.car = car
                        
                        modelContext.insert(newMaintenance)
                        
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
