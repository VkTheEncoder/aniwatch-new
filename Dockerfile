FROM node:18-alpine
WORKDIR /app

# 1) Enable corepack (bundled with Node 18+)
RUN corepack enable

# 2) Fetch & activate pnpm@latest (or any specific version)
RUN corepack prepare pnpm@latest --activate

# 3) Now your pnpm binary is ready
COPY package.json pnpm-lock.yaml tsconfig.json ./
RUN pnpm install --frozen-lockfile

COPY . .
RUN pnpm run build

EXPOSE 4000
CMD ["node", "dist/server.js"]
