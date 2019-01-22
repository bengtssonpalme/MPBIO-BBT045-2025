## How to connect to remote accounts

### Windows

* Install MobaXterm: https://mobaxterm.mobatek.net/download-home-edition.html
   * The portable edition should be quicker. It simply unpacks MobaXterm in a folder and you can start it from there
* Open MobaXtern
* In the toolbar: Session > SSH 
* In the field "Remote host" write the IP address and "student1" in "Specify username
* Click OK
* Enter password  (you won't see any feedback - like `*******` - on the screen)

### Linux or macOS: 

* Open Terminal
* Run:  `ssh <username>@<ip-address>`
* If promted about about host authenticity ("*ECDSA key fingerprint is SHA256:... Are you sure you want to continue connecting (yes/no)?"*) write, `yes` then pres `[Enter]`
* Enter password  (you won't see any feedback - like `*******` - on the screen)
