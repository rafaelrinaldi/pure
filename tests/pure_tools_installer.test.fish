source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../tools/installer.fish
@echo (_print_filename (status filename))


function remove_pure_files
    for file in $HOME/.config/fish/functions/_pure*.fish
        rm -rf "$file"
    end
    for file in $HOME/.config/fish/conf.d/*pure*
        rm -rf "$file"
    end
    rm -rf $HOME/.config/fish/functions/theme-pure
end

function remove_fish_prompt_files
    for file in $HOME/.config/fish/functions/fish_*.fish
        rm -rf "$file"
    end
end

function setup
    _purge_configs
    _disable_colors

    if test "$USER" = 'nemo'
        rm --force $HOME/.config/fish/config.fish
        touch $HOME/.config/fish/config.fish
        remove_pure_files
        remove_fish_prompt_files
        echo '' > $HOME/.config/fish/config.fish
    end
end; setup


@test "installer: pass argument to set $FISH_CONFIG_DIR" (
    pure_set_fish_config_path "/custom/config/path" >/dev/null
    echo "$FISH_CONFIG_DIR"
) = "/custom/config/path"

@test 'installer: set $FISH_CONFIG_DIR to default value' (
    pure_set_fish_config_path >/dev/null
    echo "$FISH_CONFIG_DIR"
) = "$HOME/.config/fish"

@test "installer: pass arguments to set $PURE_INSTALL_DIR" (
    pure_set_pure_install_path "/custom/config/path" "/custom/theme/path" >/dev/null
    echo "$PURE_INSTALL_DIR"
) = "/custom/theme/path"

@test 'installer: set $PURE_INSTALL_DIR to default value' (
    pure_set_pure_install_path >/dev/null
    echo $PURE_INSTALL_DIR
) = "$FISH_CONFIG_DIR/functions/theme-pure"

@test "installer: pure_scaffold_fish_directories $FISH_CONFIG_DIR/{functions,conf.d}" (
    pure_scaffold_fish_directories >/dev/null

    test -d $FISH_CONFIG_DIR/functions -a -d $FISH_CONFIG_DIR/conf.d
) $status -eq $SUCCESS

@test "installer: pure_fetch_source create install directory $PURE_INSTALL_DIR" (
    pure_fetch_source >/dev/null
    test -d $PURE_INSTALL_DIR -a -O $PURE_INSTALL_DIR
) $status -eq $SUCCESS

@test "installer: pure_fetch_source extract source correctly" (
    function curl; echo $argv; end # mock
    pure_fetch_source >/dev/null
    functions --erase curl  # so others tests are not polluted

    test -e README.md
) $status -eq $SUCCESS


@test "installer: backup existing theme prompt" (
    touch $FISH_CONFIG_DIR/functions/fish_prompt.fish
    rm --force $FISH_CONFIG_DIR/functions/fish_prompt.fish.ignore

    pure_backup_existing_theme >/dev/null
) -e "$FISH_CONFIG_DIR/functions/fish_prompt.fish.ignore"

@test "installer: inject autoloading in config" (
    set FISH_CONFIG_DIR "$HOME/.config/fish"
    mkdir -p $PURE_INSTALL_DIR/conf.d/
    touch $PURE_INSTALL_DIR/conf.d/pure.fish

    pure_enable_autoloading >/dev/null
    grep -q 'fish_function_path' $FISH_CONFIG_DIR/config.fish
) $status -eq $SUCCESS


@test "installer: activate prompt" (
    pure_enable_autoloading >/dev/null

    grep -c "pure.fish" $FISH_CONFIG_DIR/config.fish
) = $IS_PRESENT

@test "installer: app path to theme's functions" (
    touch $FISH_CONFIG_DIR/config.fish

    pure_enable_theme >/dev/null

    [ "$fish_function_path[1]" = "$PURE_INSTALL_DIR/functions/" ];
) $status -eq $SUCCESS

@test "installer: load theme file" (
    echo 'set --global _pure_fresh_session true' > $FISH_CONFIG_DIR/config.fish

    pure_enable_theme >/dev/null

    [ "$_pure_fresh_session" = true ]
) $status -eq $SUCCESS

if test "$USER" = 'nemo'
    @test "installer: link configuration and functions to fish config directory" (
        pure_set_pure_install_path "" /tmp/.pure/ >/dev/null
        pure_symlinks_assets >/dev/null

        set --local active_prompt $FISH_CONFIG_DIR/functions/fish_prompt.fish
        set --local pure_config $FISH_CONFIG_DIR/conf.d/pure.fish
        test \
            -r "$active_prompt" -a -L "$active_prompt" \
            -a -r "$pure_config" -a -L "$pure_config"   # configs and functions are a readable symlink
    ) $status -eq $SUCCESS
end

if test "$USER" = 'nemo'
    @test "installation methods: manually (with local installer)" (
        source (dirname (status filename))/../tools/installer.fish
        and install_pure >/dev/null
        for config in $PURE_INSTALL_DIR/conf.d/*
            source $config
        end

        set --universal pure_symbol_prompt '>'  # using default ❯ break following tests
        fish_prompt | string match --entire --quiet '>'
    ) $status -eq $SUCCESS
end

if test "$USER" = 'nemo'
    @test "installation methods: manually (with published installer)" (
        curl --silent --location git.io/pure-fish --output /tmp/installer.fish
        and source /tmp/installer.fish
        and install_pure >/dev/null

        set --universal pure_symbol_prompt '>'  # using default ❯ break following tests
        fish_prompt | string match --entire --quiet '>'
    ) $status -eq $SUCCESS
end

if test "$USER" = 'nemo'
    @test "installation methods: with fisher 4.x" (
        fish -c 'fisher install pure-fish/pure' >/dev/null 2>&1

        set --universal pure_symbol_prompt '>'  # using default ❯ break following tests
        fish_prompt | string match --entire --quiet '>'
    ) $status -eq $SUCCESS
end

if test "$USER" = 'nemo'
# don't move in different file otherwise there is a race conditions
    @test "_pure_uninstall: handler file is source correctly" (
        fish -c '\
            cd $HOME
            fisher install /tmp/. >/dev/null 2>&1 '\
        | string match --entire --quiet 'source: Error encountered while sourcing file' \
    ) $status = $FAILURE
end

if test "$USER" = 'nemo'
# don't move in different file otherwise there is a race conditions
    @test "_pure_uninstall: uninstall handler is executed and remove config" (
        fish -c "\
            fisher install /tmp/.pure >/dev/null 2>&1; \
            fisher remove /tmp/.pure >/dev/null 2>&1; \
            set --names | grep -c -E '^pure_' \
        "
    ) = $NONE
end
