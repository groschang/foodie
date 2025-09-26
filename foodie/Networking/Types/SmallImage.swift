//
//  SmallImage.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

extension URL {

    static func SmallImage(_ url: URL) -> URL? {
        guard var urlElements = URLComponents(string: url.absoluteString)  else { return nil }

        let path = urlElements.path
        urlElements.path =  String.smallImagePath(path) ?? path

        return urlElements.url
    }

    static func SmallImage(_ url: URL?) -> URL? {
        guard let url else { return nil }

        return SmallImage(url)
    }
}


extension String {
    
    static let smallImageFileExtension = "-Small"
}


extension String {

    static func smallImagePath(_ path: String) -> String? {
        let components = path.components(separatedBy: "/")

        guard let pathComponent = String.smallImageComponents(components) else { return nil }

        return pathComponent.joined(separator: "/")
    }
}


fileprivate extension String {

    static func smallImageComponents(_ pathComponents: [String]) -> [String]? {
        guard let filename = String.smallImageFileName(pathComponents) else { return nil }
        guard let lastIndex = pathComponents.lastIndex else { return nil }

        var components = pathComponents
        components[lastIndex] = filename
        return components
    }

    static func smallImageFileName(_ pathComponents: [String]) -> String? {

        guard let filename = pathComponents.last else { return nil }

        let components = filename.components(separatedBy: ".")
        guard components.count == 2 else { return nil }
        guard let imageName = components.first else { return nil }
        guard let imageType = components.last else { return nil }

        return "\(imageName)\(String.smallImageFileExtension).\(imageType)"
    }
}
