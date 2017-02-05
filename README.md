# Listerlyify

## Run Listerlyify Server Locally

Listerlyify-Server will be available at [`localhost:4000`](http://localhost:4000) from your browser.

### Run with Docker
- Install the dependencies
```sh
./dev.sh install
```
- Start the app
```sh
./dev.sh start
```
- Restart the app
```sh
./dev.sh restart
```
- Stop the app and cleanup the docker containers
```sh
./dev.sh stop
```
- Run mix commands in the container
```sh
./dev.sh mix [command]
```

### Run with Elixir, Erlang, and Node Installed Locally
- Install dependencies
```sh
mix deps.get
```
- Create and migrate your database
```sh
mix ecto.create && mix ecto.migrate
```
- Install Node.js dependencies
```sh
npm install
```
- Start Phoenix endpoint with
```sh
mix phoenix.server
```

## Learn more
- Ready to run in production? [Check the Phoenix deployment guides](http://www.phoenixframework.org/docs/deployment).
- Phoenix Official website: http://www.phoenixframework.org/
- Phoenix Guides: http://phoenixframework.org/docs/overview
- Phoenix Docs: https://hexdocs.pm/phoenix
- Phoenix Mailing list: http://groups.google.com/group/phoenix-talk
- Phoenix Source: https://github.com/phoenixframework/phoenix
