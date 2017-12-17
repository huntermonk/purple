import SceneKit

struct Sticker {
    var node: SCNNode
    var keyword: String
    var title: String

    static var angel: Sticker {
        return Sticker(node: SCNNode.angelWings, keyword: "angel wings", title: "😇")
    }

    static var brazzers: Sticker {
        return Sticker(node: SCNNode.brazzers, keyword: "brazzers", title: "😈")
    }

    static var drake: Sticker {
        return Sticker(node: SCNNode.drake, keyword: "drake", title: "🦉")
    }

    static var kanyeGlasses: Sticker {
        return Sticker(node: SCNNode.kanyeGlasses, keyword: "kanye west glasses", title: "🐐")
    }

    static var lightbulb: Sticker {
        return Sticker(node: SCNNode.lightbulb, keyword: "light bulb", title: "💡")
    }

    static var missiles: Sticker {
        return Sticker(node: SCNNode.missiles, keyword: "missiles", title: "💥")
    }

    static var mustache: Sticker {
        return Sticker(node: SCNNode.mustache, keyword: "mustache", title: "👨🏽")
    }

    static var sunglasses: Sticker {
        return Sticker(node: SCNNode.sunglasses, keyword: "glasses, deal with it", title: "🕶")
    }

    static var all: [Sticker] {
        return [
            angel,
            brazzers,
            drake,
            kanyeGlasses,
            lightbulb,
            missiles,
            mustache,
            sunglasses
        ]
    }

}
