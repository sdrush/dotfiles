# My dotfiles Repository

## Set up for a new machine

The first thing we need to do is make sure our ssh keys are set up
correctly.  I use two different keys with aliases in my
~/.ssh/config.
[GitHub](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
has some great documentation about this process.

### MacOS

1. Generate a new pair of ssh keys:

    ```bash
    ssh-keygen -t ed25519 \
        -f ~/.ssh/id_ed25519_personal_email_example_com \
        -C "personal.email@example.com"
    ssh-keygen -t ed25519 \
        -f ~/.ssh/id_ed22519_work_email_example_com \
        -C "work.email@example.com"
    ```

1. Open  ~/.ssh/config file, then add the following lines.

    If the SSH keyfile has a different name or path than the example
    code, modify the filename or path to match your current setup.

    ```bash
    Host *
    AddKeysToAgent yes
    UseKeychain yes
    ```

1. While we are in ~/.ssh/config, lets set up our GitHub aliases.

    There is probably a better way to do this but this works for now and
    forces me to intentionally use the right alias for each one instead
    of swapping them out one at a time in the agent and accidentally
    forgetting which one I have loaded.

    ```bash
    # Work GitHub Alias
    Host w.github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_work_email_example_com
    
    # Personal GitHub Alias
    Host p.github.com    
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_personal_email_example_com
    ```

1. Copy our public keys into our two GitHub accounts.  
    Log in and go to the account bubble and select  
    Settings->SSH and GPG Keys->New SSH Key
    Give the new key a name that identifies the type and system on which
    it was generated like "Macbook ed25519 Personal Key"
1. Time to clone our repo.
    I store my dotfiles in my personal github repo.  I use the same repo
    on pretty much every device I own - Windows (WSLv2), MacOS, Linux,
    Raspberry Pi(WIP) and I didn't want it tied to my employers account.
    Switching repos is as simple as using the w.github.com alias.

    ```bash
    git clone git@p.github.com:<your_gh_repo>/dotfiles.git \
        ~/.dotfiles
    ```

1. Now we just cd into the directory and run our bootstrap.sh to set up
   our symlinks

   ```bash
    cd ~/.dotfiles
    ./bootstrap.sh
   ```

### Windows (WSLv2)

1. TBD
