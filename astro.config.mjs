// @ts-check
import { defineConfig, envField } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';

// https://astro.build/config
export default defineConfig({
  build: {
    format: 'preserve',
  },
  env: {
    schema: {
      PUBLIC_AWS_API_GATEWAY_ENDPOINT: envField.string({ context: "client", access: "public", optional: false }),
    }
  },
  output: "static",
  vite: {
    plugins: [tailwindcss()]
  }
});