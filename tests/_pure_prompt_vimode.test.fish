source $current_dirname/fixtures/constants.fish
source $current_dirname/../functions/_pure_prompt_vimode.fish
@mesg (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
end


@test "_pure_prompt_vimode: hides vimode prompt by default" (
     echo (_pure_prompt_vimode)
) = $EMPTY

@test "_pure_prompt_vimode: show reverse prompt symbol when enable" (
    set --universal pure_reverse_prompt_symbol_in_vimode true

    echo (_pure_prompt_vimode)
) = $EMPTY

@test "_pure_prompt_vimode: show vi_mode when reverse prompt symbol is disable" (
    set fish_key_bindings fish_vi_key_bindings
    set --universal pure_reverse_prompt_symbol_in_vimode false

    _pure_prompt_vimode
    set fish_key_bindings fish_default_key_bindings
) = (set_color --bold --background red white)'[N] '(set_color normal)' '
