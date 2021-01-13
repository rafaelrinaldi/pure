source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_is_inside_container.fish
@echo (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors

    set --global cgroup_namespace /tmp/proc/1/cgroup
    set --global namespace (dirname $cgroup_namespace)
    mkdir -p $namespace; and touch $cgroup_namespace
end

function teardown
    rm -rf $namespace
    set --erase cgroup_namespace
    set --erase namespace
end

@test "_pure_is_inside_container: false for host OS" (
    echo "1:name=systemd:/init.scope" > $cgroup_namespace
    set --global container $EMPTY

    _pure_is_inside_container $cgroup_namespace
) $status -eq $FAILURE

@test "_pure_is_inside_container: true for Docker's container" (
    echo "1:name=systemd:/docker/54c541…af18c609c" > $cgroup_namespace

    _pure_is_inside_container $cgroup_namespace
) $status -eq $SUCCESS

@test "_pure_is_inside_container: true for LXC/LXD's container (using namespace detail)" (
    echo "1:name=systemd:/lxc/54c541…af18c609c" > $cgroup_namespace

    _pure_is_inside_container $cgroup_namespace
) $status -eq $SUCCESS

@test "_pure_is_inside_container: true for LXC/LXD's container (using environment variable)" (
    echo "$IS_PRESENT" > $cgroup_namespace
    set --global container 'lxc'

    _pure_is_inside_container
) $status -eq $SUCCESS

