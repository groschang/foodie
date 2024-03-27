//
//  YouTubeView.swift
//  foodie
//
//  Created by Konrad Groschang on 10/02/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI
import WebKit

struct YouTubeView: UIViewRepresentable {

    let videoId: String

    init(videoId: String) {
        self.videoId = videoId
    }

    init?(url: URL) {
        guard let videoId = url.absoluteString.extractYoutubeID() else { return nil }

        self.videoId = videoId
    }

    init?(urlString: String) {
        guard let videoId = urlString.extractYoutubeID() else { return nil }

        self.videoId = videoId
    }

    func makeUIView(context: Context) ->  WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let demoURL = URL(string: "https://www.youtube.com/embed/\(videoId)") else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: demoURL))
    }
}



extension String {

    func extractYoutubeID() -> String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"

        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: self.count)

        guard let result = regex?.firstMatch(in: self, range: range) else { return nil }
        return (self as NSString).substring(with: result.range)
    }

}
