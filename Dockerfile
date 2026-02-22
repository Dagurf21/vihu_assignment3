# ---------- build stage ----------
FROM oven/bun:latest AS build

WORKDIR /app

COPY package.json bun.lock ./
RUN bun install --frozen-lockfile

COPY . .

# ---------- production ----------
FROM oven/bun:slim

WORKDIR /app

COPY --from=build /app/package.json /app/bun.lock ./
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/src ./src

EXPOSE 3000

CMD ["bun", "run", "start"]
