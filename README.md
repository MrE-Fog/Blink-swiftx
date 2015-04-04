# Blink-swift

Blink-swift is simple application for communication between iOS devices and Intel Edison. It is better to start with Intel Edison [simple application](https://github.com/snyuryev/Blink-edison) for Node.js. After uploading [this application](https://github.com/snyuryev/Blink-edison) to your Intel Edison you will be able to control onboard led from your iOS device.

Building process is simple. At first go to ViewController.swift and specify Intel Edison board name. In my case it is "salty.local". Both devices should be in same wifi network. 

```swift
let kStatusURLString : String = "http://salty.local:8888/status"
let kLightURLString : String = "http://salty.local:8888/light"
```

Here are a few screenshots from working application. It show current state of led (on or off states are displayed with corresponding colors of the background and the bulb). Tap the bulb to switch led state.

![Lights on](https://raw.githubusercontent.com/snyuryev/Blink-swift/master/light-on.jpg)

![Lights off](https://raw.githubusercontent.com/snyuryev/Blink-swift/master/light-off.jpg)

