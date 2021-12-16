import Foundation

public extension VAST.Element {
    /// Each `<Tracking>` element is used to define a single event to be tracked. Multiple tracking elements may be
    /// used to define multiple events to be tracked, but may also be used to track events of the same type for
    /// multiple parties.
    ///
    /// When using the progress event, an `offset` attribute for linear ads can be used to notify the ad server when
    /// the ad's progress has reached the identified percentage or time value indicated. When percentages are used,
    /// the progress event can offer tracking that represent the quartile events (`firstQuartile`, `midpoint`,
    /// `thirdQuartile`, and `complete`).
    ///
    /// When skippable ads are supported, the progress event is used to identify when the ad counts as a view even
    /// if the ad is skipped. For example, if the tracking `offset` is set to 00:00:15 (15 seconds) but the ad is
    /// skipped after 20 seconds, then a `creativeView` event may be recorded for the Linear creative.
    ///
    /// If adType is “audio” or “hybrid”, progress events should be fired even if the media playback is in the
    /// background.
    ///
    /// The `offset` attribute is only available for the `<Tracking>` element under `<Linear>`.
    struct Tracking {
        /// A URI to the tracking resource for the event specified using the event attribute.
        public let content: URL
        /// A string that defines the event being tracked.
        public let event: Event
        /// Only available when `<Linear>` is the parent. Accepts values of time in the format `HH:MM:SS` or as a
        /// percentage in the format `n%`. When the progress of the Linear creative has matched the value specified, the
        /// included URI is triggered. If the duration is not known when the offset is set to a percentage value, the
        /// progress event may be ignored.
        public let offset: String?

        public init(content: URL, event: Event, offset: String?) {
            self.content = content
            self.event = event
            self.offset = offset
        }
    }
}

public extension VAST.Element.Tracking {
    /// The following list of metrics is derived from the IAB Digital Video In-Stream Ad Metric Definitions where more
    /// detailed metric definitions can be found.
    enum Event: RawRepresentable {
        // MARK: - Player Operation Metrics (for use in Linear and NonLinear Ads)

        /// The user activated the mute control and muted the creative.
        case mute
        /// The user activated the mute control and unmuted the creative.
        case unmute
        /// The user clicked the pause control and stopped the creative.
        case pause
        /// The user activated the resume control after the creative had been stopped or paused.
        case resume
        /// The user activated the rewind control to access a previous point in the creative timeline.
        case rewind
        /// The user activated a skip control to skip the creative.
        case skip
        /// The user activated a control to extend the player to a larger size. This event replaces the fullscreen event
        /// per the 2014 Digital Video In-Stream Ad Metric Definitions.
        case playerExpand
        /// The user activated a control to reduce player to a smaller size. This event replaces the exitFullscreen
        /// event per the 2014 Digital Video In-Stream Ad Metric Definitions.
        case playerCollapse
        /// This ad was not and will not be played (e.g. it was prefetched for a particular ad break but was not chosen
        /// for playback). This allows ad servers to reuse an ad earlier than otherwise would be possible due to
        /// budget/frequency capping. This is a terminal event; no other tracking events should be sent when this is
        /// used. Player support is optional and if implemented is provided on a best effort basis as it is not
        /// technically possible to fire this event for every unused ad (e.g. when the player itself is terminated
        /// before playback).
        case notUsed

        // MARK: - Linear Ad Metrics

        /// This event should be used to indicate when the player considers that it has loaded and buffered the
        /// creative’s media and assets either fully or to the extent that it is ready to play the media
        case loaded
        /// This event is used to indicate that an individual creative within the ad was loaded and playback began. As
        /// with creativeView, this event is another way of tracking creative playback. Macros defined to describe
        /// auto-play and muted states.
        case start
        /// The creative played continuously for at least 25% of the total duration at normal speed.
        case firstQuartile
        /// The creative played continuously for at least 50% of the total duration at normal speed.
        case midpoint
        /// The creative played continuously for at least 75% of the duration at normal speed.
        case thirdQuartile
        /// The creative was played to the end at normal speed so that 100% of the creative was played.
        case complete
        /// An optional metric that can capture all other user interactions under one metric such a s hover-overs, or
        /// custom clicks. It should NOT replace clickthrough events or other existing events like mute, unmute, pause,
        /// etc.
        case otherAdInteraction
        /// The creative played for a duration at normal speed that is equal to or greater than the value provided in an
        /// additional `offset` attribute for the `<Tracking>` element under Linear ads. Values can be time in the
        /// format `HH:MM:SS` or `HH:MM:SS.mmm` or a percentage value in the format `n%`. Multiple progress events with
        /// different values can be used to track multiple progress points in the linear creative timeline. This event
        /// can be used in addition to, or instead of, the “quartile” events (`firstQuartile`, `midpoint`,
        /// `thirdQuartile`, `complete`). The additional `<Tracking>` `offset` value can be used to help track a view
        /// when an agreed upon duration or percentage of the ad has played.
        case progress
        /// The viewer has chosen to close the linear ad unit. This is currently in use by some of the largest mobile
        /// SDKs to mark the dismissal of the end card companion that follows the video, as well as a close of the video
        /// itself, if applicable.
        case closeLinear

