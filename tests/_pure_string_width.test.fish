source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_string_width.fish
@echo (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
end; setup


@test "_pure_string_width: measure empty string" (
    _pure_string_width ''
) = 0

@test "_pure_string_width: measure raw string" (
    _pure_string_width 'user@hostname'
) = 13

@test "_pure_string_width: measure ANSI-colored string" (
    set --local prompt \
                    (set_color grey)'user@' \
                    (set_color blue)'hostname'
    set prompt (string join "$EMPTY" $prompt)  # do not quote the array

    _pure_string_width $prompt
) = 13

@test "_pure_string_width: measure raw UTF-8 string" (
    _pure_string_width '❯⇣🦔@🛡🚀'
) = 6

@test "_pure_string_width: measure ANSI-colored UTF-8 string" (
    set --local prompt \
                    (set_color green)'❯⇣' \
                    (set_color yellow)'🦔@' \
                    (set_color grey)'🛡' \
                    (set_color red)'🚀'

    set prompt (string join "$EMPTY" $prompt)  # do not quote the array

    _pure_string_width $prompt
) = 6

@test "_pure_string_width: accept double dash in string" (
    _pure_string_width '--dash'
) = 6
