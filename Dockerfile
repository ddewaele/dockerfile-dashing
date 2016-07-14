FROM frvi/ruby

MAINTAINER ddewaele <ddewaele@gmail.com>

RUN gem install bundle dashing oauth2 gemrat
RUN mkdir /dashing && \
    dashing new dashing && \
    cd /dashing && \
    gemrat oauth2 && \
    bundle && \
    mkdir /dashing/templates && \
    ln -s /dashing/templates /templates && \
    ln -s /dashing/dashboards /dashboards && \
    ln -s /dashing/jobs /jobs && \
    ln -s /dashing/assets /assets && \
    ln -s /dashing/lib /lib-dashing && \
    ln -s /dashing/public /public && \
    ln -s /dashing/widgets /widgets && \
    mkdir /dashing/config && \
    mv /dashing/config.ru /dashing/config/config.ru && \
    ln -s /dashing/config/config.ru /dashing/config.ru && \
    ln -s /dashing/config /config

COPY run.sh /

VOLUME ["/dashboards", "/jobs", "/lib-dashing", "/config", "/public", "/widgets", "/assets", "/templates"]

ENV PORT 3030
EXPOSE $PORT
WORKDIR /dashing

CMD ["/run.sh"]

