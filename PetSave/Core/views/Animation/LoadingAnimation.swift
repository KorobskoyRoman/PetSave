//
//  LoadingAnimation.swift
//  PetSave
//
//  Created by Roman Korobskoy on 27.01.2023.
//

import SwiftUI

struct LoadingAnimation: UIViewRepresentable {
    let animatedFrames: UIImage
    let image: UIImageView
    let squareDimension: CGFloat = 125

    init() {
        var images: [UIImage] = []
        let animationDuration: Double = 4

        for i in 1...127 {
            guard let image = UIImage(named: "dog_\(String(format: "%03d", i))") else { continue }
            images.append(image)
        }

        animatedFrames = UIImage.animatedImage(
            with: images,
            duration: animationDuration
        ) ?? UIImage()

        image = UIImageView(
            frame: CGRect(
                x: 0, y: 0,
                width: squareDimension,
                height: squareDimension
            )
        )
    }

    func makeUIView(context: Context) -> some UIView {
        let view = UIView(
            frame: CGRect(
                x: 0, y: 0,
                width: squareDimension,
                height: squareDimension
            )
        )

        image.clipsToBounds = true
        image.autoresizesSubviews = true
        image.contentMode = .scaleAspectFit
        image.image = animatedFrames
        image.center = CGPoint(x: view.frame.width / 2,
                               y: view.frame.height / 2)
        view.backgroundColor = .red
        view.addSubview(image)

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
}

struct LoadingAnimationView: View {
    var body: some View {
        VStack {
            LoadingAnimation()
        }
    }
}

struct LoadingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAnimation()
            .frame(width: 125, height: 125, alignment: .center)
            .previewLayout(.sizeThatFits)
    }
}
