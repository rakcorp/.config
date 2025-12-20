function fish_prompt
    set -l last_status $status

    set -l LGRA 777777
    set -l MGRA 464646
    set -l DGRA 242424

    set -l FORE (defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 000000 || echo ffffff)
    set -l BACK (defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo black || echo brwhite)
    set -l STAT
    if test $last_status -ne 0
        set STAT (string join ' ' -- (set_color red) "􀇿  exit $last_status " (set_color normal))
    else
        set STAT (string join ' ' -- (set_color green) "􀁣  exit $last_status " (set_color normal))
    end

    set -l directory_icon
    if test "$PWD" -ef "$HOME"
        set directory_icon '􀎟'
    else if test "$PWD" -ef "$XDG_CONFIG_HOME"
        set directory_icon '􀣌'
    else
        set directory_icon '􀈖'
    end

    string join '' -- \
        (set_color blue) '' (set_color $FORE) (set_color -b blue) $USER ' ' (set_color blue) (set_color -b $BACK) ' ' \
        $directory_icon '  ' (set_color $BACK) (set_color -b blue) ' ' \
        (set_color $FORE) (prompt_pwd) ' ' (set_color blue) (set_color -b $BACK) '' \
        (set_color $BACK) (set_color -b $BACK) $STAT (set_color normal) (set_color $BACK) ' ' \
	       (set_color normal) # (set_color blue) '' (set_color normal) ' '
end
