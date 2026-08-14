{ pkgs, ... }: {
  home.packages = with pkgs; [
    blesh
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      if [[ $- == *i* ]]; then
        source ${pkgs.blesh}/share/blesh/ble.sh

        # Expand sabbrevs on Enter as well, like fish's abbr does.
        # verify-syntax keeps the default pause on syntactically incomplete lines.
        bleopt edit_magic_accept='verify-syntax:sabbrev'

        # Fish-style abbreviations. ble-sabbrev itself defers registration
        # internally until the core-complete module is loaded.
        ble-sabbrev ':q'='exit'
        ble-sabbrev c='cd'
        ble-sabbrev rm='trash put'
        ble-sabbrev l='ls'
        ble-sabbrev lsa='ls --all'
        ble-sabbrev lsl='ls -l -h'
        ble-sabbrev lsal='ls --all -l -h'
        ble-sabbrev ln='ln -s -v'
        ble-sabbrev e='edit'
        ble-sabbrev n='nvim'
        ble-sabbrev h='hx'
        ble-sabbrev gstatus='git status -s -b'
        ble-sabbrev t='btop'
        ble-sabbrev b='btm'

        # Limit sabbrev expansion to command position (fish abbr semantics)
        # by overriding the internal word locator. Only the `command` syntax
        # source is matched; argument/rhs/suffix positions stay untouched.
        # Set up after the abbr definitions: both this hook and ble-sabbrev
        # are queued until core-complete finishes loading, so by the time the
        # override runs, blesh has already defined the original locate-key
        # that we are replacing (an earlier definition would be clobbered).
        blehook/eval-after-load complete my/sabbrev-command-only
        function my/sabbrev-command-only {
          function ble/complete/sabbrev/locate-key {
            pos=$comp_index
            local sources src asrc
            ble/complete/context:syntax/generate-sources
            for src in "''${sources[@]}"; do
              ble/string#split-words asrc "$src"
              [[ ''${asrc[0]} == command ]] || continue
              ((asrc[1]<pos)) && pos=''${asrc[1]}
            done
            ((pos<comp_index))
          }
        }
      fi
    '';
  };
}
