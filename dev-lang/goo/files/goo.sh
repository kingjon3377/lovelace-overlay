#!/bin/sh
: ${GOO_EVAL_MODE:=ast}
export GOO_EVAL_MODE
exec /usr/bin/g2c "$@"
