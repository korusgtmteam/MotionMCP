FROM node:20-slim

# Install necessary system dependencies
RUN apt-get update && apt-get install -y ca-certificates

# 1. Install the proxy tool globally
RUN npm install -g @juhemcp/mcp-proxy

# 2. We don't need to install motionmcp locally if we use npx, 
# but installing it speeds up boot time.
# Note: If 'motionmcp' is not in the public npm registry, 
# we rely on npx fetching it at runtime.

# 3. Expose the port we will use
ENV PORT=8080
EXPOSE 8080

# 4. Start the proxy server
# This commands the proxy to listen on 0.0.0.0:8080 
# and forward traffic to "npx motionmcp"
CMD npx -y @juhemcp/mcp-proxy --sse-port 8080 --sse-host 0.0.0.0 -- npx -y motionmcp
