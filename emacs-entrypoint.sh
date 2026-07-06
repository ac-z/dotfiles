#!/bin/bash
# Emacs container entrypoint.

if [ -n "${FALLBACK_SHELL:-}" ]; then
    exec "$FALLBACK_SHELL"
fi

exec emacs --fg-daemon
