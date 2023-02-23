//
//  extensions.swift
//  WeatherApp
//
//  Created by Dara Adekore on 2023-02-21.
//

import Foundation
import UIKit
extension UIImage {
    class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("Failed to create image source from data.")
            return nil
        }
        let frameCount = CGImageSourceGetCount(source)
        var frames = [UIImage]()
        for i in 0..<frameCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                let uiImage = UIImage(cgImage: cgImage)
                frames.append(uiImage)
            }
        }
        return UIImage.animatedImage(with: frames, duration: 0.1 * Double(frameCount))
    }
}
