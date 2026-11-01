# Open-Marketplace MVP

Monorepo modulaire (Turborepo/NPM Workspaces) pour une marketplace multi-vendeurs inspirée d'Amazon/Alibaba, déployable sur Free Tiers puis scalable vers Kubernetes/AWS ECS sans réécriture.

## Stack
- Frontend: Next.js 15+ (App Router) sur Vercel
- Data: PostgreSQL (Supabase) + Prisma/Drizzle
- Storage: Supabase Buckets (CDN)
- Search: PostgreSQL Full-Text Search (GIN)
- CI: GitHub Actions

## Structure
```
apps/web          # application Next.js
packages/shared-types
packages/database
packages/security
packages/ui
```

## Démarrage
1. `npm install`
2. `cp .env.example .env` et renseigner les clés
3. `docker compose up -d`
4. `npm run dev`
5. `npm run lint && npm run typecheck && npm run build`

## Qualité
- ESLint strict + TypeScript strict
- Husky pre-commit (lint/typecheck/format)
- Vitest (unit/intégration) + Playwright (E2E)
