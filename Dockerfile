FROM ghost:5-alpine

COPY --chown=node:node . /var/lib/ghost/content/themes/dbu-alumni/

ENV NODE_ENV=production
ENV url=https://your-site.up.railway.app

EXPOSE 2368
CMD ["node", "current/index.js"]
