# loginAnimation

*Login interface for a slow motion animation.
*A lovely Owl which will cover it eyes when you enter your password.

## Usage

1.Create a new project.
2.Drag the contents of the "loginAnimation" folder from demo to your project.
3.Add the following code in the AppDelegate.swift.

```Swift
  let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()
  window?.rootViewController = loginVC
```
