FROM node:18-alpine

# 1. Enable Corepack so pnpm is available
RUN corepack enable

WORKDIR /app

# 2. Copy only the files needed for install
COPY package.json pnpm-lock.yaml tsconfig.json ./

# 3. Install deps via pnpm
RUN pnpm install --frozen-lockfile

# 4. Copy the rest of your code & build
COPY . .
RUN pnpm run build

# 5. Expose and run
EXPOSE 4000
CMD ["node", "dist/server.js"]
