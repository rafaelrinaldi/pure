source $current_dirname/fixtures/constants.fish
@mesg (_print_filename (status filename))


function setup
    cp tests/fixtures/{config.mock.fish,config.fish}
end

function teardown
    rm tests/fixtures/config.fish
end


@test "migrate all variables" (
    set file_to_migrate $current_dirname/fixtures/config.mock.fish  # created during 'setup'

    fish $current_dirname/../tools/migration-to-4.0.0.fish $file_to_migrate 2>&1 >/dev/null

    diff -U $NONE $current_dirname/fixtures/config.expected.fish $file_to_migrate
) $status -eq $SUCCESS
