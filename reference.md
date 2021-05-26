#Visual Studio Code 
Directories for settings, from https://stackoverflow.com/questions/35368889/how-to-export-settings

> With the current version of Visual Studio Code as of this writing (1.22.1), you can find your settings in
> 
> ~/.config/Code/User on Linux (in my case, an, Ubuntu derivative)
> C:\Users\username\AppData\Roaming\Code\User on Windows 10
> ~/Library/Application Support/Code/User/ on Mac OS X (thank you, Christophe De Troyer)
> The files are settings.json and keybindings.json. Simply copy them to the target machine.
> 
> Your extensions are in
> 
> ~/.vscode/extensions on Linux and Mac OS X
> C:\Users\username\.vscode\extensions on Windows 10 (e.g., essentially the same place)
> Alternately, just go to the Extensions, show installed extensions, and install those on your target installation. For me, copying the extensions worked just fine, but it may be extension-specific, particularly if moving between platforms, depending on what the extension does.

---

Caps Lock
 Caps Lock escape behaviour https://www.dannyguo.com/blog/remap-caps-lock-to-escape-and-control/
Manually invoke with command: `xcape -e 'Control_L=Escape'`
Add `xcape` to .bash_rc to initialize it automatically
