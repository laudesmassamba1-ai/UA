# ---- base ----
FROM node:20-alpine AS base
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci --ignore-scripts

# ---- dev ----
FROM base AS dev
COPY . .
EXPOSE 3000
CMD ["npm", "run", "dev", "--workspace=apps/web"]

# ---- builder ----
FROM base AS builder
COPY . .
RUN npm run build --workspace=apps/web

# ---- runner ----
FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app/apps/web/.next ./.next
COPY --from=builder /app/apps/web/public ./public
COPY --from=builder /app/package.json ./
EXPOSE 3000
CMD ["npm", "run", "start", "--workspace=apps/web"]
EOF