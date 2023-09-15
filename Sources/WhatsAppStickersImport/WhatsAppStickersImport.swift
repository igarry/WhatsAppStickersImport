import YYImage

public struct WhatsAppStickersImport {
    public private(set) var text = "Hello, World!"

    public init() {
        print(text)
    }
    
    public static func sayHello() {
        print("Hello, World!")
        
    }
    
    public static func fetchStickerPacks(with trayImage: UIImage,
                                         stickerImages: [(image: UIImage, emojis: [String])],
                                         iosAppStoreLink: String?,
                                         androidAppStoreLink: String?,
                                         packIdentifier: String,
                                         packName: String,
                                         packPublisher: String,
                                         packPublisherWebsite: String?,
                                         packPrivacyPolicyWebsite: String?,
                                         packLicenseAgreementWebsite: String?,
                                         completionHandler: @escaping (Bool) -> Void) {
        do {
            try StickerPackManager.fetchStickerPacks(with: trayImage,
                                                     stickerImages: stickerImages,
                                                     iosAppStoreLink: iosAppStoreLink,
                                                     androidAppStoreLink: androidAppStoreLink,
                                                     packIdentifier: packIdentifier,
                                                     packName: packName,
                                                     packPublisher: packPublisher,
                                                     packPublisherWebsite: packPublisherWebsite,
                                                     packPrivacyPolicyWebsite: packPrivacyPolicyWebsite,
                                                     packLicenseAgreementWebsite: packLicenseAgreementWebsite, completionHandler: { stickerPack in
                guard let stickerPack = stickerPack else {
                    fatalError("no stickerPack created")
                }
                stickerPack.sendToWhatsApp { completed in
                    completionHandler(completed)
                }
            })
        } catch StickerPackError.fileNotFound {
            fatalError("sticker_packs.wasticker not found.")
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
