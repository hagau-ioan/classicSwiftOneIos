//
//  BackgroundDownloadHandler.swift
//  BackgroundDownloadSample
//
//  Created by Hagau Ioan on 23.05.2024.
//

import BackgroundAssets

//The key takeaway is that BADownloaderExtension is called by the system to handle background downloads, not directly by your app. It's designed for quick scheduling and doesn't handle tasks like asset decompression.
//BADownloaderExtension protocol is called during specific app lifecycle events related to background downloads:
// A complete exmple can be found here: https://github.com/pkozielecki/ios-assets-bundling/blob/main/Assets%20Bundling%20POC/Code/AssetBundlerApp.swift

// How To be called from Main App:
//downloadManager = BADownloadManager.shared
//let download: BADownload // An BADownload object
//downloadManager.startForegroundDownload(download)

@main
struct BackgroundDownloadHandler: BADownloaderExtension
{
    func downloads(for request: BAContentRequest,
                   manifestURL: URL,
                   extensionInfo: BAAppExtensionInfo) -> Set<BADownload>
    {
        
        // Invoked by the system to request downloads from your extension.
        // The BAContentRequest argument will contain the reason downloads are requested.
        // The system will pre-download the contents of the URL specified in the `BAManifestURL`
        // key in your app's `Info.plist` before calling into your extension. The `manifestURL`
        // argument will point to a read-only file containing those contents. You are encouraged
        // to use this file to determine what assets need to be downloaded.
        
        let appGroupIdentifier = "group.com.learningswift.ClassicSwiftOne"

        // Parse the file at `manifestURL` to determine what assets are available
        // that might need to be scheduled for download.
        // Note: A downloads's identifier should be unique. It is what is used to track your
        // download between the extension and app.
        let assetURL = URL(string: "https://example.com/large-asset.bin")!
        let oneMB = 1024 * 1024
        let assetSize = oneMB * 4

        // Then, create a set of downloads to return to the system.
        var downloadsToSchedule: Set<BADownload> = []
        
        switch (request) {
        case .install, .update:
            // In an install or update request, you can return both Essential and Non-Essential downloads.
            // Essential downloads will be started by the system while your app is installing/updating,
            // and the user cannot launch the app until they complete or fail.
            // To mark a download as Essential, pass `true` for the `essential` initializer argument.
            let essentialDownload = BAURLDownload(
                identifier: "Unique-Asset-Identifier",
                request: URLRequest(url: assetURL),
                essential: true,
                fileSize: assetSize,
                applicationGroupIdentifier: appGroupIdentifier,
                priority: .default)

            downloadsToSchedule.insert(essentialDownload)
            break;

        case .periodic:
            // In a periodic request, you can only return Non-Essential downloads.
            // Non-Essential downloads occur in the background and will not prevent the
            // user from launching your app.
            // To mark a download as Non-Essential, pass `false` for the `essential` initializer argument.
            let nonEssentialDownload = BAURLDownload(
                identifier: "Unique-Asset-Identifier",
                request: URLRequest(url: assetURL),
                essential: false,
                fileSize: assetSize,
                applicationGroupIdentifier: appGroupIdentifier,
                priority: .default)

            downloadsToSchedule.insert(nonEssentialDownload)
            break;

        @unknown default:
            return Set()
        }

        // The downloads that are returned will be downloaded automatically by the system.
        return downloadsToSchedule
    }

    func backgroundDownload(_ failedDownload: BADownload, failedWithError error: Error) {
        // Extension was woken because a download failed.
        // A download can be rescheduled with BADownloadManager if necessary.
    }

    func backgroundDownload(_ finishedDownload: BADownload, finishedWithFileURL fileURL: URL) {
        // Extension was woken because a download finished.
        // It is strongly advised to keep files in `Library/Caches` so that they may be
        // deleted when the device becomes low on storage.
    }
}
