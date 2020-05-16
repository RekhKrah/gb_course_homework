// 1. Написать функцию, которая определяет, четное число или нет.
func isEven(_ number: Int) -> Bool {
    return number % 2 == 0 ? true : false
}
// tests
isEven(4) == true
isEven(1) == false
isEven(0) == true

// 2. Написать функцию, которая определяет, делится ли число без остатка на 3.
func isDivisibleByThree(_ number: Int) -> Bool {
    return number % 3 == 0 ? true : false
}
// tests
isDivisibleByThree(3) == true
isDivisibleByThree(30) == true
isDivisibleByThree(0) // тут не понятно. с одной стороны, 0 - четное, а с другой - машина говорит, что делится
isDivisibleByThree(31) == false

// 3. Создать возрастающий массив из 100 чисел.
var listOfHundred = Array(1...100)

// 4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
func removeEvenAndMultipleOfThree(_ list: [Int]) -> [Int] {
    return list.filter { !isEven($0) && isDivisibleByThree($0) }
}
//test
removeEvenAndMultipleOfThree([1,2,3,4,5,6,7,8,9]) == [3,9]

listOfHundred = removeEvenAndMultipleOfThree(listOfHundred)

// 5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов.
func addFibonacci(to list: inout [Double]) {
    if let last = list.last {
        if list.count > 2 {
            list.append(last + list[list.count - 2])
        } else {
            list.append(1)
        }
    } else {
        list.append(0)
    }
}
//tests
var temp: [Double] = []
addFibonacci(to: &temp)
temp == [0]
addFibonacci(to: &temp)
temp == [0, 1]
addFibonacci(to: &temp)
addFibonacci(to: &temp)
temp == [0, 1, 1, 2]

temp = []
for _ in 1...100 {
    addFibonacci(to: &temp)
}
temp

//6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:
//a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
//b. Пусть переменная p изначально равна двум — первому простому числу.
//c. Зачеркнуть в списке числа от 2p до n, считая шагами по p (это будут числа, кратные p: 2p, 3p, 4p, ...).
//d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
//e. Повторять шаги c и d, пока возможно.
func getListOfSimpleNumbers(to n: Int) -> [Int] {
    if n < 2 { return [] }
    
    var list = Array(2...n)
    var index = 0
    
    for i in list {
        if(index + 1 >= list.count) { return list }
        
        index += 1
        
        list = list.prefix(upTo: index) + list[index...].filter { $0 % i > 0 && $0 % i < i }
    }
    return list
}
//tests
getListOfSimpleNumbers(to: 20) == [2, 3, 5, 7, 11, 13, 17, 19]
getListOfSimpleNumbers(to: 0) == []
getListOfSimpleNumbers(to: 2) == [2]

var simpleNumbers = getListOfSimpleNumbers(to: 543)
simpleNumbers.count == 100
