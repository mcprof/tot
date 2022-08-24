# Compare directories to see differences. Run twice with target and source reversing. https://unix.stackexchange.com/questions/57305/rsync-compare-directories
rsync -avun --delete $TARGET $SOURCE  |grep "^deleting "

# standard rsync options
rsync -auPvh

# wget
wget --content-disposition -w 60 --random-wait --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36" --execute robots=off

# combining video and audio files in ffmpeg https://davidwalsh.name/combine-audio-video
ffmpeg -i video.mp4 -i audio.m4a -c:v copy -c:a copy output.mp4

# downloading .m3u8 with ffmpeg https://www.leawo.org/entips/use-ffmpeg-to-download-m3u8-file-1395.html
ffmpeg -i "http://example.com/video_url.m3u8" -c copy -bsf:a aac_adtstoasc "output.mp4" 

# find lines that match in text https://stackoverflow.com/questions/30800963/how-to-search-for-a-text-in-specific-files-in-unix#30801017
find -type f -name "*.ht*" -exec grep '.png' {} + > pnglist.txt

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

# Merging video and audio https://superuser.com/questions/277642/how-to-merge-audio-and-video-file-in-ffmpeg
ffmpeg -i video.mp4 -i audio.wav -c copy output.mkv

### Reference:

### External Harddrive encryption
# https://theawesomegarage.com/blog/encrypt-external-hard-drives-with-linux
# Encrypt external hard drives with Linux
# 19th Dec 2019 luks raspberry dm-crypt
#
# Have you ever attached an external hard drive to a Linux server or a Raspberry Pi? An external drive comes in handy to expand storage capacity, but they are also very easy to steal or otherwise become lost. The very first thing you should do when attaching an external hard drive, is to encrypt it!
#
# This tutorial will teach you how to very easily encrypt your external hard drive with Linux, more specifically with a Raspberry Pi. Encryption will impact performance at a varying degree. If you are on a modern desktop/laptop/mobile CPU, you'll have hardware assisted cryptography and see little to no performance degradation. Some say there is a 1% degradation. Raspberries up to and including version 4 don't have HW assisted cryptography. Thus, you'll have a notable performance hit. Some say 30% on disk read/write. In my particular case, the cryptography doesn't lower the perceived system performance as the network is the real bottleneck.
#
# Another thing to be aware of is that the drive you encrypt will be wiped completely in the process. Or at least the partition you wish to encrypt. The tutorial will assume you wipe and encrypt the entire disk, but if you know your way around disk tools you can adapt the tutorial to work on a specific partition.
#
# First, find your disk! Attach the disk to your system and run:
#
# sudo fdisk -l
#
# Look for /dev/sda, /dev/sdb, or something similar. The tutorial assumes /dev/sda, but BEWARE (!), sda is normally the first drive to be detected by your system. In your case, it might not be /dev/sda you wish to wipe!
#
# If you have data stored on the hard drive to begin with, and if the drive is a traditional spindle drive, shred it first. For a 2TB disk, expect even the simplest form of shredding to last 8-12 hours depending on your hardware.
#
# sudo shred -v -n 1 /dev/sda
#
# This is a basic shredding method that won't hinder FSB or CIA to gain access to the previously stored content. If you swap out the number 1 with 7, even the aforementioned agencies will start having problems rebuilding your previous information, as you rewrite the entire disk 7 times with random data. It will however take 7 times longer to shred the drive, too.
#
# With a fresh drive, wipe existing partitions and start over with a single new primary partition:
#
# sudo fdisk /dev/sda
#
# Within the fdisk tool, you'll be asked a few questions; here are the answers I suggest for the process: Press d + enter to delete existing partitions Press n + enter to create new partition Press enter to select p (default) to create a new primary partition Press enter to acknowledge the default partition number Press enter to acknowledge the default starting sector Press enter to acknowledge the default last sector If asked, answer yes to remove signatures. In the end, press w + enter to write your changes. You will now automatically exit the fidsk tool.
#
# Now run:
#
# sudo mkfs.ext4 /dev/sda1
#
# Take a note of your UUID, as you'll use it for mounting the encrypted volume later on. You can use blkid to find it:
#
# sudo blkid
#
# If you haven't already, install the crypto tool. Run modprobe in the end to load the needed modules without a reboot.
#
# sudo apt-get install cryptsetup
# sudo modprobe dm-crypt sha256 aes
#
# Now, set up your encrypted volume. You'll be asked to enter a passphrase. WRITE IT DOWN somewhere secure. You'll need the passphrase to gain access to your encrypted data and to configure your encrypted volume later on!
#
# sudo cryptsetup --verify-passphrase luksFormat /dev/sda1 -c aes -s 256 -h sha256
# sudo cryptsetup luksOpen /dev/sda1 NameOfYourChoice
#
# This will create a mapper that identifies your encrypted volume (really a dm-crypt target); it will be named "NameOfYourChoice".
#
# Now, select a file system for your encrypted volume. I've opted for ext4:
#
# sudo mkfs -t ext4 -m 1 /dev/mapper/NameOfYourChoice
#
# This will take a minute or so.
#
# Now, create a mount point and try mounting and unmounting (really, make sure to test unmounting to avoid silent mount errors!):
#
# sudo mkdir /media/NameOfYourChoice
# sudo mount /dev/mapper/NameOfYourChoice /media/NameOfYourChoice
# sudo umount /media/NameOfYourChoice
#
# You should receive no errors in this process. Note, the mounted device will only be available to root, unless you chown the media mount point. If you need to give access to other users, for instance the default pi user on your Raspberry Pi:
#
# sudo chown pi:pi /media/NameOfYourChoice/
#
# If you run a headless server, you would like your encrypted volume to automount on boot. In this case you need to create a key file that can unlock your volume automatically.
#
# sudo dd if=/dev/urandom of=/root/my-keyfile bs=1024 count=4
# sudo chmod 400 /root/my-keyfile
#
# Add the key file to encrypted partition:
#
# sudo cryptsetup luksAddKey /dev/sda1 /root/my-keyfile
#
# Now, tell the system that you have an encrypted volume, how to find it and how to open the secure volume with a key file:
#
# sudo vi /etc/crypttab
# NameOfYourChoice    UUID=81dc5f18-ce89-4c0d-b9d3-c0123789144a   /root/my-keyfile    luks
#
# Note 1. Use the previously identified UUID in the crypttab. Do NOT use the mapper UUID. Use the partition (sda1) UUID. Note 2. If you don't want to automount the encrypted volume, replace /root/my-keyfile with the keyword none. You'll be prompted for the passphrase upon boot. This is NOT a good idea for headless servers.
#
# When the crypttab is to your liking, tell the system to mount the encrypted volume to a mount point on boot with fstab:
#
# sudo vi /etc/fstab
# /dev/mapper/NameOfYourChoice    /media/NameOfYourChoice ext4    defaults,rw 0 0
#
# When you now reboot the Raspberry Pi it will boot up, and without asking for a password, the encrypted USB HDD is unlocked.
#
# If you detach the external hard drive and connect it to another computer, it will be encrypted and unreadable. If you lose your key file and your passphrase, the contents of the disk are lost to you too!
#
# PRO TIP! If mounting fails between attempts where you change the contetnts of fstab, try:
#
# sudo systemctl daemon-reload

