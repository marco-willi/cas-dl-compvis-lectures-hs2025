# ===== BUILDER STAGE =====
FROM python:3.12-slim AS builder

ENV DEBIAN_FRONTEND=noninteractive \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates git build-essential pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry globally for builder
ENV PATH="/root/.local/bin:${PATH}"
RUN curl -sSL https://install.python-poetry.org | python3 - \
    && poetry --version

WORKDIR /tmp/build

# Copy dependency files from project root (build context is parent of .devcontainer)
# The build context (..) means we're at the project root
COPY ./pyproject.toml ./poetry.lock* /tmp/build/

# Verify files were copied and check contents
RUN echo "=== Checking copied files ===" \
    && ls -la /tmp/build/ \
    && echo "" \
    && echo "=== pyproject.toml first 30 lines ===" \
    && head -30 pyproject.toml \
    && echo "" \
    && echo "=== Checking for dependencies section ===" \
    && grep -A 10 "tool.poetry.dependencies" pyproject.toml || echo "Dependencies section not found!"

# Create venv at /opt/venv (final destination)
RUN python -m venv /opt/venv

# Configure Poetry to NOT create virtualenvs and install into system Python
RUN poetry config virtualenvs.create false

# Activate venv and install dependencies
# Set VIRTUAL_ENV and PATH so poetry installs into the venv
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="/opt/venv/bin:${PATH}"

RUN pip install --upgrade pip setuptools wheel \
    && echo "=== About to run poetry install ===" \
    && echo "Poetry version: $(poetry --version)" \
    && echo "Python: $(which python)" \
    && echo "Pip: $(which pip)" \
    && poetry install --no-interaction --no-root --with dev --no-ansi --verbose \
    && python -m pip cache purge || true \
    && echo "=== Installed packages ===" \
    && pip list

# ===== RUNTIME STAGE =====
FROM python:3.12-slim AS runtime

ENV DEBIAN_FRONTEND=noninteractive \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Install runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl wget ca-certificates git \
    ffmpeg libglib2.0-0 libsm6 libxext6 libxrender1 libgl1 \
    gdebi-core make graphviz \
    bash bash-completion \
    pdf2svg fontconfig xz-utils tar perl \
    && rm -rf /var/lib/apt/lists/*

# Install Quarto
RUN curl -fsSL -o /tmp/quarto.deb \
    https://quarto.org/download/latest/quarto-linux-amd64.deb \
    && gdebi --non-interactive /tmp/quarto.deb \
    && rm -f /tmp/quarto.deb \
    && quarto --version



# # Install TinyTeX using curl instead of wget
# RUN curl -sL https://yihui.org/tinytex/install-bin-unix.sh | sh && \
#     if [ ! -d "$HOME/.TinyTeX" ]; then \
#         echo "ERROR: TinyTeX installation failed - directory not found at $HOME/.TinyTeX" && \
#         exit 1; \
#     fi

# # Configure TinyTeX and install packages BEFORE moving
# RUN export PATH="$HOME/.TinyTeX/bin/$(uname -m)-linux:$PATH" && \
#     tlmgr option repository http://mirror.ctan.org/systems/texlive/tlnet && \
#     tlmgr update --self && \
#     tlmgr install \
#         standalone pgf xcolor geometry preview \
#         etoolbox varwidth relsize \
#         collection-latexextra collection-fontsrecommended

# # Now move TinyTeX to /opt
# RUN mkdir -p /opt && \
#     mv $HOME/.TinyTeX /opt/TinyTeX && \
#     echo "TinyTeX successfully moved to /opt/TinyTeX"

# # Create symlinks for TinyTeX binaries
# RUN if [ -d "/opt/TinyTeX/bin" ]; then \
#         ln -s /opt/TinyTeX/bin/*/tlmgr /usr/local/bin/tlmgr && \
#         ln -s /opt/TinyTeX/bin/*/pdflatex /usr/local/bin/pdflatex && \
#         ln -s /opt/TinyTeX/bin/*/xelatex /usr/local/bin/xelatex && \
#         ln -s /opt/TinyTeX/bin/*/lualatex /usr/local/bin/lualatex; \
#     else \
#         echo "ERROR: TinyTeX bin directory not found" && \
#         exit 1; \
#     fi

# Create non-root user
ARG USER=jovyan
ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID $USER \
    && useradd -m -u $UID -g $GID -s /bin/bash $USER \
    && mkdir -p /opt/venv /home/$USER/.poetry-cache \
    && chown -R ${UID}:${GID} /opt/venv /home/$USER/.poetry-cache

# Copy the built venv from builder to /opt/venv (outside workspace mount)
COPY --from=builder --chown=${UID}:${GID} /opt/venv /opt/venv

# Switch to non-root user BEFORE installing Poetry
USER $USER
WORKDIR /workspace

RUN quarto install tinytex --update-path

# Install Poetry as the jovyan user (in their home directory)
ENV PATH="/home/${USER}/.local/bin:${PATH}"
RUN curl -sSL https://install.python-poetry.org | python3 - \
    && /home/${USER}/.local/bin/poetry --version

# Configure Poetry for the user
RUN poetry config virtualenvs.in-project false \
    && poetry config virtualenvs.create true \
    && poetry config cache-dir /home/jovyan/.poetry-cache

# Setup shell integration for automatic venv activation
RUN echo '' >> ~/.bashrc \
    && echo '# Poetry path' >> ~/.bashrc \
    && echo 'export PATH="/home/jovyan/.local/bin:$PATH"' >> ~/.bashrc \
    && echo '' >> ~/.bashrc \
    && echo '# Poetry virtual environment activation' >> ~/.bashrc \
    && echo 'if [ -f "/opt/venv/bin/activate" ]; then' >> ~/.bashrc \
    && echo '    source /opt/venv/bin/activate' >> ~/.bashrc \
    && echo '    export VIRTUAL_ENV="/opt/venv"' >> ~/.bashrc \
    && echo '    export PATH="/opt/venv/bin:$PATH"' >> ~/.bashrc \
    && echo 'fi' >> ~/.bashrc \
    && echo '' >> ~/.bashrc

# Setup bash profile to source bashrc for login shells
RUN echo '[ -f ~/.bashrc ] && . ~/.bashrc' >> ~/.bash_profile

# Expose ports
EXPOSE 8888 6006

# Default command (can be overridden)
CMD ["/bin/bash", "-l"]
