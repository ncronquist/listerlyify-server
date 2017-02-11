#!/usr/bin/env bash

set -e

usage() {
  echo "usage: dev.sh <command> [<args>]
Some useful commands are:
start          Start the service and database
restart        Restart the service and database
stop           Stop and remove listerlyify containers
install        Install dependencies
mix            Run mix commands within the container
watch-logs     View the logs of your running docker containers"
}

start() {
    docker-compose up --build -d service database
    watch-logs service database
}

restart() {
    docker-compose kill
    docker-compose up --build -d service database
    watch-logs service database
}

stop() {
    docker-compose kill
    docker-compose rm -f
    docker network prune -f
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

mix() {
    echo "mix $@"
    docker-compose exec service mix "$@"
}

set_env_vars() {
  export SERVICE_SSH_PWD=$HOME/.ssh
  export SERVICE_PWD="$(pwd)"
}

watch-logs() {
    if [ "$1" == "" ]; then
        docker-compose logs -f service database
    else
        docker-compose logs -f "$@"
    fi
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
    "restart")
      restart
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
    "mix")
      shift
      mix "$@"
      ;;
    "watch-logs")
      shift
      watch-logs "$@"
      ;;
    *)
      usage
      ;;
  esac
}

main "$@"
