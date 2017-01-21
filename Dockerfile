FROM aweiker/elixir-build:1.4.0-19.1.0
MAINTAINER Nick Cronquist <nick@ncronquist.com>

ENV PATH=/opt/listerlyify/node_modules/.bin:$PATH

RUN mkdir -p /opt/listerlyify
WORKDIR /opt/listerlyify

ADD ./mix.exs /opt/listerlyify/mix.exs
ADD ./mix.lock /opt/listerlyify/mix.lock
ADD ./package.json /opt/listerlyify/package.json
ADD ./brunch-config.js /opt/listerlyify/brunch-config.js
ADD ./node_modules/ /opt/concur/receipt_service/node_modules/
ADD ./run-install /opt/listerlyify/run-install

RUN chmod 550 /opt/listerlyify/run-install 

COPY docker-entrypoint.sh /opt/entrypoint.sh
ENTRYPOINT ["/opt/entrypoint.sh"]

EXPOSE 4000

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["/usr/bin/mix", "phoenix.server"]
