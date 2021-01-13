source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_set_default.fish
@echo (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
end; setup

function teardown
    set --erase --universal pure_fake_config
    set --erase --global pure_fake_config
end


@test "_pure_set_default: set value when variable doesn't exist on any scope" (
    _pure_set_default pure_fake_config 'default'

    echo $pure_fake_config
) = 'default'

@test "_pure_set_default: ignore value when variable already declared on UNIVERSAL scope" (
    set --universal pure_fake_config 'default'

    _pure_set_default pure_fake_config 'new'
    echo $pure_fake_config
) = 'default'

@test "_pure_set_default: set value when declared on UNIVERSAL scope but is an empty string (i.e. prevent empty colors)" (
    set --universal pure_fake_config $EMPTY

    _pure_set_default pure_fake_config 'new'
    echo $pure_fake_config
) = 'new'

@test "_pure_set_default: ignore value when variable already declared on GLOBAL scope" (
    set --universal pure_fake_config 'default'

    _pure_set_default pure_fake_config 'new'
    echo $pure_fake_config
) = 'default'

@test "_pure_set_default: ignore value when declared on GLOBAL scope but is an empty string (i.e. prevent empty colors)" (
    set --global pure_fake_config $EMPTY

    _pure_set_default pure_fake_config 'new'
    echo $pure_fake_config
) != 'new' # ⚠️ Universal variable is shadowed by the global variable of the same name.


teardown
