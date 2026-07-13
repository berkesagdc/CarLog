import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showAddCar = false

    @Environment(\.modelContext) private var modelContext

    @Query private var cars: [Car]
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                Image(systemName: "car.fill")
                    .font(.system(size: 70))
                    .foregroundColor(.blue)

                Text("CarLog")
                    .font(.largeTitle)
                    .bold()

                Text("Araç bakımını takip etmenin en kolay yolu")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

                Button("Araç Ekle") {
                    showAddCar = true
                }
                .buttonStyle(.borderedProminent)

                List {

                    ForEach(cars) { car in

                        NavigationLink {

                            CarDetailView(car: car)

                        } label: {

                            CarCardView(car: car)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets())
                                .padding(.vertical, 6)
                        }
                    }
                    .onDelete(perform: deleteCar)
                }
                .listStyle(.plain)

                Spacer()
            }
            .padding()
            .navigationTitle("Ana Sayfa")
            .sheet(isPresented: $showAddCar) {
                AddCarView()
            }
        }
    }

    private func deleteCar(at offsets: IndexSet) {

        for index in offsets {
            modelContext.delete(cars[index])
        }

        try? modelContext.save()
    }
}

#Preview {
    ContentView()
}
