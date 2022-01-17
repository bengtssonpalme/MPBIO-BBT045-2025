## What is an SSH key?

To be able to make changes to a remote repository when working from your account on the server you need to set up a ssh key for this client. An SSH key is a form of authenticate much like a password. However, SSH keys is much more convenient and secure than regular passwords. For more information visit [about-ssh](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/about-ssh)

## Setting up SSH key for your server account

To set up an ssh key for your account on the server you need to first log in to your account.
´ssh <user_name@13.48.179.168´
Once logged in you need to generate the ssh key
´ssh-keygen -t ed25519´

This will create two new files in the directory .ssh
´$ ls .ssh \n > id_ed25519  id_ed25519.pub ´

You will then be prompted to enter a location to store the ssh key. Just press enter to store it in the default location.
Then you will be prompted to add a pass phrase, you can either skip this by pressing enter or type in a pass phrase/password that you'll use along with your ssh-key. Pass phrases is an additional security layer that prevents anyone with the access to your account to also use your ssh-keys to get further access to other services.

´> Enter passphrase (empty for no passphrase): [Type a passphrase] \n > Enter same passphrase again: [Type passphrase again] ´

Next we need to start a ssh agent that will manage our keys.

´$ eval "$(ssh-agent -s)"´

´ ssh-add ~/.ssh/id_ed25519´
## Setting up SSH key for your pc/mac

To set up your ssh key