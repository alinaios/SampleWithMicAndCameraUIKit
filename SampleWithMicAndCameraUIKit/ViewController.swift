//
//  ViewController.swift
//  SampleWithMicAndCameraUIKit
//
//  Created by A H on 2023-04-17.
//

import UIKit
import AVKit

final class ViewController: UIViewController {
    @IBOutlet private var infoLabel: UILabel!
    @IBOutlet private var micInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detectCameraPermission()
        detectMicPermission()
    }
    
    
    @IBAction private func goToSettings(_ sender: Any) {
        UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
    
    private func detectCameraPermission(){
        if AVCaptureDevice.authorizationStatus(for: .video) == AVAuthorizationStatus.authorized {
            infoLabel.text = "Camera access granted"
        } else {
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    self?.infoLabel.text = granted ? "Camera access granted" : "Camera access rejected"
                }
            }
        }
    }
    
    private func detectMicPermission() {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            self.micInfoLabel.text = "Mic access granted"
        case .denied:
            self.micInfoLabel.text = "Mic access rejected"
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { [weak self] granted in
                DispatchQueue.main.async {
                    self?.micInfoLabel.text = granted ? "Mic access granted" : "Mic access rejected"
                }
            }
        @unknown default:
            micInfoLabel.text = "Unknown case"
        }
    }
}
