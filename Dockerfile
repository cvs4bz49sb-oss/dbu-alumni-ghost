FROM ghost:5-alpine

# Copy only theme files
COPY --chown=node:node package.json /tmp/theme/
COPY --chown=node:node *.hbs /tmp/theme/
COPY --chown=node:node partials/ /tmp/theme/partials/
COPY --chown=node:node assets/ /tmp/theme/assets/

# Move theme into Ghost's themes directory
RUN mkdir -p /var/lib/ghost/content/themes/dbu-alumni && \
    cp -r /tmp/theme/* /var/lib/ghost/content/themes/dbu-alumni/ && \
    rm -rf /tmp/theme

# Startup script that maps Railway's PORT to Ghost's config
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

ENV database__client=sqlite3
ENV database__connection__filename=/var/lib/ghost/content/data/ghost.db
ENV database__useNullAsDefault=true
ENV NODE_ENV=production
ENV url=https://dbu-alumni.up.railway.app

CMD ["start.sh"]
