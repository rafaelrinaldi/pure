source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_prompt_jobs.fish
@echo (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors

    set --global JOB_DURATION 1.5
end; setup

function teardown
    set --erase --global JOB_DURATION
end


@test "_pure_prompt_jobs: no jobs indicator when there are no jobs" (
    _pure_prompt_jobs
) $status -eq $SUCCESS

@test "_pure_prompt_jobs: displays number of jobs in prompt" (
    set --universal pure_show_jobs true
    sleep $JOB_DURATION &
    _pure_prompt_jobs
    kill (jobs -p)
) = '[1]'

@test "_pure_prompt_jobs: colorize jobs" (
    source (dirname (status filename))/../functions/_pure_set_color.fish # enable colors
    set --universal pure_color_jobs grey
    set --universal pure_show_jobs true
    sleep $JOB_DURATION &

    _pure_prompt_jobs
    kill (jobs -p)
) = (set_color grey)'[1]'


teardown
