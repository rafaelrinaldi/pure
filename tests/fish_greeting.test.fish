source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/fish_greeting.fish
@mesg (_print_filename (status filename))


function _pure_check_for_new_release; echo ''; end

@test "fish_greeting: succeed" (
    fish_greeting
) $status -eq $SUCCESS

@test "fish_greeting: returns nothing" (
    fish_greeting
) -z
