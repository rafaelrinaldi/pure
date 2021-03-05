source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_prompt_symbol.fish
source (dirname (status filename))/../functions/_pure_get_prompt_symbol.fish
@echo (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors

    set --universal pure_symbol_prompt '>'  # using default ❯ break following tests
end; setup


@test "_pure_prompt_symbol: colorizes prompt in green when last command succeed" (
    source (dirname (status filename))/../functions/_pure_set_color.fish # enable colors
    set --local last_command $SUCCESS
    set --universal pure_color_prompt_on_success green

    _pure_prompt_symbol $last_command
) = (set_color green)'>'

@test "_pure_prompt_symbol: colorizes prompt in red when last command failed" (
    source (dirname (status filename))/../functions/_pure_set_color.fish # enable colors
    set --local last_command $FAILURE
    set --universal pure_color_prompt_on_error red

    _pure_prompt_symbol $last_command
) = (set_color red)'>'

@test "_pure_prompt_symbol: add a magenta prompt when pure_separate_prompt_on_error is enable and last command failed" (
    source (dirname (status filename))/../functions/_pure_set_color.fish # enable colors
    set --local last_command $FAILURE
    set --universal pure_color_prompt_on_error red
    set --universal pure_color_prompt_on_success magenta
    set --universal pure_separate_prompt_on_error true

    _pure_prompt_symbol $last_command
) = (set_color red)'>'(set_color magenta)'>'
