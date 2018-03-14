//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

public struct Color {
    public var color: UIColor
    
    public init(_ color: UIColor) {
        self.color = color
    }
}

extension Color: Codable {
    public enum CodingKeys: CodingKey { case r, g, b, a }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let r = try values.decode(CGFloat.self, forKey: .r)
        let g = try values.decode(CGFloat.self, forKey: .g)
        let b = try values.decode(CGFloat.self, forKey: .b)
        let a = try values.decode(CGFloat.self, forKey: .a)
        self.color = UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        try container.encode(r, forKey: .r)
        try container.encode(g, forKey: .g)
        try container.encode(b, forKey: .b)
        try container.encode(a, forKey: .a)
    }
}

