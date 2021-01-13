source $current_dirname/fixtures/constants.fish
source $current_dirname/../functions/_pure_prompt_ending.fish
@mesg (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
end


@test "_pure_prompt_ending: reset color to normal" (
    _pure_prompt_ending
) = (set_color normal)' '
