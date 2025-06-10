# 1. Base image with Corepack for pnpm
FROM node:18-alpine

WORKDIR /app

# 2. Enable Corepack & pin pnpm to the version in your package.json
RUN corepack enable \
 && corepack prepare pnpm@8.8.1 --activate

# 3. Copy manifests & install deps
COPY package.json pnpm-lock.yaml tsconfig.json tsup.config.ts ./
RUN pnpm install --frozen-lockfile

# 4. Copy all source code
COPY src ./src

# 5. (Optional) If you created a server wrapper, copy it too:
#    e.g. src/server.ts → dist/server.js after build
# COPY server.ts ./

# 6. Build everything
RUN pnpm run build

# 7. Expose your API port
EXPOSE 4000

# 8. Start the server entrypoint
#    Assumes you added src/server.ts and it compiles to dist/server.js
CMD ["node", "dist/server.js"]
