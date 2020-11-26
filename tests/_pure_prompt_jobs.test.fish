source $current_dirname/fixtures/constants.fish
source $current_dirname/../functions/_pure_prompt_jobs.fish
source $current_dirname/../functions/_pure_set_color.fish


@test "_pure_prompt_jobs: no jobs indicator when there are no jobs" (
    _pure_prompt_jobs
) $status -eq $SUCCESS

@test "_pure_prompt_jobs: displays number of jobs in prompt" (
    set --global pure_color_jobs grey
    set --global pure_show_jobs true
    sleep 5 &
    _pure_prompt_jobs
    kill (jobs -p)
) = (set_color grey)'[1]'
