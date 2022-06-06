# get server ssh fingerprint
ssh-keygen -l -f <(ssh-keyscan localhost)

# create symbolic link
ln -s target_file link_name

# Copy symbolic links without traversing it http://unix.stackexchange.com/questions/56084/ddg#56170
cp -P ___

### File Navigation

# for loop directory files, https://stackoverflow.com/questions/8512462/looping-through-all-files-in-a-directory
for filename in *; do echo "put ${filename}"; done
for filename in *; do ; done


### Video

# ffmpeg .m3u8 downloading, https://stackoverflow.com/questions/47233304/how-to-download-m3u8-in-once-time
ffmpeg -i "http://example.com/chunklist.m3u8" -codec copy file.mp4
ffmpeg -i '' -codec copy

### Reference:

### External Harddrive encryption
# https://theawesomegarage.com/blog/encrypt-external-hard-drives-with-linux

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

---

Caps Lock
 Caps Lock escape behaviour https://www.dannyguo.com/blog/remap-caps-lock-to-escape-and-control/
Manually invoke with command: `xcape -e 'Control_L=Escape'`
Add `xcape` to .bash_rc to initialize it automatically

---

Ubunutu laptop lid handling sleep suspend
https://ubuntuhandbook.org/index.php/2020/05/lid-close-behavior-ubuntu-20-04/
1.) Open terminal (press Ctrl+Alt+T on Gnome) from your system application menu. When it opens, run command:

sudo gedit /etc/systemd/logind.conf

Type user password (no asterisk feedback) and hit Enter. For Ubuntu server without UI, use nano text editor instead.

2.) When the file opens, find out the line #HandleLidSwitch=suspend and change it to one of following :

    HandleLidSwitch=lock – lock when lid closed.
    HandleLidSwitch=ignore – do nothing.
    HandleLidSwitch=poweroff – shutdown.
    HandleLidSwitch=hibernate – hibernate Ubuntu.

For automatic hibernate, you have to test if it works properly via command:

sudo systemctl hibernate

3.) Finally apply changes by running command:
(Save your works before running the command, it may restart your session)

systemctl restart systemd-logind.service

Note you have to do previous steps every time you want to change the action. And ‘Suspend when laptop lid is closed‘ option in Gnome Tweaks will no longer work before you comment (add # at the beginning) the line in /etc/systemd/logind.conf.
