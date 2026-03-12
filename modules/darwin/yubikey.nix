{ pkgs, user, ... }:

{
  # Launchd agent to run yubikey-agent in the background
  launchd.user.agents.yubikey-agent = {
    command = "${pkgs.yubikey-agent}/bin/yubikey-agent -l /Users/${user}/.ssh/yubikey-agent.sock";
    serviceConfig = {
      Label = "com.phillmv.yubikey-agent";
      KeepAlive = true;
      RunAtLoad = true;
      StandardOutPath = "/Users/${user}/.ssh/yubikey-agent.log";
      StandardErrorPath = "/Users/${user}/.ssh/yubikey-agent.log";
    };
  };
}
