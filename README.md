## WYCommonImageManager
encrypt image resource in iOS Project with change code.

Based on [RNCryptor](https://github.com/RNCryptor/RNCryptor) and [CXYRNCryptorTool](https://github.com/iHongRen/CXYRNCryptorTool)

1. Run CXYRNCryptor.app in Project directory and click + button to add images, and then encrypt.
2. create new folder , rename as Target.bundle or other name you like.
3. add files in steps 1 into Target.bundle.
4. add bundle into yout project.
5. import `CommonImageManager.h` in `appDelegate`
6. in `- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions`, add
`[[CommonImageManager sharedInstance] configureBundlesName:@[@"Target", @"Other Name you Like"]];`
