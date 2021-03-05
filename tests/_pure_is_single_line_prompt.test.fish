source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_is_single_line_prompt.fish
@echo (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
end; setup

@test "_pure_is_single_line_prompt: fail when unset" (
    set --erase pure_enable_single_line_prompt

    _pure_is_single_line_prompt
) $status -eq $FAILURE

@test "_pure_is_single_line_prompt: fail when not disable" (
    set --universal pure_enable_single_line_prompt false

    _pure_is_single_line_prompt
) $status -eq $FAILURE

@test "_pure_is_single_line_prompt: succeed when enable" (
    set --universal pure_enable_single_line_prompt true

    _pure_is_single_line_prompt
) $status -eq $SUCCESS
