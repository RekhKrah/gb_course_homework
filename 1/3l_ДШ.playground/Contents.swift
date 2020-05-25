// 1. Описать несколько структур – любой легковой автомобиль и любой грузовик.
// 2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
// 3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
// 4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
// 5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
// 6. Вывести значения свойств экземпляров в консоль.

// STRUCTURES
struct Car {
    var make: String
    var model: String
    var year: Int
    var trunkVolume: Int
    var trunkOccupancy: Int = 0
    var windows: WindowsState = .closed
    var engine: EngineState = .off
    
    mutating func set(_ parameter: CarParameter) {
        switch parameter {
            
        case .trunkOccupancy(let weight) where weight <= self.trunkVolume:
            self.trunkOccupancy = weight
        
        case .trunkOccupancy:
            print("ERROR: 'trunkOccupancy' value is out of range")
        
        case .windows(let to):
            self.windows = to
        
        case .engine(let to):
            self.engine = to
        }
    }
    
    init(make: String = "Tesla", model: String = "Roadster", year: Int = 2020, trunkVolume: Int = 1600) {
        self.make = make
        self.model = model
        self.year = year
        self.trunkVolume = trunkVolume
    }
    
    func description() {
        print("make: \(make)\nmodel: \(model)\nyear: \(year)\ntrunk: \(trunkVolume)/\(trunkOccupancy)\nwindows are \(windows.rawValue)\nengine \(engine.rawValue)\n")
    }
}

struct Truck {
    var make: String
    var model: String
    var year: Int
    var trunkVolume: Int
    var trunkOccupancy: Int = 0
    var windows: WindowsState = .closed
    var engine: EngineState = .off
    
    mutating func action(_ parameter: TruckActions) {
        switch parameter {
        case .openWindows:
            windows = .opened
        case .closeWindows:
            windows = .closed
        case .runEngine:
            engine = .run
        case .stopEngine:
            engine = .off
        case .fillTrunk(let with) where with < trunkVolume:
            trunkOccupancy = with
        case .fillTrunk:
            print("ERROR: 'trunkOccupancy' value is out of range")
        }
    }
    
    init(make: String = "Volvo", model: String = "FH", year: Int = 2010, trunkVolume: Int = 36_000) {
        self.make = make
        self.model = model
        self.year = year
        self.trunkVolume = trunkVolume
    }
    
    func description() {
        print("make: \(make)\nmodel: \(model)\nyear: \(year)\ntrunk: \(trunkVolume)/\(trunkOccupancy)\nwindows are \(windows.rawValue)\nengine \(engine.rawValue)\n")
    }
}

// ENUMS
enum CarParameter {
    case trunkOccupancy(weight: Int)
    case windows(to: WindowsState)
    case engine(to: EngineState)
}

enum WindowsState: String {
    case opened = "open"
    case closed = "close"
}

enum EngineState: String {
    case run = "started"
    case off = "stopped"
}

enum TruckActions {
    case openWindows
    case closeWindows
    case runEngine
    case stopEngine
    case fillTrunk(with: Int)
}

//tests
var myCar = Car()
myCar.model == "Roadster"
myCar.make == "Tesla"
myCar.windows == .closed
myCar.engine == .off
myCar.trunkVolume == 1600

myCar.set(.engine(to: .run))
myCar.engine == .run

myCar.set(.trunkOccupancy(weight: 800))
myCar.trunkOccupancy == 800

myCar.set(.trunkOccupancy(weight: 1800))
myCar.trunkOccupancy == 800

myCar.set(.engine(to: .off))
myCar.set(.windows(to: .opened))
myCar.description()

var myTruck = Truck(make: "Tesla", model: "Semi", year: 2021)
myTruck.model == "Semi"
myTruck.make == "Tesla"
myTruck.windows == .closed
myTruck.engine == .off
myTruck.trunkVolume == 36_000

myTruck.action(.openWindows)
myTruck.action(.runEngine)
myTruck.windows == .opened
myTruck.engine == .run

myTruck.action(.fillTrunk(with: 35_800))
myTruck.trunkOccupancy == 35_800

myTruck.action(.fillTrunk(with: 37_000))
myTruck.trunkOccupancy == 35_800

myTruck.description()
