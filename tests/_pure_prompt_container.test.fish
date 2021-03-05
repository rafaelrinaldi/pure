source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_is_inside_container.fish
source (dirname (status filename))/../functions/_pure_user_at_host.fish
source (dirname (status filename))/../functions/_pure_prompt_container.fish
@echo (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
end; setup

if test "$USER" = 'nemo'
@test "_pure_prompt_container: displays 'user@hostname' when inside container" (
    string match --quiet --regex "$USER@[\w]+" (_pure_prompt_container)
) $status -eq $SUCCESS
end
