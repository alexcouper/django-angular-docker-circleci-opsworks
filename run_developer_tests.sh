#!/bin/bash
fig up &
FIGPID=$!
npm run protractor
kill $FIGPID
