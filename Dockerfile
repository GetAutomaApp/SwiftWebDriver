# Define build arguments with updated values
FROM swift:6.0.0-jammy

# Set environment variables for locale
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# Install dependencies in one layer to reduce image size
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    locales locales-all \
    wget \
    lsof \
    dnsutils \
    netcat-openbsd \
    net-tools \
    curl \
    jq \
    ruby \
    ruby-dev \
    libsqlite3-dev \
    build-essential && \
    rm -rf /var/lib/apt/lists/*  # Clean up to reduce image size

# Install jazzy for docs generation
RUN echo "gem: --no-document" > ~/.gemrc && gem install jazzy;

# Create tools directory and update PATH
RUN mkdir -p $HOME/.tools && \
    echo 'export PATH="$HOME/.tools:$PATH"' >> $HOME/.profile

# Install SwiftFormat
ARG swiftformat_version=0.40.12
RUN git clone --branch $swiftformat_version --depth 1 https://github.com/nicklockwood/SwiftFormat $HOME/.tools/swift-format && \
    cd $HOME/.tools/swift-format && \
    swift build -c release && \
    ln -s $HOME/.tools/swift-format/.build/release/swiftformat $HOME/.tools/swiftformat

# Expose the necessary port
EXPOSE 3000
