FROM node:20-slim

# Install Claude Code CLI globally
RUN npm install -g @anthropic-ai/claude-code

# Skip the interactive onboarding
ENV CLAUDE_CODE_SKIP_ONBOARDING=1

# Pre-create Claude config to skip interactive setup
RUN mkdir -p /root/.claude && echo '{"hasCompletedOnboarding": true}' > /root/.claude/.claude.json

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

EXPOSE 3456

CMD ["node", "dist/server/standalone.js"]
