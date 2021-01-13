source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/fish_mode_prompt.fish
@echo (_print_filename (status filename))


@test "fish_mode_prompt: succeed" (
    fish_mode_prompt
) $status -eq $SUCCESS

@test "fish_mode_prompt: returns nothing" (
    fish_mode_prompt
) -z
