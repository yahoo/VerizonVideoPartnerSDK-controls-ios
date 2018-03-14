//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation

public class ControlsPresentationController {
    struct Timer { let start, stop: Command }
    public struct Controls {
        let show, hide: Command
        
        public init(show: Command, hide: Command) {
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
        var fire: Command?
        
        let internalTimer = Timer(
            start: Command {
                timer?.cancel()
                timer = PlayerControls.Timer(duration: 3, fire: CommandWith { fire?.perform() })}
        ,
            stop:  Command {
                timer?.cancel()
        })
        
        self.init(controls: controls, timer: internalTimer)
        fire = CommandWith { [weak self] in self?.timerFired() }
        
        
        // At the end. self -> Timer -> OneMobileSDK.Timer -> [weak self]
        // No retain cycle here.
    }
    
    public func tap() { behavior.perform(with: .tap) }
    public func timerFired() { behavior.perform(with: .timerFired) }
    public func play() { behavior.perform(with: .play) }
    public func pause() { behavior.perform(with: .pause) }
    public func resetTimer() { behavior.perform(with: .resetTimer) }
    
    private enum Message {
        case tap, timerFired, play, pause, resetTimer
    }
    
    private var behavior: CommandWith<Message> = CommandWith { fatalError("Unhandled message: \($0)") }
    
    private func start() {
        controls.show.perform()
        behavior = CommandWith { [weak self] in self?.visiblePaused(by: $0) }
    }
    
    private func visiblePaused(by message: Message) {
        switch message {
        case .tap:
            controls.hide.perform()
            behavior = CommandWith { [weak self] in self?.hiddenPaused(by: $0) }
            
        case .play:
            timer.start.perform()
            behavior = CommandWith { [weak self] in self?.visiblePlaying(by: $0) }
            
        case .resetTimer: break
            
        default: fatalError("Unhandled message: \(message)") }
    }
    
    private func hiddenPaused(by message: Message) {
        switch message {
        case .tap:
            controls.show.perform()
            behavior = CommandWith { [weak self] in self?.visiblePaused(by: $0) }
            
        case .play:
            behavior = CommandWith { [weak self] in self?.hiddenPlaying(by: $0) }
        
        case .resetTimer: break
            
        default: fatalError("Unhandled message: \(message)") }
    }
    
    private func visiblePlaying(by message: Message) {
        switch message {
        case .tap:
            timer.stop.perform()
            controls.hide.perform()
            behavior = CommandWith { [weak self] in self?.hiddenPlaying(by: $0) }
            
        case .pause:
            timer.stop.perform()
            behavior = CommandWith { [weak self] in self?.visiblePaused(by: $0) }
            
        case .timerFired:
            controls.hide.perform()
            behavior = CommandWith { [weak self] in self?.hiddenPlaying(by: $0) }
            
        case .resetTimer:
            timer.stop.perform()
            timer.start.perform()
            
        default: fatalError("Unhandled message: \(message)") }
    }
    
    private func hiddenPlaying(by message: Message) {
        switch message {
        case .tap:
            controls.show.perform()
            timer.start.perform()
            behavior = CommandWith { [weak self] in self?.visiblePlaying(by: $0) }
            
        case .pause:
            controls.show.perform()
            behavior = CommandWith { [weak self] in self?.visiblePaused(by: $0) }
            
        case .resetTimer: break
            
        default: fatalError("Unhandled message: \(message)") }
    }
}