# Alternate external disk encryption from https://www.wikihow.com/Encrypt-an-External-Hard-Drive-on-Linux
#
#     Check whether cryptsetup is present: Type sudo cryptsetup --version into the terminal. If, instead of printing a version number, that results in "command not found", you need to install cryptsetup.
#        Note that you need to use sudo. Attempting to run cryptsetup without sudo will result in "command not found" even if the program is installed.
#    Image titled Linux fdisk without device.png
#    2
#    Check which devices are connected: sudo fdisk -l.
#    Image titled Connect External Hard Drive to Macbook Pro Step 1
#    3
#    Connect the external hard drive.
#    Image titled Linux fdisk with device.png
#    4
#    Check which devices are connected again. Run sudo fdisk -l again and look for a part that is different. That is the hard drive you connected. Remember its device name (e.g. /dev/sdb). In this article, it will be referred to as /dev/sdX; make sure to replace it with the actual path in all instances.
#    5
#    Back up any data that you want to keep. The next steps will erase all the data from the hard drive.
#    Image titled Linux unmount device.png
#    6
#    Unmount the external hard drive. Do not disconnect it — only unmount it. You can do so through your file manager, or with: sudo umount /dev/sdX
#    Image titled Linux wipe drive files.png
#    7
#    Wipe all file systems and data from the hard drive. While this is not required for setting up the encryption, it is recommended.[1]
#        To quickly wipe only the file system headers, use: sudo wipefs -a /dev/sdX
#        To overwrite all the data on the hard drive, use: sudo dd if=/dev/urandom of=/dev/sdX bs=1M. You will not see a progress bar or any other output, but if your external hard drive has a lamp that blinks when the drive is written to, it should start blinking.
#            If the external hard drive is big, expect that you will need to wait a long time. While it depends on the device and the hard drive, a possible speed is 30 MB per second, taking about 2½ hours for 256 GB.
#            If you want to see the progress, find out the process ID of the dd, then open another terminal and use sudo kill -USR1 pid (pid being your process ID). This will not terminate the process (as kill without the -USR1 parameter would do), but just tells it to print how many bytes it has copied.
#            Using sudo dd if=/dev/zero of=/dev/sdX bs=1M to overwrite with zeroes instead may be faster, but is somewhat less secure than overwriting with random data[2] .
#    Image titled Linux encryption cryptsetup v2.png
#    8
#    Run cryptsetup: sudo cryptsetup --verbose --verify-passphrase luksFormat /dev/sdX
#        cryptsetup will warn you that data will be overwritten irrevocably. Type YES to confirm that you want to do this and continue. You will be prompted to choose a passphrase. After you chose one, it will take some time to set up the encryption. cryptsetup should finish with "Command successful."
#        If cryptsetup warns you about existing partitions (with a message of the form WARNING: Device /dev/sdX already contains ...... partition signature), you haven't properly erased the existing file systems. You should refer to the step about wiping file systems and data, but it is also possible to ignore the warning and continue.
#    Image titled Linux cryptsetup luksOpen v2.png
#    9
#    Open the encrypted partition: sudo cryptsetup luksOpen /dev/sdX sdX (replace both sdX with the encrypted partition you just set up.)
#        You will be prompted for a passphrase. Enter the passphrase that you chose in the previous step.
#    Image titled Linux fdisk l mapper v2.png
#    10
#    Check where the encrypted partition has been mapped to. It is usually /dev/mapper/sdX, but you should double-check using sudo fdisk -l.
#    Image titled Linux mkfs ext4 on encrypted partition v2.png
#    11
#    Create a new filesystem on the encrypted partition. Setting up the encryption has wiped any that previously existed. Use the command: sudo mkfs.ext4 /dev/mapper/sdX
#        It is important that you specify /dev/mapper/sdX. If you specify /dev/sdX instead, you will format the disk as an unencrypted EXT4 partition.
#        You can give your filesystem a label with the -L option, for example: sudo mkfs.ext4 -L MyEncryptedDisk /dev/mapper/sdX
#    Image titled Linux tune2fs remove reserved space v2.png
#    12
#    Remove the reserved space. By default, some space has been reserved, but if you don't intend to run a system from the hard drive, you can remove it to have slightly more space on the hard drive.[3] Use the command: sudo tune2fs -m 0 /dev/mapper/sdX
#    Image titled Linux unmount encrypted partition v2.png
#    13
#    Close the encrypted device: sudo cryptsetup luksClose sdX
#        You can safely disconnect the external hard drive now. For instructions on opening it again and using it, refer to the "Opening an Encrypted External Hard Drive" method.
#
#Part 2
#Opening an Encrypted External Hard Drive
#Download Article
#
#    Image titled Connect External Hard Drive to Macbook Pro Step 1
#    1
#    Connect the external hard drive.
#    Image titled Linux encrypted hard drive prompt.png
#    2
#    Wait and see whether a prompt opens. Some systems will automatically ask for the passphrase, and if you enter it correctly, mount the device.
#    Image titled Linux manually mount encrypted partition.png
#    3
#    Mount the drive manually if the prompt doesn't open.
#        Find the device name: lsblk
#        If this is the first time you are mounting it, create a directory to mount it in, for example: sudo mkdir /mnt/encrypted. Otherwise, use the directory you previously created.
#        Open the encrypted partition: sudo cryptsetup luksOpen /dev/sdX sdX
#        Mount the encrypted partition: sudo mount /dev/mapper/sdX /mnt/encrypted
#    Image titled Linux mounted folder adjust permissions.png
#    4
#    Adjust the permissions if this is the first time you're mounting the drive. When you mount the drive for the first time, writing to the drive requires sudo. To change that, transfer ownership of the folder to the current user: sudo chown -R `whoami`:users /mnt/encrypted
#        If your hard drive was mounted automatically, you can find out where it was mounted using lsblk. Often, it is at a path similar to: /media/your_username/drive_label 
#    5
#    Use the hard drive. You may now use your encrypted hard drive like you would any other hard drive, reading files from it and transferring files onto it.
#    Image titled Linux unmount encrypted partition.png
#    6
#    Unmount the encrypted hard drive. This is necessary so that you may safely disconnect it. You can do so through a file manager, or over the terminal:
#        Unmount the encrypted partition: sudo umount /mnt/encrypted
#        Close the encrypted partition: sudo cryptsetup luksClose sdX
#            If that gives the error message "Device sdX is not active.", the encrypted partition had been opened under a different name (that can happen, for example, if you entered the passphrase in the prompt instead of mounting manually). You can find it with the lsblk command. Look for an entry of type crypt.


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

# Caps Lock
 Caps Lock escape behaviour https://www.dannyguo.com/blog/remap-caps-lock-to-escape-and-control/
Manually invoke with command: `xcape -e 'Control_L=Escape'`
Add `xcape` to .bash_rc to initialize it automatically

# Ubunutu laptop lid handling sleep suspend
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

### Vim
# Vim: delete lines that don’t match pattern https://www.nathankowald.com/blog/2013/01/vim-delete-lines-that-dont-match-pattern/
Ex command :v to the rescue!

:v/pattern/d

Using :g! will give you the same result as using :v.
:g finds lines that do match a pattern.

I had a large list of locations. I wanted to keep only the locations containing hyphens and delete the rest so I used this: :v/-/d

:v – find lines not matching your pattern
d – delete matches

# zip tar u
tar -Scvzf ~/____.tar.gz ~/____/
tar xfvz ____.tar.gz
