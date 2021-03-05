source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_is_single_line_prompt.fish
source (dirname (status filename))/../functions/_pure_print_prompt_rows.fish
@echo (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
    function _pure_prompt_first_line; echo $EMPTY; end
end; setup

function teardown
    functions --erase _pure_prompt_first_line
end


@test "_pure_print_prompt_rows: end with newline by default" (
    _pure_print_prompt_rows | wc -l
) = 1

@test "_pure_print_prompt_rows: end WITHOUT newline when compact-prompt is enable" (
    set --universal pure_enable_single_line_prompt true

    _pure_print_prompt_rows | wc -l
) = 0


teardown
