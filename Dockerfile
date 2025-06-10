# 1. Start from Node 18 on Alpine
FROM node:18-alpine

WORKDIR /app

# 2. Copy only what we need for install
COPY package.json pnpm-lock.yaml tsconfig.json tsup.config.ts ./

# 3. Install pnpm globally via npm, then install deps
RUN npm install -g pnpm@8.8.1 \
 && pnpm install --frozen-lockfile

# 4. Copy the rest of your code
COPY src ./src

# 5. Build the library (and your server wrapper)
RUN pnpm run build

# 6. Expose the port your server will listen on
EXPOSE 4000

# 7. Run the compiled server
CMD ["node", "dist/server.js"]
