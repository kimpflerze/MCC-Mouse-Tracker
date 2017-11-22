//
//  QRScannerViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 10/30/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

//

import UIKit
import AVFoundation

class QRScannerController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    //Labels and buttons
    @IBOutlet var messageLabel:UILabel!
    @IBOutlet weak var cancelScanningButton: UIButton!
    @IBOutlet weak var confirmCodeButton: UIButton!
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    var lastSuccessfullyScannedCodeResult: String?
    
    var delegate: QRScannerControllerDelegate?
    
    let supportedCodeTypes = [AVMetadataObjectTypeQRCode]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelScanningButton.layer.cornerRadius = 10
        cancelScanningButton.layer.masksToBounds = true
        
        confirmCodeButton.layer.cornerRadius = 10
        confirmCodeButton.layer.masksToBounds = true
        
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession?.startRunning()
            
            // Move the message label and top bar to the front
            view.bringSubview(toFront: messageLabel)
            view.bringSubview(toFront: cancelScanningButton)
            view.bringSubview(toFront: confirmCodeButton)
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print("Error with QR Scanner")
            print(error)
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate Methods
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            messageLabel.text = "No QR code detected!"
            return
        }
        
        // Get the metadata object.
        for object in metadataObjects {
            guard let metadataObj = object as? AVMetadataMachineReadableCodeObject else {
                return
            }
            if supportedCodeTypes.contains(metadataObj.type) {
                // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
                let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
                qrCodeFrameView?.frame = barCodeObject!.bounds
                
                if metadataObj.stringValue != nil {
                    messageLabel.text = metadataObj.stringValue
                    lastSuccessfullyScannedCodeResult = metadataObj.stringValue
                }
            }
        }
        
    }
    
    @IBAction func cancelScanningButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmCodeButtonPressed(_ sender: UIButton) {
        guard let qrValue = lastSuccessfullyScannedCodeResult else {
            return
        }
        delegate?.qrScannerController(controller: self, didScanQRCodeWith: qrValue)
    }
    
    
}

protocol QRScannerControllerDelegate {
    func qrScannerController(controller: QRScannerController, didScanQRCodeWith value: String)
}
