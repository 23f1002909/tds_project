FROM python:3.12-slim-bookworm

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download and install uv
RUN curl -LsS https://astral.sh/uv/install.sh | sh

# Ensure the installed binary is on the `PATH`
ENV PATH="/root/.local/bin:$PATH"

# Install FastAPI and Uvicorn
RUN pip install --no-cache-dir fastapi uvicorn

# Set up the application directory
WORKDIR /app

# Copy everything into the container
COPY . /app


# Expose the port the application will run on
EXPOSE 8000

# Run the application using uv
CMD ["uv", "run", "app.py", "--host", "0.0.0.0", "--port", "8000"]