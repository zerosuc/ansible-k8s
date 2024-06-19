#!/usr/bin/env bash

function flink::clear_flink_logs() {

    log_dir="/data/flink/logs"

    if [ -d "$log_dir" ]; then
        find "$log_dir" -name "*.log" -type f -mtime +3 -exec truncate -s 0 {} \;
    fi

}

flink::clear_flink_logs