        // MARK: - NonLinear Ad Metrics

        /// Not to be confused with an impression, this event indicates that an individual creative portion of the ad
        /// was viewed. An impression indicates that at least a portion of the ad was displayed; however an ad may be
        /// composed of multiple creative, or creative that only play on some platforms and not others. This event
        /// enables ad servers to track which ad creative are viewed, and therefore, which platforms are more common.
        case creativeView
        /// The user clicked or otherwise activated a control used to pause streaming content, which either expands the
        /// ad within the player’s viewable area or “takes-over” the streaming content area by launching an additional
        /// portion of the ad. An ad in video format ad is usually played upon acceptance, but other forms of media such
        /// as games, animation, tutorials, social media, or other engaging media are also used.
        case acceptInvitation
        /// The user activated a control to expand the creative.
        case adExpand
        /// The user activated a control to reduce the creative to its original dimensions.
        case adCollapse
        /// The user clicked or otherwise activated a control used to minimize the ad to a size smaller than a collapsed
        /// ad but without fully dispatching the ad from the player environment. Unlike a collapsed ad that is big
        /// enough to display it’s message, the minimized ad is only big enough to offer a control that enables the user
        /// to redisplay the ad if desired.
        case minimize
        /// The user clicked or otherwise activated a control for removing the ad, which fully dispatches the ad from
        /// the player environment in a manner that does not allow the user to re-display the ad.
        case close
        /// The time that the initial ad is displayed. This time is based on the time between the impression and either
        /// the completed length of display based on the agreement between transactional parties or a close, minimize,
        /// or accept invitation event.
        case overlayViewDuration

        // MARK: - Interactive Ad Metric

        /// With VAST 4, video playback and interactive creative playback now happens in parallel. Video playback and
        /// interactive creative start may not happen at the same time. A separate way of tracking the interactive
        /// creative start is needed. The interactive creative specification (SIMID, etc.) will define when this event
        /// should be fired.
        case interactiveStart

        // MARK: - Fallback For Unknown Event

        /// The event type is unknown in the current version of the framework.
        case unknown(String)

        public var rawValue: String {
            switch self {
            case .mute: return "mute"
            case .unmute: return "unmute"
            case .pause: return "pause"
            case .resume: return "resume"
            case .rewind: return "rewind"
            case .skip: return "skip"
            case .playerExpand: return "playerExpand"
            case .playerCollapse: return "playerCollapse"
            case .notUsed: return "notUsed"
            case .loaded: return "loaded"
            case .start: return "start"
            case .firstQuartile: return "firstQuartile"
            case .midpoint: return "midpoint"
            case .thirdQuartile: return "thirdQuartile"
            case .complete: return "complete"
            case .otherAdInteraction: return "otherAdInteraction"
            case .progress: return "progress"
            case .closeLinear: return "closeLinear"
            case .creativeView: return "creativeView"
            case .acceptInvitation: return "acceptInvitation"
            case .adExpand: return "adExpand"
            case .adCollapse: return "adCollapse"
            case .minimize: return "minimize"
            case .close: return "close"
            case .overlayViewDuration: return "overlayViewDuration"
            case .interactiveStart: return "interactiveStart"
            case .unknown(let string): return string
            }
        }

        public init(rawValue: String) {
            switch rawValue {
            case "mute": self = .mute
            case "unmute": self = .unmute
            case "pause": self = .pause
            case "resume": self = .resume
            case "rewind": self = .rewind
            case "skip": self = .skip
            case "playerExpand": self = .playerExpand
            case "playerCollapse": self = .playerCollapse
            case "notUsed": self = .notUsed
            case "loaded": self = .loaded
            case "start": self = .start
            case "firstQuartile": self = .firstQuartile
            case "midpoint": self = .midpoint
            case "thirdQuartile": self = .thirdQuartile
            case "complete": self = .complete
            case "otherAdInteraction": self = .otherAdInteraction
            case "progress": self = .progress
            case "closeLinear": self = .closeLinear
            case "creativeView": self = .creativeView
            case "acceptInvitation": self = .acceptInvitation
            case "adExpand": self = .adExpand
            case "adCollapse": self = .adCollapse
            case "minimize": self = .minimize
            case "close": self = .close
            case "overlayViewDuration": self = .overlayViewDuration
            case "interactiveStart": self = .interactiveStart
            default: self = .unknown(rawValue)
            }
        }
    }
}
