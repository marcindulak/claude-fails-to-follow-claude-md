FROM debian:trixie-slim

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    nodejs \
    npm \
    python3

RUN node --version
RUN npm --version
RUN python3 --version

ENV PATH="/root/.local/bin:$PATH"

RUN npm install -g @google/gemini-cli
RUN gemini --version

RUN npm i -g @openai/codex
RUN codex --version

# Place claude installation last, since it often fails due to excessive memory use
# https://github.com/anthropics/claude-code/issues/11315#issuecomment-4595072574
# RUN curl -fsSL https://claude.ai/install.sh | bash -s stable
RUN curl -sL https://claude.ai/install.sh | sed 's/ install / install --force /' | bash -s stable
ENV DISABLE_AUTOUPDATER=1
RUN claude -v

CMD ["sleep infinity"]
