//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
struct Queue<T : Hashable> {
    private let base: [T]
    let items: [T]
    
    init(_ items: [T]) {
        self.base = items
        self.items = items
    }
    
    var unique: [T] {
        return Array(Set(self.base))
    }
    
    func filter(_ closure: (T) -> Bool) -> [T] {
        return self.base.filter { closure($0) }
    }
    
    subscript(index: Int) -> T? {
        get {
            return index >= 0 && index < self.base.count ? self.base[index] : nil
        }
    }
}
//tests
let items = [1,2,3,2,1]
let queue = Queue<Int>(items)
queue.unique != items

queue.unique
    .map { queue.items.contains($0) }
    .reduce(true, { $0 && $1 }) == true

queue
    .filter { $0 > 2 } == [3]

queue[0] == 1
queue[5] == nil
queue[-9] == nil
