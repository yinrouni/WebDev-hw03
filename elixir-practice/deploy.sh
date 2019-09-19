#!/bin/bash

export MIX_ENV=prod
export PORT=4790
export NODEBIN=`pwd`/assets/node_modules/.bin
export PATH="$PATH:$NODEBIN"

echo "Building..."

mix deps.get
mix compile
(cd assets && npm install)
(cd assets && webpack --mode production)
mix phx.digest

echo "Generating release..."
mix release

#echo "Stopping old copy of app, if any..."
#_build/prod/rel/practice/bin/practice stop || true

echo "Starting app..."

_build/prod/rel/practice/bin/practice start

