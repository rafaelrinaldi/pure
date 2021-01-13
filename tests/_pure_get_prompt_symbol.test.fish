source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_get_prompt_symbol.fish
@echo (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
    set --universal pure_symbol_prompt '❯'
    set --universal pure_symbol_reverse_prompt '❮'
end; setup

function teardown
    set fish_key_bindings fish_default_key_bindings
    set fish_bind_mode 'default'
end


@test "_pure_get_prompt_symbol: get default symbol ❯" (
    set --universal pure_reverse_prompt_symbol_in_vimode false

    _pure_get_prompt_symbol
) = '❯'

@test "_pure_get_prompt_symbol: get default symbol ❯ when key binding is default" (
    set --universal pure_reverse_prompt_symbol_in_vimode true
    set fish_bind_mode 'insert'
    set fish_key_bindings 'fish_default_key_bindings'

    _pure_get_prompt_symbol
) = '❯'

@test "_pure_get_prompt_symbol: get default symbol ❯ when bind mode is default" (
    set --universal pure_reverse_prompt_symbol_in_vimode true
    set fish_key_bindings 'fish_default_key_bindings'
    set fish_bind_mode 'default'

    _pure_get_prompt_symbol
) = '❯'

@test "_pure_get_prompt_symbol: get default symbol ❯ when VI key binding and in insert mode" (
    set --universal pure_reverse_prompt_symbol_in_vimode true
    set fish_bind_mode 'insert'
    set fish_key_bindings 'fish_vi_key_bindings'

    _pure_get_prompt_symbol
) = '❯'

@test "_pure_get_prompt_symbol: get default symbol ❯ when VI key binding and in replace mode" (
    set --universal pure_reverse_prompt_symbol_in_vimode true
    set fish_bind_mode 'replace'
    set fish_key_bindings 'fish_vi_key_bindings'

    _pure_get_prompt_symbol
) = '❯'

@test "_pure_get_prompt_symbol: get reverse symbol ❮ when VI key binding and not in insert mode or replace mode" (
    set --universal pure_reverse_prompt_symbol_in_vimode true
    set fish_bind_mode 'default'
    set fish_key_bindings 'fish_vi_key_bindings'

    _pure_get_prompt_symbol
) = '❮'

@test "_pure_get_prompt_symbol: get reverse symbol ❮ when hybrid key binding and not in insert mode or replace mode" (
    set --universal pure_reverse_prompt_symbol_in_vimode true
    set fish_bind_mode 'default'
    set fish_key_bindings 'fish_hybrid_key_bindings'

    _pure_get_prompt_symbol
) = '❮'


teardown
