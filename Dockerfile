# Use Node 24 (stable/latest tag)
FROM node:24

# Create app dir
WORKDIR /workspace

# Copy package files and configs first (so layer caching works when only code changes)
COPY package.json package-lock.json tsconfig.json astro.config.mjs tailwind.config.mjs ./

# Copy src and public for the image (helps npm install native deps if any)
# These will be overwritten by the host bind mount during development (that's intended)
COPY src ./src
COPY public ./public

# Install deps (dev deps included since this is development)
RUN npm ci

# Expose default Astro/Vite dev port
EXPOSE 4321

# Environment defaults for development
ENV NODE_ENV=development
ENV HOST=0.0.0.0
# If you run into FS watch problems on Docker Desktop (mac/win), uncomment the next env line:
# ENV CHOKIDAR_USEPOLLING=true

# Run the dev script and forward args to the underlying command with `--`
# The additional `-- --host 0.0.0.0` ensures Vite/astro listens on all interfaces.
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
