source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_prefix_root_prompt.fish
@echo (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
    set --universal pure_symbol_prefix_root_prompt '#'
end; setup

@test "_pure_prefix_root_prompt: is empty for unprivileged user" (
    set --universal pure_show_prefix_root_prompt true
    function id; echo 'nemo'; end # mock

    _pure_prefix_root_prompt
) = $EMPTY

@test "_pure_prefix_root_prompt: is shown for `root` user" (
    set --universal pure_show_prefix_root_prompt true
    function id; echo 'root'; end # mock

    _pure_prefix_root_prompt
) = "#"

@test "_pure_prefix_root_prompt: colorize root prefix symbol" (
    source (dirname (status filename))/../functions/_pure_set_color.fish
    set --universal pure_show_prefix_root_prompt true
    set --universal pure_color_prefix_root_prompt red
    function id; echo 'root'; end # mock

    _pure_prefix_root_prompt
) = (set_color red)"#"

@test "_pure_prefix_root_prompt: require flag" (
    set --universal pure_show_prefix_root_prompt false
    function id; echo 'root'; end # mock

    _pure_prefix_root_prompt
) = $EMPTY
