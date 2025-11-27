abbr -a -- ls eza
abbr -a -- la 'eza -lah'
abbr -a -- ldot 'eza -ld .*'
abbr -a -- hx helix
abbr -a -- hx.c 'helix /home/dot/.config'
abbr -a -- c.c 'cd /home/dot/.config/'

if status is-interactive
    fastfetch
    # For jumping between prompts in foot terminal
    function mark_prompt_start --on-event fish_prompt
        echo -en "\e]133;A\e\\"
    end
end
