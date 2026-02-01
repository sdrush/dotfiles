{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Container Stuff
    docker-compose
    dive
  ];
}
