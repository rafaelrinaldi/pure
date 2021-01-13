source $current_dirname/fixtures/constants.fish
source $current_dirname/../functions/_pure_is_single_line_prompt.fish
source $current_dirname/../functions/_pure_print_prompt_rows.fish
@mesg (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
    function _pure_prompt_first_line; echo $EMPTY; end
end

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
