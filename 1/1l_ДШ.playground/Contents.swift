// Решить квадратное уравнение
import Darwin

func squareRoot(a: Double, b: Double, c: Double) -> [String: Double]? {
    let D = b * b - 4 * a * c
    
    if D < 0 { return nil } // корней нет
    
    return D == 0
        ? ["x1" : -b / (2 * a)] // один корень
        : ["x1" : (-b + sqrt(D)) / (2 * a), "x2": (-b - sqrt(D)) / (2 * a)] // два корня
}

func check(a: Double, b: Double, c: Double, x1: Double, x2: Double) -> Bool {
    let result = a * pow(x1, 2.0) + b * x1 + c
    
    return result == 0
}
// tests:
check(
    a: 1,
    b: 4,
    c: 4,
    x1: (squareRoot(a: 1, b: 4, c: 4)?["x1"])!,
    x2: (squareRoot(a: 1, b: 4, c: 4)?["x1"])!)
squareRoot(a: 1, b: -1, c: 4) == nil
check(
    a: 1,
    b: 3,
    c: -4,
    x1: (squareRoot(a: 1, b: 3, c: -4)?["x1"])!,
    x2: (squareRoot(a: 1, b: 3, c: -4)?["x2"])!)



// Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.
func calculations(a: Double, b: Double) -> [String:Double]? {
    if a <= 0 || b <= 0 { return nil }
    
    let hypotenuse = sqrt(a * a + b * b)
    let perimeter = a + b + hypotenuse
    let area = 0.5 * a * b
    
    return ["hypotenuse": hypotenuse, "perimeter": perimeter, "area": area]
}
// tests:
calculations(a: 7, b: 8) == ["hypotenuse": 10.63014581273465, "perimeter": 25.63014581273465, "area": 28]
calculations(a: 12, b: 5) == ["perimeter": 30, "area": 30, "hypotenuse": 13]
calculations(a: 4, b: 3) == ["perimeter": 12, "area": 6, "hypotenuse": 5]
calculations(a: 0, b: 5) == nil
calculations(a: 12, b: 0) == nil
calculations(a: 0, b: 0) == nil



// *Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.
func deposit(money: Double, percent: Double) -> Double? {
    if money <= 0 { return nil }
    
    var sum: Double = money
    let per = percent / 100
    
    (1...5).forEach({ _ in sum += sum * per })
    
    return sum
}
// tests:
deposit(money: 100, percent: 10) == 161.051
deposit(money: 0, percent: 10) == nil
deposit(money: -100, percent: 0) == nil
deposit(money: 100, percent: 0) == 100
deposit(money: 100, percent: -10) == 59.049



// поменять первую и последнюю цифры в числе местами
let number = 1234567
func replaceFirstAndLast(in number: Int) -> Int {
    if String(number).count < 2 { return number }
    
    var n = "\(number)"
    
    return Int(n.removeLast().description
        + n[n.index(after: n.startIndex)...]
        + n.first!.description)!
}
// tests
replaceFirstAndLast(in: 1234567) == 7234561
replaceFirstAndLast(in: 0) == 0
replaceFirstAndLast(in: 12) == 21
