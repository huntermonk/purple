import SceneKit

public class MaskedMaterial: SCNMaterial {

    public init(transparencyMask: Any) {
        super.init()

        // white is transparent, black is fully opaque
        let surfaceShader =
        """
        _surface.transparent.a = _surface.transparent.r;
        """

        shaderModifiers = [
            .surface: surfaceShader,
        ]

        transparent.contents = transparencyMask
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

