//  Copyright © 2016 One by Aol : Publishers. All rights reserved.

import Foundation

public class ControlsPresentationController {
    struct Timer { let start, stop: Action<Void> }
    public struct Controls {
        let show, hide: Action<Void>
        
        public init(show: @escaping Action<Void>, hide: @escaping Action<Void>) {
            self.show = show
            self.hide = hide
        }
    }
    
    let controls: Controls, timer: Timer
    init(controls: Controls, timer: Timer) {
        self.controls = controls
        self.timer = timer
        
        start()
    }
    
    public convenience init(controls: Controls) {
        var timer: PlayerControls.Timer?
        
        /// We need this indirection to allow swift avoid
        // circullar dependency between timer and controller.
        var fire: (() -> ())?
        
        let internalTimer = Timer(
            start: {
                timer?.cancel()
                timer = PlayerControls.Timer(duration: 3) { fire?() }
        },
            stop: {
                timer?.cancel()
        })
        
        
        self.init(controls: controls, timer: internalTimer)
        
        fire = { [weak self] in self?.timerFired() }
        
        // At the end. self -> Timer -> OneMobileSDK.Timer -> [weak self]
        // No retain cycle here.
    }
    
    public func tap() { behavior(.tap) }
    public func timerFired() { behavior(.timerFired) }
    public func play() { behavior(.play) }
    public func pause() { behavior(.pause) }
    public func resetTimer() { behavior(.resetTimer) }
    
    private enum Message {
        case tap, timerFired, play, pause, resetTimer
    }
    
    private var behavior: Action<Message> = { fatalError("Unhandled message: \($0)") }
    
    private func start() {
        controls.show()
        behavior = { [weak self] in self?.visiblePaused(by: $0) }
    }
    
    private func visiblePaused(by message: Message) {
        switch message {
        case .tap:
            controls.hide()
            behavior = { [weak self] in self?.hiddenPaused(by: $0) }
            
        case .play:
            timer.start()
            behavior = { [weak self] in self?.visiblePlaying(by: $0) }
            
        case .resetTimer: break
            
        default: fatalError("Unhandled message: \(message)") }
    }
    
    private func hiddenPaused(by message: Message) {
        switch message {
        case .tap:
            controls.show()
            behavior = { [weak self] in self?.visiblePaused(by: $0) } 
            
        case .play:
            behavior = { [weak self] in self?.hiddenPlaying(by: $0) }
            
        default: fatalError("Unhandled message: \(message)") }
    }
    
    private func visiblePlaying(by message: Message) {
        switch message {
        case .tap:
            timer.stop()
            controls.hide()
            behavior = { [weak self] in self?.hiddenPlaying(by: $0) }
            
        case .pause:
            timer.stop()
            behavior = { [weak self] in self?.visiblePaused(by: $0) }
            
        case .timerFired:
            controls.hide()
            behavior = { [weak self] in self?.hiddenPlaying(by: $0) }
            
        case .resetTimer:
            timer.stop()
            timer.start()
            
        default: fatalError("Unhandled message: \(message)") }
    }
    
    private func hiddenPlaying(by message: Message) {
        switch message {
        case .tap:
            controls.show()
            timer.start()
            behavior = { [weak self] in self?.visiblePlaying(by: $0) }
            
        case .pause:
            controls.show()
            behavior = { [weak self] in self?.visiblePaused(by: $0) }
            
        case .resetTimer: break
            
        default: fatalError("Unhandled message: \(message)") }
    }
}
