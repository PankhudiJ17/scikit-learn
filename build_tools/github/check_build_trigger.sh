#!/bin/bash

set -e
set -x

COMMIT_MSG=$(git log --no-merges -1 --oneline)
# echo "Commit message: $COMMIT_MSG"  # Debugging line

# # Check the event name and whether the build should be triggered
# echo "Event Name: $GITHUB_EVENT_NAME"  # Debugging line
# The commit marker "[cd build]" will trigger the build when required
if [[ "$GITHUB_EVENT_NAME" == schedule ||
      "$GITHUB_EVENT_NAME" == workflow_dispatch ||
      "$COMMIT_MSG" =~ \[cd\ build\] ]]; then
      #"$GITHUB_REF" == "refs/heads/main" ]]; then
    echo "build=true" >> $GITHUB_OUTPUT
else
    echo "build=false" >> $GITHUB_OUTPUT  # Optional: Output 'false' for debugging
fi
