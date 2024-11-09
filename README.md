# Flutter Chat UI v2 🚀

Welcome to the next generation of Flutter Chat UI! ✨

> 🔨 **Version 2 is currently under development**  
> Available as a [dev release on pub.dev](https://pub.dev/packages/flutter_chat_ui/versions/2.0.0-dev.1/changelog)

📝 Documentation is actively being written and will be continuously updated here and on Github.

💡 **Looking for the stable version?**  
The v1 release is available on the [v1 branch](https://github.com/flyerhq/flutter_chat_ui/tree/v1).

## Platform-Specific Configuration for Audio Recording

To enable audio recording functionality, you need to configure permissions for both Android and iOS platforms.

### Android

1. **Add Permissions to `AndroidManifest.xml`:**

   Add the following permissions to your `AndroidManifest.xml` file to allow microphone access and file writing:

   ```xml
   <uses-permission android:name="android.permission.RECORD_AUDIO"/>
   <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
   <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
   ```

2. **Add Queries for Android 11 and above:**

   If your app targets Android 11 (API level 30) or higher, add the following queries to allow access to certain actions:

   ```xml
   <queries>
       <intent>
           <action android:name="android.intent.action.PROCESS_TEXT"/>
           <data android:mimeType="text/plain"/>
       </intent>
   </queries>
   ```

### iOS

1. **Add Permissions to `Info.plist`:**

   Add the following keys to your `Info.plist` file to request microphone access:

   ```xml
   <key>NSMicrophoneUsageDescription</key>
   <string>This app requires access to the microphone to record audio.</string>
   <key>NSPhotoLibraryAddUsageDescription</key>
   <string>This app requires access to save audio files.</string>
   ```

By following these steps, you can ensure that your app has the necessary permissions to record audio on both Android and iOS platforms.
