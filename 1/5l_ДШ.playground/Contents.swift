//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
protocol Car {
    var enginePower: Int { get }
    var make: String { get }
    var windows: WindowsState { get set }
    
    func run() -> Void
}

enum WindowsState {
    case opened
    case closed
}

//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
extension Car {
    mutating func openWindows() {
        if windows == .opened {
            print("windows already opened")
            return
        }
        windows = .opened
    }
    
    mutating func closeWindows() {
        if windows == .closed {
            print("windows already closed")
            return
        }
        windows = .closed
    }
}

//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
class TrunkCar: Car {
    var enginePower: Int
    var make: String
    var windows: WindowsState = .closed
    var trunkLimit:Int
    var trunk:Int = 0
    
    init(enginePower: Int, make: String, trunkLimit:Int) {
        self.enginePower = enginePower > 0 ? enginePower : 0
        self.make = make.count > 2 ? make : "NoNamed"
        self.trunkLimit = trunkLimit > 0 ? trunkLimit : 0
    }
    
    func run() {
        print("we running")
    }
    
    func fillTheTrunk(with: Int) {
        self.trunk = (with > self.trunkLimit || with < 0) ? self.trunk : with
    }
}
// tests
var tCar = TrunkCar(enginePower: 14_000, make: "qq", trunkLimit: -9)
tCar.enginePower == 14_000
tCar.make == "NoNamed"
tCar.trunkLimit == 0
tCar.fillTheTrunk(with: 3000)
tCar.trunk == 0
tCar.closeWindows()
tCar.openWindows()
tCar.windows == .opened

let tCar2 = TrunkCar(enginePower: -5, make: "BMW", trunkLimit: 15_000)
tCar2.enginePower == 0
tCar2.make == "BMW"
tCar2.trunkLimit == 15_000
tCar2.fillTheTrunk(with: 16_000)
tCar2.trunk == 0
tCar2.fillTheTrunk(with: -90)
tCar2.trunk
tCar2.fillTheTrunk(with: 14_000)
tCar2.trunk == 14_000

class SportCar: Car {
    var enginePower: Int
    var make: String
    var windows: WindowsState = .closed
    var hasNitro: Bool
    var nitroState: NitroState = .off
    
    enum NitroState {
        case on
        case off
    }
    
    init(enginePower: Int, make: String, hasNitro: Bool) {
        self.enginePower = enginePower > 0 ? enginePower : 0
        self.make = make.count > 2 ? make : "NoNamed"
        self.hasNitro = hasNitro
    }
    
    func run() {
        print("Let's ride!")
    }
    
    func turnOnNitro() {
        if !self.hasNitro { print("you have no nitro"); return }
        self.nitroState = .on
    }
    
    func turnOffNitro() {
        if !self.hasNitro { print("you have no nitro"); return }
        self.nitroState = .off
    }
    
}

//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
extension TrunkCar: CustomStringConvertible {
    var description: String {
        return """
        Engine power: \(self.enginePower)
        Make: \(self.make)
        Trunk: \(self.trunk)/\(self.trunkLimit)
        Windows: \(self.windows)
        """
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return """
        Engine power: \(self.enginePower)
        Make: \(self.make)
        Nitro: \(self.hasNitro ? "exists" : "does not exists") and \(self.nitroState)
        Windows: \(self.windows)
        """
    }
}
// tests
tCar.description
tCar2.description
var tCar3 = SportCar(enginePower: 4300, make: "Tesla", hasNitro: false)
tCar3.openWindows()
tCar3.description

//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
var trunkCar = TrunkCar(enginePower: 15_000, make: "MAN", trunkLimit: 4_000)
trunkCar.fillTheTrunk(with: 3_000)
trunkCar.openWindows()

var sportCar = SportCar(enginePower: 5000, make: "Porche", hasNitro: true)
sportCar.turnOnNitro()
sportCar.nitroState == .on

//6. Вывести сами объекты в консоль.
print(trunkCar)
print(sportCar)
