FROM ghost:5-alpine

# Copy only theme files (exclude Dockerfile, .git, etc.)
COPY --chown=node:node package.json /tmp/theme/
COPY --chown=node:node *.hbs /tmp/theme/
COPY --chown=node:node partials/ /tmp/theme/partials/
COPY --chown=node:node assets/ /tmp/theme/assets/

# Move theme into Ghost's themes directory
RUN mkdir -p /var/lib/ghost/content/themes/dbu-alumni && \
    cp -r /tmp/theme/* /var/lib/ghost/content/themes/dbu-alumni/ && \
    rm -rf /tmp/theme

# Railway sets PORT dynamically — Ghost listens on 2368 by default.
# Tell Ghost to use SQLite (no external DB needed) and bind to 0.0.0.0
ENV database__client=sqlite3
ENV database__connection__filename=/var/lib/ghost/content/data/ghost.db
ENV database__useNullAsDefault=true
ENV NODE_ENV=production

# Ghost's base image already has the right entrypoint and CMD — don't override them.
# Set the url via Railway env var: url=https://your-domain.up.railway.app
