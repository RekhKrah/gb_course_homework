//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
//2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
//3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
//4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.

class Car {
    var enginePower: Int
    var color: String
    var make: String
    var windows: WindowsState = .close
    var engine: EngineState = .off
    
    var description: String {
        return """
        \nEnginePower: \(enginePower)
        Car color: \(color)
        Make: \(make)
        Windows are \(windows.rawValue)
        Engine: \(engine.rawValue)
        """
    }
    
    enum CarAction {
        case openWindows
        case closeWindows
        case runEngine
        case stopEngine
        case fillTrunk(with: Int)
        case runNitro
    }
    
    enum EngineState: String {
        case start = "started"
        case off = "turned off"
    }
    
    enum WindowsState: String {
        case open = "opened"
        case close = "closed"
    }
    
    init(make: String, color: String, enginePower: Int) {
        self.make = make
        self.color = color
        self.enginePower = enginePower
    }
    
    func action(act: CarAction) {}
}

class TrunkCar: Car {
    var beds: Int
    var trunk = 0
    var trunkLimit: Int
    
    override var description: String {
        return super.description + """
        \nTrunk: \(trunkLimit)/\(trunk)
        Beds: \(beds)
        """
    }
    
    init(make: String, color: String, enginePower: Int, beds: Int, trunkLimit: Int) {
        self.beds = beds
        self.trunkLimit = trunkLimit
        super.init(make: make, color: color, enginePower: enginePower)
    }
    
    override func action(act: Car.CarAction) {
        switch act {
        case .openWindows:
            self.windows = .open
        case .closeWindows:
            self.windows = .close
        case .runEngine:
            self.engine = .start
        case .stopEngine:
            self.engine = .off
        case .fillTrunk(let with):
            self.trunk = with <= self.trunkLimit ? with : self.trunk
        default:
            print("This is not trunk action")
        }
    }
}

class SportCar: Car {
    var hasNitro: Bool
    var nitroRun: Car.EngineState = .off
    
    override var description: String {
        return super.description + """
        \nNitro: \(hasNitro ? "exists" : "no")
        Nitro \(nitroRun == .off ? "runs" : "not runs")
        """
    }
    
    enum SportAction {
        case openWindows
        case closeWindows
        case runEngine
        case stopEngine
        case runNitro
    }
    
    init(make: String, color: String, enginePower: Int, nitro: Bool) {
        self.hasNitro = nitro
        super.init(make: make, color: color, enginePower: enginePower)
    }
    
    override func action(act: Car.CarAction) {
        switch act {
        case .openWindows:
            self.windows = .open
        case .closeWindows:
            self.windows = .close
        case .runEngine:
            self.engine = .start
        case .stopEngine:
            self.engine = .off
        case .runNitro:
            self.nitroRun = self.hasNitro ? .start : .off
        default:
            print("This is not sport car action")
        }
    }
}
// tests
let trunkCar = TrunkCar(make: "Volvo", color: "gray", enginePower: 12_800, beds: 2, trunkLimit: 18_000)
trunkCar.action(act: .fillTrunk(with: 4800))
trunkCar.trunk == 4800
trunkCar.action(act: .fillTrunk(with: 19_000))
trunkCar.trunk == 4800
trunkCar.beds = 3
print(trunkCar.description)

let sportСar = SportCar(make: "Porche", color: "green", enginePower: 4200, nitro: false)
sportСar.action(act: .fillTrunk(with: 44))
sportСar.hasNitro == false
sportСar.nitroRun == .off
sportСar.action(act: .runNitro)
sportСar.nitroRun == .off
sportСar.hasNitro = true
sportСar.action(act: .runNitro)
sportСar.nitroRun == .start
print(sportСar.description)
