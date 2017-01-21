#!/usr/bin/env bash

set -e

usage() {
  echo "usage: dev.sh <command> [<args>]
Some useful commands are:
start          Start your docker containers
stop           Stop your docker containers
install        Install dependencies
restart        Restart your docker containers
watch          Restart the docker process when files change
watch-logs     View the logs of your running docker containers
mix            Run the mix command within the container
npm            Run the npm command within the container
destroy        Kills your docker containers, removes them, and removes docker images"
}

start() {
    docker-compose up --build -d service database
    watch-logs service database
}

stop() {
    # docker-compose stop 2> /dev/null || true
    docker-compose kill
    docker-compose rm -f
}

install() {
    mkdir -p ./_build
    mkdir -p ./deps
    mkdir -p ./node_modules
    docker-compose up deps-install
}
get_os() {
  if [ "$(uname)" == "Darwin" ]; then
    echo "OSX";
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo "Linux";
  fi
}

set_env_vars() {
  export SERVICE_SSH_PWD=$HOME/.ssh
  export SERVICE_PWD="$(pwd)"
}

watch-logs() {
    docker-compose logs -f "$@"
}

main() {
  set_env_vars
  command="$1"
  case $command in
    "" | "-h" | "--help")
      usage
      ;;
    "start")
      start
      ;;
    "get-os")
      get_os
      ;;
    "stop")
      stop
      ;;
    "install")
      install
      ;;
    "restart")
      restart
      ;;
    "watch-logs")
      watch-logs
      ;;
    "npm")
      shift
      npm "$@"
      ;;
    "destroy")
      destroy
      ;;
    *)
      usage
      ;;
  esac
}

main "$@"
