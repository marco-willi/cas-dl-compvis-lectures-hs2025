FROM python:3.13-slim

LABEL maintainer="Marco Willi <marco.willi@fhnw.ch>"
LABEL description="CAS DL - Computer Vision with Deep Learning HS2025"

ENV DEBIAN_FRONTEND=noninteractive \
    PIP_NO_CACHE_DIR=1 \
    POETRY_VIRTUALENVS_CREATE=true \
    POETRY_VIRTUALENVS_IN_PROJECT=false

# -------- System deps --------
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates git build-essential pkg-config \
    graphviz ghostscript gdebi-core \
    ffmpeg libglib2.0-0 libsm6 libxext6 libxrender1 libgl1 \
    texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended latexmk texinfo \
 && rm -rf /var/lib/apt/lists/*

# -------- Quarto --------
RUN curl -fsSL -o /tmp/quarto.deb https://quarto.org/download/latest/quarto-linux-amd64.deb \
 && gdebi --non-interactive /tmp/quarto.deb \
 && rm -f /tmp/quarto.deb

# -------- Non-root user --------
ARG USER=jovyan
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID $USER && useradd -m -u $UID -g $GID -s /bin/bash $USER

USER $USER
ENV HOME=/home/${USER}
ENV PATH="${HOME}/.local/bin:${PATH}"
# Keep virtualenvs in the user's home (outside /workspace bind mount)
ENV POETRY_VIRTUALENVS_PATH=${HOME}/.venvs

# -------- Poetry --------
RUN curl -sSL https://install.python-poetry.org | python3 - && poetry --version

# -------- Project layout --------
WORKDIR /workspace

# Copy lockfiles first to leverage Docker layer caching
COPY --chown=${USER}:${GID} pyproject.toml poetry.lock* /workspace/
RUN poetry install --no-interaction --no-root --with dev

# Stable symlink to the just-created Poetry venv (all user-owned, no /opt perms needed)
RUN VENV_DIR="$(poetry env info -p)" \
 && ln -sfn "$VENV_DIR" "${HOME}/.venv"

# Put venv first on PATH and tell Quarto to use it
ENV PATH="${HOME}/.venv/bin:${PATH}"
ENV QUARTO_PYTHON="${HOME}/.venv/bin/python"

# ---- Ensure JupyterLab is present (remove if it's in your pyproject) ----
RUN python -m pip install --no-cache-dir jupyterlab ipywidgets

# -------- Runtime --------
EXPOSE 8888 6006
CMD ["jupyter", "lab", \
     "--ServerApp.token=", \
     "--ServerApp.password=", \
     "--ServerApp.allow_origin=*", \
     "--ServerApp.allow_remote_access=True", \
     "--ServerApp.ip=0.0.0.0", \
     "--ServerApp.port=8888", \
     "--ServerApp.root_dir=/workspace", \
     "--ServerApp.open_browser=False"]
