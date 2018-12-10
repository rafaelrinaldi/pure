function __format_time -d "Format milliseconds to a human readable format"
    set -l milliseconds $argv[1]
    set -l seconds (math -s0 "$milliseconds / 1000 % 60")
    set -l minutes (math -s0 "$milliseconds / 60000 % 60")
    set -l hours (math -s0 "$milliseconds / 3600000 % 24")
    set -l days (math -s0 "$milliseconds / 86400000")
    set -l time
    set -l threshold $argv[2]

    if test $days -gt 0
        set time (printf "$time%sd " $days)
    end

    if test $hours -gt 0
        set time (printf "$time%sh " $hours)
    end

    if test $minutes -gt 0
        set time (printf "$time%sm " $minutes)
    end

    if test $seconds -gt $threshold
        set time (printf "$time%ss " $seconds)
    end

    echo -e $time
end
