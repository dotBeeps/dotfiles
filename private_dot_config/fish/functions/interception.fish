#!/usr/bin/env fish

function redirect

    while read -l event
        echo event: $event
    end
end