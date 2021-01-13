source (dirname (status filename))/fixtures/constants.fish
@echo (_print_filename (status filename))


function setup
    cp tests/fixtures/{config.mock.fish,config.fish}
end; setup

function teardown
    rm tests/fixtures/config.fish
end


@test "migrate all variables" (
    set file_to_migrate (dirname (status filename))/fixtures/config.mock.fish  # created during 'setup'

    fish (dirname (status filename))/../tools/migration-to-4.0.0.fish $file_to_migrate 2>&1 >/dev/null

    diff -U $NONE (dirname (status filename))/fixtures/config.expected.fish $file_to_migrate
) $status -eq $SUCCESS


teardown
