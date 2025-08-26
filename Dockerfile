# Step 1: Dependencies
FROM node:20-alpine AS deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci

# Step 2: Build
FROM node:20-alpine AS builder
WORKDIR /app
COPY . .
COPY --from=deps /app/node_modules ./node_modules
# Build specifying the src folder
RUN npx next build src

# Step 3: Production image
FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
# Copy build output from src folder
COPY --from=builder /app/src/public ./public
COPY --from=builder /app/src/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
EXPOSE 3000
# Start the app pointing to src folder
CMD ["npx", "next", "start", "-p", "3000", "-d", "src"]
