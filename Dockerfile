# ===== BUILDER =====
FROM python:3.12-slim AS builder
ENV DEBIAN_FRONTEND=noninteractive PIP_NO_CACHE_DIR=1 PIP_DISABLE_PIP_VERSION_CHECK=1

# Build tools only in builder
RUN apt-get update && apt-get install -y --no-install-recommends \
      curl ca-certificates git build-essential pkg-config \
  && rm -rf /var/lib/apt/lists/*

# Install Poetry and put it on PATH before using it
ENV PATH="/root/.local/bin:${PATH}"
RUN curl -sSL https://install.python-poetry.org | python3 - && poetry --version

# --- Create the final venv FIRST and make it the active Python ---
RUN python -m venv /opt/venv
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="/opt/venv/bin:${PATH}"

# Tell Poetry to install into the current interpreter (no extra Poetry venv)
RUN poetry config virtualenvs.create false

WORKDIR /workspace
COPY pyproject.toml poetry.lock* /workspace/

# Install only requested groups (default + dev here)
ARG WITH_GROUPS=dev
RUN poetry install --no-interaction --no-root --with "${WITH_GROUPS}" --no-ansi \
 && python -m pip cache purge || true


# ===== RUNTIME =====
FROM python:3.12-slim AS runtime
ENV DEBIAN_FRONTEND=noninteractive PIP_NO_CACHE_DIR=1 PIP_DISABLE_PIP_VERSION_CHECK=1

# Minimal runtime libs (OpenCV/video), Quarto installer, and make (if you use Makefiles at runtime)
RUN apt-get update && apt-get install -y --no-install-recommends \
      curl ca-certificates git ffmpeg \
      libglib2.0-0 libsm6 libxext6 libxrender1 libgl1 \
      gdebi-core \
      make \
  && rm -rf /var/lib/apt/lists/*

# (Optional) Quarto
RUN curl -fsSL -o /tmp/quarto.deb https://quarto.org/download/latest/quarto-linux-amd64.deb \
 && gdebi --non-interactive /tmp/quarto.deb \
 && rm -f /tmp/quarto.deb

# Non-root user
ARG USER=jovyan UID=1000 GID=1000
RUN groupadd -g $GID $USER && useradd -m -u $UID -g $GID -s /bin/bash $USER

# Bring the venv built in the builder stage
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:${PATH}"

RUN /opt/venv/bin/python -m pip install --no-cache-dir poetry \
 && ln -s /opt/venv/bin/poetry /usr/local/bin/poetry

# Quick runtime sanity checks (remove if you like)
RUN which pre-commit && pre-commit --version || true \
 && which poetry && poetry --version

USER $USER
WORKDIR /workspace
EXPOSE 8888 6006

# Launch JupyterLab via module form (robust to shebang issues)
CMD ["/opt/venv/bin/python", "-m", "jupyterlab", \
     "--ServerApp.token=", \
     "--ServerApp.password=", \
     "--ServerApp.allow_origin=*", \
     "--ServerApp.allow_remote_access=True", \
     "--ServerApp.ip=0.0.0.0", \
     "--ServerApp.port=8888", \
     "--ServerApp.root_dir=/workspace", \
     "--ServerApp.open_browser=False"]
