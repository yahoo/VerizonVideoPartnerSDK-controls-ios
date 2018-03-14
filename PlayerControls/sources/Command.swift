//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

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
    public func bind(to value: T) -> Command {
        return Command { self.perform(with: value) }
    }
    
    public func map<U>(block: @escaping (U) -> T) -> CommandWith<U> {
        return CommandWith<U> { self.perform(with: block($0)) }
    }
}

extension CommandWith: Codable {
    
    private static var currentType: String {
        return T.self == Void.self
            ? "Command"
            : String(describing: CommandWith.self)
    }
    
    public enum CodingError: Error { case decoding(String) }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let descriptor = try container.decode(String.self)
        guard CommandWith.currentType == descriptor else {
            throw CodingError.decoding("Decoding Failed. Exptected: \(CommandWith.currentType). Recieved \(descriptor)")
        }
        self = .nop
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(CommandWith.currentType)
    }
}

