source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/fish_prompt.fish
source (dirname (status filename))/../functions/_pure_print_prompt_rows.fish
source (dirname (status filename))/../functions/_pure_is_single_line_prompt.fish
@mesg (_print_filename (status filename))


function setup
    function _pure_prompt_beginning; echo '['; end
    function _pure_prompt_first_line; echo -e '/path/ git duration'; end
    function _pure_place_iterm2_prompt_mark; end
    function _pure_prompt; echo '❯'; end
    function _pure_prompt_ending; echo ']'; end
end

@test "fish_prompt: succeed" (
    fish_prompt 2>&1 >/dev/null
) $status -eq $SUCCESS

@test "fish_prompt: print segments" (
    fish_prompt
) = '[/path/ git duration ❯]'

@test "fish_prompt: change with exit status" (
    function _pure_prompt; printf 'fail❯'; end

    fish_prompt
) = '[/path/ git duration fail❯]'

@test "fish_prompt: disable _pure_fresh_session" (
    set --global _pure_fresh_session  # so we can see its update

    fish_prompt 2>&1 >/dev/null

    echo $_pure_fresh_session
) = false

@test "fish_prompt: use 2-lines prompt by default" (
    fish_prompt | wc -l
) = 2

@test "fish_prompt: use 1-line compact-prompt" (
    set --universal pure_enable_single_line_prompt true

    fish_prompt | wc -l
) = 1
