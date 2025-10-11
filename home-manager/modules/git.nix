
{
  programs.git = {
    enable = true;
    userName = "Eric Puentes";
    userEmail = "ericdpb@pm.me";
    extraConfig = {
      color.ui = true;
      core = {
        autocrlf = "input";
        editor = "vim";
        safecrlf = true;
      };
      alias = {
        ci = "commit";
        co = "checkout";
        s = "status";
        st = "status";
        lg = "log --oneline";
        last = "log -1 HEAD";
        cl = "log -p -- ':(exclude)Cargo.lock'";
        f = "push --force-with-lease";
        ss = "!f() { git stash show stash^{/$*} -p; }; f";
        sa = "!f() { git stash apply stash^{/$*}; }; f";
        sl = "stash list";
        br = "branch";
      };
      diff = {
        tool = "vimdiff";
        algorithm = "patience";
        compactionHeuristic = true;
      };
      merge = {
        tool = "vimdiff";
        conflictstyle = "diff3";
      };
      pull = {
        rebase = true;
      };
    };
  };
}
