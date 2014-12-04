#!/bin/bash
set -e
THIS_DIR="$(dirname "$0")"
"$THIS_DIR/run_backend_tests.sh"
"$THIS_DIR/run_browser_tests.sh"
