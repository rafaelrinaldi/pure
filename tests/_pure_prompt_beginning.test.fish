source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_prompt_beginning.fish
@echo (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
end; setup


@test "_pure_prompt_beginning: clear line before printing prompt" (
    _pure_prompt_beginning
) = '\r\033[K'
