//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Carlos Eduardo Angulo Ustarez on 4/3/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!

    @IBOutlet weak var recordinginProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
      //Hide the stop button
        stopButton.hidden = true;
        recordButton.enabled = true;
        recordinginProgress.hidden = false
        recordinginProgress.text = "Tap to Record"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        stopButton.hidden = false;
        recordinginProgress.text = "Recording in Progress"
        recordButton.enabled = false
        //TODO Record the user's voice
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        recordedAudio = RecordedAudio(vurl: recorder.url, vtitle: recorder.url.lastPathComponent)
        if(flag) {
            //TODO save to the record audio
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
            //Move to the next scene
        }else {
          println("Recording was not succesfully")
            recordButton.enabled = true
            stopButton.hidden = true
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
    if(segue.identifier == "stopRecording")
    {
        let playSoundVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
        let data = sender as! RecordedAudio
        playSoundVC.receivedAudio = data
    }
    }

    @IBAction func stopAudio(sender: UIButton) {
        recordinginProgress.hidden = true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}

