# ---- base ----
FROM node:20-alpine AS base
WORKDIR /app

# ---- dependencies-installer ----
FROM base AS dependencies-installer
COPY package.json package-lock.json* ./
RUN npm ci --ignore-scripts

# ---- local-developer ----
FROM dependencies-installer AS local-developer
COPY . .
EXPOSE 3000
CMD ["npm", "run", "dev", "--workspace=apps/web"]

# ---- production-builder ----
FROM dependencies-installer AS production-builder
COPY . .
RUN npm run build --workspace=apps/web

# ---- production-runner ----
FROM node:20-alpine AS production-runner
WORKDIR /app
ENV NODE_ENV=production
COPY --from=production-builder /app/apps/web/.next ./.next
COPY --from=production-builder /app/apps/web/public ./public
COPY --from=production-builder /app/package.json ./
EXPOSE 3000
CMD ["npm", "run", "start", "--workspace=apps/web"]
EOF