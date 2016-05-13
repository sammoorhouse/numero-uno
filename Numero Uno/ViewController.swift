
//
//  ViewController.swift
//  Numero Uno
//
//  Created by Sam Moorhouse on 14/12/2015.
//  Copyright © 2015 LittlePlasticSquares. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBAction func buttonZeroPressed(sender: AnyObject) {
        labelInput.text? += "0"
        print (labelInput.text)
    }
    @IBAction func buttonOnePressed(sender: AnyObject) {
        labelInput.text? += "1"
    }
    @IBAction func buttonTwoPressed(sender: AnyObject) {
        labelInput.text? += "2"
    }
    @IBAction func buttonThreePressed(sender: AnyObject) {
        labelInput.text? += "3"
    }
    @IBAction func buttonFourPressed(sender: AnyObject) {
        labelInput.text? += "4"
    }
    @IBAction func buttonFivePressed(sender: AnyObject) {
        labelInput.text? += "5"
    }
    @IBAction func buttonSixPressed(sender: AnyObject) {
        labelInput.text? += "6"
    }
    @IBAction func buttonSevenPressed(sender: AnyObject) {
        labelInput.text? += "7"
    }
    @IBAction func buttonEightPressed(sender: AnyObject) {
        labelInput.text? += "8"
    }
    @IBAction func buttonNinePressed(sender: AnyObject) {
        labelInput.text? += "9"
    }
    @IBAction func buttonReplayPressed(sender: AnyObject) {
        speakNumber(rnd)
    }
    @IBAction func buttonResetPressed(sender: AnyObject) {
        failure()
        initialise()
    }
    @IBAction func buttonConfigPressed(sender: AnyObject) {
    }
    @IBAction func buttonEnterPressed(sender: AnyObject) {
        let res = check()
        if(res){
            success()
        }else{
            failure()
        }
    }
    
    @IBOutlet weak var labelInput: UILabel!
    @IBOutlet weak var labelFailures: UILabel!
    @IBOutlet weak var labelSuccesses: UILabel!
    
    var rnd: Int = 0;
    var successes: Int = 0;
    var failures: Int = 0;
    
    let synth = AVSpeechSynthesizer()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    func success(){
        initialise()
        successes++
        labelSuccesses.text = String(successes)
    }
    
    func failure(){
        resetInput()
        speakNumber(rnd);
        failures++
        labelFailures.text = String(failures)
    }
    
    func initialise(){
        labelInput.text = "";
        labelSuccesses.text = String(successes)
        labelFailures.text = String(failures)
        
        rnd = Int(arc4random_uniform(1000))
        speakNumber(rnd);
        print(rnd)
    }
    
    func resetInput(){
        labelInput.text = "";
    }
    
    func check() -> Bool{
        return labelInput.text! == String(rnd)
    }
    
    func speakNumber(input: Int){
        let myUtterance = AVSpeechUtterance(string: String(input))
        myUtterance.voice = getRandomVoice("es-ES")
        myUtterance.rate = 0.4
        synth.speakUtterance(myUtterance)
    }
    
    func getRandomVoice(language: String) -> AVSpeechSynthesisVoice
    {
        let voices = AVSpeechSynthesisVoice.speechVoices().filter{ $0.language == language}
        let index = Int(arc4random_uniform(UInt32(voices.count)))
        return voices[index]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        successes = defaults.integerForKey(AppDefaults.successes)
        failures = defaults.integerForKey(AppDefaults.failures)
        
        initialise()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        defaults.setValue(successes, forKey: AppDefaults.successes)
        defaults.setValue(failures, forKey: AppDefaults.failures)
        defaults.synchronize()
    }


}

