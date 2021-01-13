source $current_dirname/fixtures/constants.fish
source $current_dirname/../functions/_pure_set_default.fish
@mesg (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
end

@test "configure: pure_version"  (
    set --erase pure_version
    source $current_dirname/../conf.d/pure.fish
    echo $pure_version
) != $EMPTY

@test "configure: pure_symbol_prompt"  (
    set --erase pure_symbol_prompt
    source $current_dirname/../conf.d/pure.fish
    echo $pure_symbol_prompt
) = "❯"

@test "configure: pure_symbol_reverse_prompt"  (
    set --erase pure_symbol_reverse_prompt
    source $current_dirname/../conf.d/pure.fish
    echo $pure_symbol_reverse_prompt
) = "❮"

@test "configure: pure_reverse_prompt_symbol_in_vimode" (
    set --erase pure_reverse_prompt_symbol_in_vimode
    source $current_dirname/../conf.d/pure.fish
    echo $pure_reverse_prompt_symbol_in_vimode
) = true

@test "configure: pure_enable_git"  (
    set --erase pure_enable_git
    source $current_dirname/../conf.d/pure.fish
    echo $pure_enable_git
) = true

@test "configure: pure_symbol_git_unpulled_commits"  (
    set --erase pure_symbol_git_unpulled_commits
    source $current_dirname/../conf.d/pure.fish
    echo $pure_symbol_git_unpulled_commits
) = "⇣"

@test "configure: pure_symbol_git_unpushed_commits"  (
    set --erase pure_symbol_git_unpushed_commits
    source $current_dirname/../conf.d/pure.fish
    echo $pure_symbol_git_unpushed_commits
) = "⇡"

@test "configure: pure_symbol_git_dirty"  (
    set --erase pure_symbol_git_dirty
    source $current_dirname/../conf.d/pure.fish
    echo $pure_symbol_git_dirty
) = "*"

@test "configure: pure_symbol_git_stash"  (
    set --erase pure_symbol_git_stash
    source $current_dirname/../conf.d/pure.fish
    echo $pure_symbol_git_stash
) = "≡"

@test "configure: pure_symbol_title_bar_separator"  (
    set --erase pure_symbol_title_bar_separator
    source $current_dirname/../conf.d/pure.fish
    echo $pure_symbol_title_bar_separator
) = "-"

@test "configure: pure_color_primary"  (
    set --erase pure_color_primary
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_primary
) = blue

@test "configure: pure_color_info"  (
    set --erase pure_color_info
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_info
) = cyan

@test "configure: pure_color_mute"  (
    set --erase pure_color_mute
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_mute
) = brblack

@test "configure: pure_color_success"  (
    set --erase pure_color_success
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_success
) = magenta

@test "configure: pure_color_normal"  (
    set --erase pure_color_normal
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_normal
) = normal

@test "configure: pure_color_danger"  (
    set --erase pure_color_danger
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_danger
) = red

@test "configure: pure_color_light"  (
    set --erase pure_color_light
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_light
) = white

@test "configure: pure_color_warning"  (
    set --erase pure_color_warning
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_warning
) = yellow

@test "configure: pure_color_command_duration"  (
    set --erase pure_color_command_duration
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_command_duration
) = pure_color_warning

@test "configure: pure_color_current_directory"  (
    set --erase pure_color_current_directory
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_current_directory
) = pure_color_primary

@test "configure: pure_color_git_unpushed_commits"  (
    set --erase pure_color_git_unpushed_commits
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_git_unpushed_commits
) = pure_color_info

@test "configure: pure_color_git_unpulled_commits"  (
    set --erase pure_color_git_unpulled_commits
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_git_unpulled_commits
) = pure_color_info

@test "configure: pure_color_git_branch"  (
    set --erase pure_color_git_branch
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_git_branch
) = pure_color_mute

@test "configure: pure_color_git_dirty"  (
    set --erase pure_color_git_dirty
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_git_dirty
) = pure_color_mute

@test "configure: pure_color_git_stash"  (
    set --erase pure_color_git_stash
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_git_stash
) = pure_color_info

@test "configure: pure_color_hostname"  (
    set --erase pure_color_hostname
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_hostname
) = pure_color_mute

@test "configure: pure_color_at_sign"  (
    set --erase pure_color_at_sign
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_at_sign
) = pure_color_mute

@test "configure: pure_color_username_normal"  (
    set --erase pure_color_username_normal
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_username_normal
) = pure_color_mute

@test "configure: pure_color_username_root"  (
    set --erase pure_color_username_root
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_username_root
) = pure_color_light

@test "configure: pure_color_prompt_on_error"  (
    set --erase pure_color_prompt_on_error
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_prompt_on_error
) = pure_color_danger

@test "configure: pure_color_prompt_on_success"  (
    set --erase pure_color_prompt_on_success
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_prompt_on_success
) = pure_color_success

@test "configure: pure_show_jobs"  (
    set --erase pure_show_jobs
    source $current_dirname/../conf.d/pure.fish
    echo $pure_show_jobs
) = false

@test "configure: pure_color_jobs"  (
    set --erase pure_color_jobs
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_jobs
) = pure_color_normal

@test "configure: pure_show_system_time"  (
    set --erase pure_show_system_time
    source $current_dirname/../conf.d/pure.fish
    echo $pure_show_system_time
) = false

@test "configure: pure_color_system_time"  (
    set --erase pure_color_system_time
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_system_time
) = pure_color_mute

@test "configure: pure_color_virtualenv"  (
    set --erase pure_color_virtualenv
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_virtualenv
) = pure_color_mute

@test "configure: pure_begin_prompt_with_current_directory"  (
    set --erase pure_begin_prompt_with_current_directory
    source $current_dirname/../conf.d/pure.fish
    echo $pure_begin_prompt_with_current_directory
) = true

@test "configure: pure_separate_prompt_on_error"  (
    set --erase pure_separate_prompt_on_error
    source $current_dirname/../conf.d/pure.fish
    echo $pure_separate_prompt_on_error
) = false

@test "configure: pure_threshold_command_duration"  (
    set --erase pure_threshold_command_duration
    source $current_dirname/../conf.d/pure.fish
    echo $pure_threshold_command_duration
) = 5

@test "configure: pure_show_subsecond_command_duration"  (
    set --erase pure_show_subsecond_command_duration
    source $current_dirname/../conf.d/pure.fish
    echo $pure_show_subsecond_command_duration
) = false

@test "configure: pure_color_command_duration"  (
    set --erase pure_color_command_duration
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_command_duration
) = pure_color_warning

@test "configure: pure_check_for_new_release" (
    set --erase pure_check_for_new_release
    source $current_dirname/../conf.d/pure.fish
    echo $pure_check_for_new_release
) = false

@test "configure: pure_show_prefix_root_prompt" (
    set --erase pure_show_prefix_root_prompt
    source $current_dirname/../conf.d/pure.fish
    echo $pure_show_prefix_root_prompt
) = false

@test "configure: pure_symbol_prefix_root_prompt" (
    set --erase pure_symbol_prefix_root_prompt
    source $current_dirname/../conf.d/pure.fish
    echo $pure_symbol_prefix_root_prompt
) = '#'

@test "configure: pure_color_prefix_root_prompt" (
    set --erase pure_color_prefix_root_prompt
    source $current_dirname/../conf.d/pure.fish
    echo $pure_color_prefix_root_prompt
) = pure_color_danger

@test "configure: pure_enable_single_line_prompt" (
    set --erase pure_enable_single_line_prompt
    source $current_dirname/../conf.d/pure.fish
    echo $pure_enable_single_line_prompt
) = false

