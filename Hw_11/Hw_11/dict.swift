import Foundation

func dict() {
    var cityPopulation: [String: Int] = [
        "New York": 8175133,
        "Los Angeles": 3792621,
        "Chicago": 2695598
    ]

    cityPopulation["Houston"] = 2328000
    cityPopulation["Phoenix"] = 1660272

    cityPopulation.removeValue(forKey: "Chicago")

    cityPopulation["New York"] = 8400000

    if let population = cityPopulation["Los Angeles"] {
        print("Population of Los Angeles: \(population)")
    } else {
        print("Los Angeles is not in the dictionary.")
    }

    print("Updated city population dictionary: \(cityPopulation)")
}
