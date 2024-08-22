#!/bin/bash

# Define versions
OPENSSL_VERSION="1.1.1t"
MOSQUITTO_VERSION="2.0.14"

# Define installation directories
OPENSSL_INSTALL_DIR="/usr/local/openssl"
MOSQUITTO_INSTALL_DIR="/usr/local/mosquitto"

# Update package lists and install essential development tools
echo "Updating package lists and installing essential tools..."
sudo apt-get update
sudo apt-get install -y build-essential autoconf libtool pkg-config libssl-dev

# Download and extract OpenSSL source
echo "Downloading OpenSSL ${OPENSSL_VERSION}..."
wget https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
echo "Extracting OpenSSL..."
tar xzf openssl-${OPENSSL_VERSION}.tar.gz

# Compile and install OpenSSL
echo "Compiling and installing OpenSSL..."
cd openssl-${OPENSSL_VERSION}
./config --prefix=${OPENSSL_INSTALL_DIR}
make
sudo make install
cd ..

# Clean up OpenSSL source
rm -rf openssl-${OPENSSL_VERSION}*

# Download and extract Mosquitto source
echo "Downloading Mosquitto ${MOSQUITTO_VERSION}..."
wget https://github.com/eclipse/mosquitto/archive/refs/tags/v${MOSQUITTO_VERSION}.tar.gz
echo "Extracting Mosquitto..."
tar xzf v${MOSQUITTO_VERSION}.tar.gz

# Compile and install Mosquitto
echo "Compiling and installing Mosquitto..."
cd mosquitto-${MOSQUITTO_VERSION}
# Set the OpenSSL paths
CFLAGS="-I${OPENSSL_INSTALL_DIR}/include" LDFLAGS="-L${OPENSSL_INSTALL_DIR}/lib -lssl -lcrypto" \
make clean
make
sudo make install PREFIX=${MOSQUITTO_INSTALL_DIR}

# Clean up Mosquitto source
cd ..
rm -rf mosquitto-${MOSQUITTO_VERSION}

# Verification
echo "Verifying installations..."
echo "Mosquitto version:"
/usr/local/sbin/mosquitto -h
echo "OpenSSL version:"
/usr/local/openssl/bin/openssl version

echo "Native compilation of Mosquitto with TLS support completed successfully."
