import SceneKit

enum Sticker {
    case angel, brazzers, drake, kanyeGlasses, lightbulb, missiles//, mustache, sunglasses

    var title: String {
        switch self {
        case .angel:
            return "😇"
        case .brazzers:
            return "😈"
        case .drake:
            return "🦉"
        case .kanyeGlasses:
            return "🐐"
        case .lightbulb:
            return "💡"
        case .missiles:
            return "💥"
//        case .mustache:
//            return "👨🏽"
//        case .sunglasses:
//            return "🕶"
        }
    }

    static var all: [Sticker] {
        return [
            angel,
            brazzers,
            drake,
            kanyeGlasses,
            lightbulb,
            missiles,
//            mustache,
//            sunglasses
        ]
    }
}
