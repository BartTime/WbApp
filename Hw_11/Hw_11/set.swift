import Foundation

func set() {
    var intSet: Set<Int> = [1, 2, 3, 4, 5]

    intSet.insert(6)
    intSet.insert(7)

    intSet.remove(3)

    let containsFour = intSet.contains(4)
    print("Set contains 4: \(containsFour)")

    let secondSet: Set<Int> = [4, 5, 6, 7, 8, 9]

    let unionSet = intSet.union(secondSet)
    let intersectionSet = intSet.intersection(secondSet)
    let differenceSet = intSet.subtracting(secondSet)

    print("Union: \(unionSet)")
    print("Intersection: \(intersectionSet)")
    print("Difference: \(differenceSet)")
}
