#! /bin/sh

echo ">>>>> Setup Database"
mix ecto.create && mix ecto.migrate

echo ">>>>> Starting Phoenix Server"
mix phoenix.server
