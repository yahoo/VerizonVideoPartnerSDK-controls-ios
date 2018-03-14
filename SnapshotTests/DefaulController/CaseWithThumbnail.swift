//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import SnappyShrimp
@testable import PlayerControls

class CaseWithThumbnail: SnapshotTest{
    
    var controller: DefaultControlsViewController {
        let controller = DefaultControlsViewController()
        controller.view.backgroundColor = .red
        controller.view.tintColor = .blue
        
        controller.props = DefaultControlsViewController.Props.player(
            DefaultControlsViewController.Props.Player { player in
                player.playlist = DefaultControlsViewController.Props.Playlist()
                player.playlist?.next = .nop
                player.item = DefaultControlsViewController.Props.Item.playable(
                    ContentControlsViewController.Props.Controls { controls in
                        
                        controls.title = "SOME TITLE"
                        controls.seekbar = .init()
                        controls.seekbar?.seeker.state.stop = .nop
                        
                        controls.live.isHidden = false
                        controls.live.dotColor = Color(#colorLiteral(red: 0.6609608521, green: 1, blue: 0.4075785412, alpha: 1))
                        controls.sideBarViewHidden = false
                        controls.playbackAction = .none
                        
                        controls.camera = nil
                        controls.loading = true
                        
                        controls.settings = .hidden
                        controls.pictureInPictureControl = .unsupported
                        controls.airplay = .hidden
                        
                        controls.legible = .`internal`(nil)
                        controls.thumbnail = DefaultControlsViewController.Props.Thumbnail.image(UIImage(named: "thumbnail", in: Bundle(for: CaseWithThumbnail.self), compatibleWith: nil)!)
                })
        })
        return controller
    }
    
    func test() {
        if #available(iOS 11.0, *) {
            verify(controller, for: Device.iPhoneX.portrait)
            verify(controller, for: Device.iPhoneX.landscapeLeft)
            verify(controller, for: Device.iPhoneX.landscapeRight)
            
            verify(controller, for: Device.iPhone8.portrait)
            
            verify(controller, for: Device.iPhone8Plus.landscape)
        }
        verify(controller, for: Device.iPhoneSE.portrait)
        
        if #available(iOS 10.0, *) {
            verify(controller, for: Device.iPadPro9.portrait.fullScreen)
            verify(controller, for: Device.iPadPro9.portrait.oneThird)
            verify(controller, for: Device.iPadPro9.landscape.twoThird)
            
            verify(controller, for: Device.iPadPro10.portrait.twoThirds)
            verify(controller, for: Device.iPadPro10.landscape.oneThird)
        }
        verify(controller, for: Device.iPadPro12.portrait.oneThird)
        verify(controller, for: Device.iPadPro12.landscape.fullScreen)
    }
}
