import SwiftUI
import FruitApi

struct FruitList: View {
    @State var fruits: [Fruit] = []
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationStack {
            List(fruits, id: \.self) { fruit in
                NavigationLink(value: fruit) {
                    Text(fruit.name)
                }
            }
            .navigationDestination(for: Fruit.self) { fruit in
                FruitDetail(fruit: fruit)
            }
            .overlay {
                if isLoading {
                    ProgressView()
                }
            }
            .navigationTitle("fruitList".localized)
            .onAppear {
                loadFruits()
            }
        }
    }
}

private extension FruitList {
    private func loadFruits() {
        DefaultAPI.getAllFruits { data, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.fruits = data
                    self.isLoading = false
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

struct FruitDetail: View {
    var fruit: Fruit
    
    var body: some View {
        List {
            Section("info".localized) {
                Text("\("name".localized): \(fruit.name)")
                Text("\("family".localized): \(fruit.family)")
                Text("\("order".localized): \(fruit.order)")
                Text("\("genus".localized): \(fruit.genus)")
            }
            
            Section("\("nutritions".localized)") {
                Text("\("calories".localized): \(fruit.nutritions.calories)")
                Text("\("fat".localized): \(fruit.nutritions.fat)")
                Text("\("sugar".localized): \(fruit.nutritions.sugar)")
                Text("\("carbohydrates".localized): \(fruit.nutritions.carbohydrates)")
                Text("\("protein".localized): \(fruit.nutritions.protein)")
            }
            
        }
    }
}

#Preview {
    FruitList()
}
