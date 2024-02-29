//
//  AddPostViewController.swift
//  PlatziTweets
//
//  Created by Jozek Hajduk on 26/02/24.
//

import UIKit
import Simple_Networking
import SVProgressHUD
import NotificationBannerSwift
import FirebaseStorage
import AVKit
import MobileCoreServices

class AddPostViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var previewImageView: UIImageView!
    
    // MARK: - IBActions
    @IBAction func addPostAction() {
        // uploadPhotoToFirebase()
        openVideoCamera()
    }
    
    @IBAction func dismissAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openCameraAction() {
        openCamera()
    }
    
    // MARK: - Properties
    private var imagePicker: UIImagePickerController?
    private var currentVideoUrl: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func openVideoCamera() {
        imagePicker = UIImagePickerController()
        imagePicker?.sourceType = .camera
        imagePicker?.mediaTypes = [kUTTypeMovie as String]
        imagePicker?.cameraFlashMode = .off
        imagePicker?.cameraCaptureMode = .video
        imagePicker?.videoQuality = .typeMedium
        imagePicker?.videoMaximumDuration = TimeInterval(5) // Max time of video
        imagePicker?.allowsEditing = true
        imagePicker?.delegate = self
        
        guard let imagePicker = imagePicker else {
            return
        }
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func openCamera() {
        imagePicker = UIImagePickerController()
        imagePicker?.sourceType = .camera
        imagePicker?.cameraFlashMode = .off
        imagePicker?.cameraCaptureMode = .photo
        imagePicker?.allowsEditing = true
        imagePicker?.delegate = self
        
        guard let imagePicker = imagePicker else {
            return
        }
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func uploadPhotoToFirebase() {
        // Validate photo and compress image to convert into data
        guard let imageToSave = previewImageView.image,
              let imageData: Data = imageToSave.jpegData(compressionQuality: 0.1) else {
                  return
              }
        // Show loader
        SVProgressHUD.show()
        // Create config to save photo
        let metaDataConfig = StorageMetadata()
        metaDataConfig.contentType = "image/jpg"
        // Crerate reference to firebase storage
        let storage = Storage.storage()
        // Add name to new image
        let randomName = Int.random(in: 100...10000)
        // Create reference to directory where photo will be saved
        let folderReference = storage.reference(withPath: "tweets_photos/\(randomName).jpg")
        // Upload photo in other thread
        DispatchQueue.global(qos: .background).async {
            folderReference.putData(imageData, metadata: metaDataConfig) { (metadata:StorageMetadata?, error: Error?) in
                // Go back to main thread
                DispatchQueue.main.async {
                    // Stop loader
                    SVProgressHUD.dismiss()
                    // Validate error
                    if let error = error {
                        NotificationBanner(
                            title: "Error",
                            subtitle: error.localizedDescription,
                            style: .warning).show()
                        return
                    }
                    
                    folderReference.downloadURL { (url: URL?, error: Error?) in
                        let downloadUrl = url?.absoluteString ?? ""
                        self.savePost(imageUrl: downloadUrl)
                    }
                }
            }
        }
        
    }
    
    private func savePost(imageUrl image: String) {
        SVProgressHUD.show()
        let newText = postTextView.text ?? ""
//        let request = PostRequest(text: newText, imageUrl: "", videoUrl: "", location: nil)
        // (Endpoint not work)
//        SN.post(endpoint: EndPoints.post) { (response: SNResultWithEntity<Post, ErrorResponse>) in
//            SVProgressHUD.dismiss()
//            
//            switch response {
//            case .success(let post):
//                self.dismissAction()
//            case .error(let error):
//                NotificationBanner(title: "Error",
//                                   subtitle: "There is a problem authenticated user: \(error.localizedDescription)",
//                                   style: .danger).show()
//                return
//            case .errorResult(let entity):
//                NotificationBanner(title: "Error",
//                                   subtitle: "There is a problem with server: \(entity)",
//                                   style: .warning).show()
//                return
//            }
//        }
        let newPost = Post(id: "0", author: Constants.user, imageUrl: image, text: newText, videoUrl: "", location: Constants.postLocation, hasVideo: false, hasImage: false, hasLocation: false, createdAt: "")
        Constants.postsDataSource.insert(newPost, at: 0)
        dismissAction()
        SVProgressHUD.dismiss()
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Close camera
        self.imagePicker?.dismiss(animated: true, completion: nil)
        
        // Validate camera return image data
        if info.keys.contains(.originalImage) {
            self.previewImageView.isHidden = false
            // Get image from camera
            self.previewImageView.image = info[.originalImage] as? UIImage
        }
        
        // Validate video return video data
        if info.keys.contains(.mediaURL), let recordedVideoURL = (info[.mediaURL] as? URL)?.absoluteURL {
            let avPlayer = AVPlayer(url: recordedVideoURL)
            let avPlayerController = AVPlayerViewController() // Show new window with video
            avPlayerController.player = avPlayer
            
            present(avPlayerController, animated: true) {
                avPlayerController.player?.play() // Start video
            }
        }
    }
}
