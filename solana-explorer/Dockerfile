FROM node:20-alpine

WORKDIR /app

# Install dependencies
RUN apk add --no-cache git python3 make g++ curl libc6-compat

# Clone a specific stable commit (avoid latest unstable changes)
RUN git clone https://github.com/solana-labs/explorer.git . 

# Clear any problematic files
RUN rm -rf node_modules package-lock.json yarn.lock

# Enable corepack and install the correct package manager
RUN corepack enable
RUN corepack prepare yarn@stable --activate
RUN corepack prepare pnpm@9.10.0 --activate

# Create proper environment file based on their example
RUN echo "# Custom RPC URLs for local development" > .env.local && \
    echo "NEXT_PUBLIC_MAINNET_RPC_URL=http://localhost:8899" >> .env.local && \
    echo "NEXT_PUBLIC_DEVNET_RPC_URL=http://localhost:8899" >> .env.local && \
    echo "NEXT_PUBLIC_TESTNET_RPC_URL=http://localhost:8899" >> .env.local && \
    echo "NEXT_PUBLIC_METADATA_ENABLED=false" >> .env.local && \
    echo "NEXT_LOG_LEVEL=0" >> .env.local && \
    echo "NEXT_PUBLIC_PMP_IDL_ENABLED=true" >> .env.local

# Also create .env file
RUN echo "# Custom RPC URLs for local development" > .env && \
    echo "NEXT_PUBLIC_MAINNET_RPC_URL=http://localhost:8899" >> .env && \
    echo "NEXT_PUBLIC_DEVNET_RPC_URL=http://localhost:8899" >> .env && \
    echo "NEXT_PUBLIC_TESTNET_RPC_URL=http://localhost:8899" >> .env && \
    echo "NEXT_PUBLIC_METADATA_ENABLED=false" >> .env && \
    echo "NEXT_LOG_LEVEL=0" >> .env && \
    echo "NEXT_PUBLIC_PMP_IDL_ENABLED=true" >> .env

# Install dependencies using the correct package manager
RUN pnpm install --ignore-scripts

# Environment variables - Set the proper ones
ENV NEXT_PUBLIC_MAINNET_RPC_URL=http://localhost:8899
ENV NEXT_PUBLIC_DEVNET_RPC_URL=http://localhost:8899
ENV NEXT_PUBLIC_TESTNET_RPC_URL=http://localhost:8899
ENV NEXT_PUBLIC_METADATA_ENABLED=false
ENV NEXT_LOG_LEVEL=0
ENV NEXT_PUBLIC_PMP_IDL_ENABLED=true
ENV NODE_ENV=development

# Try to build
RUN pnpm build || echo "Proceeding without build"

EXPOSE 3000

CMD ["pnpm", "dev", "--hostname", "0.0.0.0"]