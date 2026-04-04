//
//  Font+Extension.swift
//  Gamepedia
//
//  Created by User on 01/04/26.
//

import SwiftUI

extension Font {

    // MARK: - Custom Fonts

    /// Evil Empire font (Gothic/Horror style)
    static func evilEmpire(size: CGFloat) -> Font {
        return Font.custom("EvilEmpire", size: size)
    }

    /// Vermin Vibes font (Grunge/Alternative style)
    static func verminVibes(size: CGFloat) -> Font {
        return Font.custom("VerminVibes", size: size)
    }

    // MARK: - Predefined Font Styles

    /// Large title using Evil Empire font
    static var evilEmpireLargeTitle: Font {
        return .evilEmpire(size: 34)
    }

    /// Title using Evil Empire font
    static var evilEmpireTitle: Font {
        return .evilEmpire(size: 28)
    }

    /// Title 2 using Evil Empire font
    static var evilEmpireTitle2: Font {
        return .evilEmpire(size: 24)
    }

    /// Title 3 using Evil Empire font
    static var evilEmpireTitle3: Font {
        return .evilEmpire(size: 20)
    }

    /// Headline using Vermin Vibes font
    static var verminVibesHeadline: Font {
        return .verminVibes(size: 18)
    }

    /// Body text using Vermin Vibes font
    static var verminVibesBody: Font {
        return .verminVibes(size: 16)
    }

    /// Callout using Vermin Vibes font
    static var verminVibesCallout: Font {
        return .verminVibes(size: 14)
    }

    /// Caption using Vermin Vibes font
    static var verminVibesCaption: Font {
        return .verminVibes(size: 12)
    }

    // MARK: - Game-Themed Font Combinations

    /// Gaming header font (Evil Empire for dramatic effect)
    static var gameHeader: Font {
        return .evilEmpire(size: 28)
    }

    /// Gaming title font (Evil Empire for titles)
    static var gameTitle: Font {
        return .evilEmpire(size: 22)
    }

    /// Gaming subtitle font (Vermin Vibes for subtitles)
    static var gameSubtitle: Font {
        return .verminVibes(size: 16)
    }

    /// Gaming body font (Vermin Vibes for readable text)
    static var gameBody: Font {
        return .verminVibes(size: 14)
    }

    /// Gaming caption font (Vermin Vibes for small text)
    static var gameCaption: Font {
        return .verminVibes(size: 12)
    }
}
