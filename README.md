# loginAnimation

* Login interface for a slow motion animation.<br>
* A lovely Owl which will cover it eyes when you enter your password.

## Usage

![](https://github.com/Moon1102/loginAnimation/raw/master/Demo.gif)<br>  

1.Create a new project.<br>
2.Drag the contents of the "loginAnimation" folder from demo to your project.<br>
3.Add the following code in the AppDelegate.swift.

```Swift
  let loginVC = UIStoryboard(name: "LoginAnimation", bundle: nil).instantiateInitialViewController()
  window?.rootViewController = loginVC
```
