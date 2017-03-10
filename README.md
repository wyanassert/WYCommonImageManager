## WYCommonImageManager
encrypt image resource in iOS Project without change source code.

Based on [RNCryptor](https://github.com/RNCryptor/RNCryptor) and [CXYRNCryptorTool](https://github.com/iHongRen/CXYRNCryptorTool)

1. Run CXYRNCryptor.app in Project directory and click + button to add images, and then encrypt.
2. choose save directory and encrypt data, including xxxx.cxy files and a plist named with current date.
3. the plist in step 2 descibe which picture was transformed to which encrypted file.
2. create new folder , rename as Target.bundle or other name you like.
3. add encrypted files in steps 2 into Target.bundle.
4. add bundle into yout project.
5. import `CommonImageManager.h` in `appDelegate.h`.
6. in

  `- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions`,

  add  
`[[CommonImageManager sharedInstance] configureBundlesName:@[@"Target", @"Other Name you Like"]];`

7. run demo to see how to work in iOS project.
