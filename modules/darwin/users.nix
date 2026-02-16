{ user, ... }:

{
  # User(s)
  users.users."${user}" = {
    name = "${user}";
    home = "/Users/${user}";
  };
}
