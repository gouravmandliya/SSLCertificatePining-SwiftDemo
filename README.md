# SSLPinningDemo

A basic Swift demo app showing how to implement SSL Pinning using URLSession and certificate comparison.

## Instructions

1. Export `.cer` file from server (DER format)
2. Add it to `Resources/yourserver.com.cer`
3. Replace the request URL in `ViewController.swift`
4. Run the app and observe console output for pin validation
