// Renders Xcode's iPhone 15 Pro Simulator bezel to a transparent WebP with the screen cut out,
// for PhoneFrame. Usage: swift scripts/render-iphone-frame.swift public/media/iphone-frame.webp

import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

// "iPhone 15 Pro.simdevicetype" names this chrome in its profile.plist.
let chrome = "/Library/Developer/DeviceKit/Chrome/phone9.devicechrome/Contents/Resources"
let scale: CGFloat = 3
// The Simulator takes the screen shape from a framebuffer mask, not the chrome, so these are the device's own.
let screenRadius: CGFloat = 57
let islandSize = CGSize(width: 126, height: 37)
let islandTop: CGFloat = 11

struct Chrome: Decodable {
  struct Images: Decodable {
    struct Sizing: Decodable { let leftWidth, topHeight: CGFloat }
    struct Padding: Decodable { let width: CGFloat }
    let composite: String
    let sizing: Sizing
    let padding: Padding
  }
  struct Input: Decodable {
    struct Offsets: Decodable {
      struct Point: Decodable { let x, y: CGFloat }
      let normal: Point
    }
    let image: String
    let anchor: String
    let offsets: Offsets
  }
  let images: Images
  let inputs: [Input]
}

let output = URL(fileURLWithPath: CommandLine.arguments[1])
let spec = try JSONDecoder().decode(Chrome.self, from: Data(contentsOf: URL(fileURLWithPath: "\(chrome)/chrome.json")))

func getPage(_ name: String) -> CGPDFPage {
  CGPDFDocument(URL(fileURLWithPath: "\(chrome)/\(name).pdf") as CFURL)!.page(at: 1)!
}

func getSize(_ page: CGPDFPage) -> CGSize { page.getBoxRect(.mediaBox).size }

let body = getPage(spec.images.composite)
let bodySize = getSize(body)
let padding = spec.images.padding.width
let canvas = CGSize(width: bodySize.width + padding * 2, height: bodySize.height)

let context = CGContext(
  data: nil,
  width: Int(canvas.width * scale),
  height: Int(canvas.height * scale),
  bitsPerComponent: 8,
  bytesPerRow: 0,
  space: CGColorSpace(name: CGColorSpace.sRGB)!,
  bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
)!
context.scaleBy(x: scale, y: scale)
context.translateBy(x: 0, y: canvas.height)
context.scaleBy(x: 1, y: -1)

func draw(_ page: CGPDFPage, at origin: CGPoint) {
  context.saveGState()
  context.translateBy(x: origin.x, y: origin.y + getSize(page).height)
  context.scaleBy(x: 1, y: -1)
  context.drawPDFPage(page)
  context.restoreGState()
}

// Buttons go first so the body covers all but the part that sticks out, as in the Simulator.
spec.inputs.forEach { input in
  let image = getPage(input.image)
  let offset = input.offsets.normal
  let x = input.anchor == "left" ? padding + offset.x - getSize(image).width : padding + bodySize.width + offset.x
  draw(image, at: CGPoint(x: x, y: offset.y))
}

draw(body, at: CGPoint(x: padding, y: 0))

let screen = CGRect(
  x: padding + spec.images.sizing.leftWidth,
  y: spec.images.sizing.topHeight,
  width: bodySize.width - spec.images.sizing.leftWidth * 2,
  height: bodySize.height - spec.images.sizing.topHeight * 2
)
context.setBlendMode(.clear)
context.addPath(CGPath(roundedRect: screen, cornerWidth: screenRadius, cornerHeight: screenRadius, transform: nil))
context.fillPath()

// Recordings leave the Dynamic Island out, like a phone's own screen recording.
context.setBlendMode(.normal)
context.setFillColor(CGColor(red: 0, green: 0, blue: 0, alpha: 1))
let island = CGRect(
  x: screen.midX - islandSize.width / 2,
  y: screen.minY + islandTop,
  width: islandSize.width,
  height: islandSize.height
)
context.addPath(
  CGPath(roundedRect: island, cornerWidth: islandSize.height / 2, cornerHeight: islandSize.height / 2, transform: nil)
)
context.fillPath()

// ImageIO can't encode WebP, so the PNG goes through cwebp.
let png = FileManager.default.temporaryDirectory.appendingPathComponent("iphone-frame.png")
let destination = CGImageDestinationCreateWithURL(png as CFURL, UTType.png.identifier as CFString, 1, nil)!
CGImageDestinationAddImage(destination, context.makeImage()!, nil)
CGImageDestinationFinalize(destination)

let cwebp = Process()
cwebp.executableURL = URL(fileURLWithPath: "/usr/bin/env")
cwebp.arguments = ["cwebp", "-quiet", "-q", "90", "-alpha_q", "100", png.path, "-o", output.path]
try cwebp.run()
cwebp.waitUntilExit()

print("Frame \(Int(canvas.width))×\(Int(canvas.height))pt, screen \(screen) with a \(Int(screenRadius))pt radius")
