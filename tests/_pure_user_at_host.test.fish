source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_user_at_host.fish
@mesg (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
end


@test "_pure_user_at_host: standard user" (
    string match --quiet --regex (id -u -n)'@[\w]+' (_pure_user_at_host)
) $status -eq $SUCCESS

@test "_pure_user_at_host: root user" (
    function id; echo 'root'; end # mock

    string match --quiet --regex 'root@[\w]+' (_pure_user_at_host)
) $status -eq $SUCCESS

@test "_pure_user_at_host: colorize for normal user" (
    source (dirname (status filename))/../functions/_pure_set_color.fish # enable colors
    set --universal pure_color_username_normal green
    set --universal pure_color_at_sign grey
    set --universal pure_color_hostname blue

    string match --quiet --regex (set_color green)(id -u -n)(set_color grey)'@'(set_color blue)'[\w]+' (_pure_user_at_host)
) $status -eq $SUCCESS

@test "_pure_user_at_host: colorize for root user" (
    source (dirname (status filename))/../functions/_pure_set_color.fish # enable colors
    function id; echo 'root'; end # mock
    set --universal pure_color_username_root red
    set --universal pure_color_at_sign grey
    set --universal pure_color_hostname blue

    string match --quiet --regex (set_color green)'root'(set_color grey)'@'(set_color blue)'[\w]+' (_pure_user_at_host)
) $status -eq $SUCCESS
