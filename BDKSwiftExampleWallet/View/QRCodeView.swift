//
//  QRCodeView.swift
//  BDKSwiftExampleWallet
//
//  Created by Matthew Ramsden on 6/20/23.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    var address: String
    
    var body: some View {
        Image(uiImage: generateQRCode(from: "bitcoin:\(address)"))
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .padding()
    }
}

extension QRCodeView {
    func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    QRCodeView(address: "tb1qz9hhk2qlsmdanrzgl38uv86hqnqe5vyszrld7s")
}
