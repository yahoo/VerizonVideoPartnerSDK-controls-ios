//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

public typealias Command = CommandWith<Void>

public struct CommandWith<T> {
    private var action: (T) -> Void
    
    public static var nop: CommandWith { return CommandWith { _ in } }
    
    public init(action: @escaping (T) -> Void) {
        self.action = action
    }
    public func perform(with value: T) {
        self.action(value)
    }
}

extension CommandWith where T == Void {
    public func perform() {
        self.perform(with: ())
    }
}

extension CommandWith {
    func bind(to value: T) -> Command {
        return Command { self.perform(with: value) }
    }
    
    func map<U>(block: @escaping (U) -> T) -> CommandWith<U> {
        return CommandWith<U> { self.perform(with: block($0)) }
    }
}
