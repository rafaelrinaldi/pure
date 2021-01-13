source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_format_time.fish
@echo (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
end; setup

set --local threshold 0 # in seconds


@test "_pure_format_time: throws error on negative time" (
    set --local negative_duration -1
    _pure_format_time $negative_duration $threshold
) $status -eq $FAILURE

@test "_pure_format_time: returns nothing if duration is below thresold time" (
    set --local duration 0 # ms
    set --local threshold 1 # s
    _pure_format_time $duration $threshold
) = $EMPTY

@test "_pure_format_time: format 1s to human" (
    set --local millisecond 1000 # express as milliseconds
    _pure_format_time (math "1*$millisecond") $threshold
) = '1s'

@test "_pure_format_time: format 1050ms to human (show milliseconds)" (
    set --local milliseconds 1053 # express as milliseconds
    _pure_format_time (math "1*$milliseconds") $threshold true
) = '1.05s'

@test "_pure_format_time: format 60s as a minutes to human" (
    set --local millisecond 1000 # express as milliseconds
    _pure_format_time (math "60*$millisecond") $threshold
) = '1m'

@test "_pure_format_time: format 59 minutes to human" (
    set --local minute 60000 # express as milliseconds
    _pure_format_time (math "59*$minute") $threshold
) = '59m'

@test "_pure_format_time: format 60min as an hour to human" (
    set --local minute 60000 # express as milliseconds
    _pure_format_time (math "60*$minute") $threshold
) = '1h'

@test "_pure_format_time: format 23 hours to human" (
    set --local hour 3600000 # express as milliseconds
    _pure_format_time (math "23*$hour") $threshold
) = '23h'

@test "_pure_format_time: format 24 hours as a day to human" (
    set --local hour 3600000 # express as milliseconds
    _pure_format_time (math "24*$hour") $threshold
) = '1d'

@test "_pure_format_time: format days to human" (
    set --local day 86400000 # express as milliseconds
    _pure_format_time (math "100*$day") $threshold
) = '100d'

@test "_pure_format_time: format complex duration to human" (
    _pure_format_time 123456789 $threshold
) = '1d 10h 17m 36s'

@test "_pure_format_time_subseconds: empty when below threshold" (
    set --local milliseconds 953 # express as milliseconds
    set --local threshold 1000 # express as milliseconds
    _pure_format_time_subseconds $milliseconds $threshold
) = $EMPTY

@test "_pure_format_time_subseconds: show subsecond when above threshold" (
    set --local milliseconds 1053 # express as milliseconds
    set --local threshold 1000 # express as milliseconds
    _pure_format_time_subseconds $milliseconds $threshold
) = '.05'

@test "_pure_format_time_subseconds: keep precision with zero-ending" (
    set --local milliseconds 1200 # express as milliseconds
    set --local threshold 1000 # express as milliseconds
    _pure_format_time_subseconds $milliseconds $threshold
) = '.20'
