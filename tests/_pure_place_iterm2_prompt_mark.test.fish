source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_place_iterm2_prompt_mark.fish
@echo (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
end; setup


@test "_pure_place_iterm2_prompt_mark: no iterm2 prompt mark when NOT in iTerm" (
    echo (_pure_place_iterm2_prompt_mark)
) = $EMPTY

@test "_pure_place_iterm2_prompt_mark: shows iterm2 prompt mark in iTerm" (
    function iterm2_prompt_mark; echo 'iterm2-mark'; end

    echo (_pure_place_iterm2_prompt_mark)
) = 'iterm2-mark'
