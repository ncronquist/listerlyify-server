#! /bin/sh

echo ">>>>> Install Elixir Deps"
mix do deps.get, deps.compile

echo ">>>>> Install Node Modules"
npm install

echo ">>>>> Build Brunch"
brunch build
