
#!/bin/bash
# Modified from Prof. Tuck's original deploy script

export PORT=8000
export MIX_ENV=prod
DIR=$1

if [ ! -d "$DIR" ]; then
  printf "Usage: ./deploy.sh <path>\n"
  exit
fi

echo "Deploy to [$DIR]"

mix deps.get
(cd assets && npm install)
(cd assets && brunch build)
mix phx.digest
mix release --env=prod

$DIR/bin/nu_mart stop || true

mix ecto.migrate