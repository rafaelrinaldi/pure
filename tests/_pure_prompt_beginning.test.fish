source $current_dirname/fixtures/constants.fish
source $current_dirname/../functions/_pure_prompt_beginning.fish
@mesg (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
end


@test "_pure_prompt_beginning: clear line before printing prompt" (
    _pure_prompt_beginning
) = '\r\033[K'
