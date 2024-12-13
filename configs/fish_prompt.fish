function fish_prompt -d "Write out the prompt"
    printf '%s %s @ %s in %s [%s] \n%s ' (set_color blue)(echo \#) (set_color cyan)$USER(set_color normal) (set_color green)$hostname(set_color normal) \
        (set_color yellow)(prompt_pwd)(set_color normal) \
        (echo -n (date +%H:%M:%S)) \
        (set_color red)(echo \$)(set_color normal)
end