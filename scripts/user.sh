#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage:"
    echo "  user.sh USER"
    exit 3
fi

USER="$1"

useradd -m ${USER}
passwd ${USER}
