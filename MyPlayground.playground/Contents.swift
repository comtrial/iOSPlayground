import UIKit

class FoodFactory {
    func getFood() -> Food{
        return Food(...)
    }
}

class FoodRepository_A {
    private let foodFactory = FoodFactory()
    func deliveryFood() {
        ...
        foodFactory.getFood()
    }
}

class FoodRepository_B {
    private let foodFactory = FoodFactory()
    func deliveryFood() {
        ...
        foodFactory.getFood()
    }
}

