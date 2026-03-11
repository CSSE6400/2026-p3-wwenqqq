FROM python:3.13-slim

# Install pipx
RUN apt-get update && apt-get install -y pipx
RUN pipx ensurepath

# Install poetry
RUN pipx install poetry

# Set working directory
WORKDIR /app

# Copy dependency file first (layer caching optimization)
COPY pyproject.toml ./
RUN pipx run poetry install --no-root

# Copy application code
COPY todo todo

# Start command
CMD ["pipx", "run", "poetry", "run", "flask", "--app", "todo", "run", "--host", "0.0.0.0", "--port", "6400"]
