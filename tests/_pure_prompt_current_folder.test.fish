source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_prompt_current_folder.fish
source (dirname (status filename))/../functions/_pure_parse_directory.fish
@echo (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
end; setup


@test "_pure_prompt_current_folder: fails if no argument given" (
    _pure_prompt_current_folder
) $status -eq $FAILURE

@test "_pure_prompt_current_folder: returns current folder" (
    set COLUMNS 20
    set current_prompt_width 10
    mkdir -p /tmp/.pure;
    and cd /tmp/.pure

    string length (_pure_prompt_current_folder "$current_prompt_width")
) = 8
