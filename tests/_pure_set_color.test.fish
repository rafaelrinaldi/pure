source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_set_color.fish
@echo (_print_filename (status filename))


@test "_pure_set_color: set using a named color" (
    set colorize (_pure_set_color "red")

    echo $colorize'foo'
) = (set_color red)'foo'

@test "_pure_set_color: empty value do not colorize" (
    set colorize (_pure_set_color $EMPTY)

    echo $colorize'foo'
) = 'foo'

@test "_pure_set_color: resolve variable value" (
    set color red

    _pure_set_color $color
) = (set_color red)
