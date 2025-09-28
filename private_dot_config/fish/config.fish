
abbr -a -- ls eza
abbr -a -- la 'eza -lah'
abbr -a -- ldot 'eza -ld .*'



if status is-interactive
    # Starship custom prompt
    starship init fish | source
    fastfetch
    # For jumping between prompts in foot terminal
    function mark_prompt_start --on-event fish_prompt
        echo -en "\e]133;A\e\\"
    end
end
