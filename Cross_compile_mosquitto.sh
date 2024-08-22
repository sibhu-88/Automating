#!/bin/bash

# Update package lists and install essential development tools
echo "Updating package lists and installing essential tools..."
sudo apt-get update
sudo apt-get install -y build-essential autoconf libtool pkg-config libssl-dev gcc-arm-linux-gnueabihf gcc-aarch64-linux-gnu

# Define versions
OPENSSL_VERSION="1.1.1t"
MOSQUITTO_VERSION="2.0.14"

# Define installation directories
OPENSSL_INSTALL_DIR_ARM32="/usr/local/arm32/openssl"
OPENSSL_INSTALL_DIR_ARM64="/usr/local/arm64/openssl"
MOSQUITTO_INSTALL_DIR_ARM32="/usr/local/arm32/mosquitto"
MOSQUITTO_INSTALL_DIR_ARM64="/usr/local/arm64/mosquitto"

# Download and extract OpenSSL source
echo "Downloading OpenSSL ${OPENSSL_VERSION}..."
wget https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
echo "Extracting OpenSSL..."
tar xzf openssl-${OPENSSL_VERSION}.tar.gz

# Compile and install OpenSSL for ARM32
echo "Compiling OpenSSL for ARM32..."
cd openssl-${OPENSSL_VERSION}
mkdir -p $OPENSSL_INSTALL_DIR_ARM32
./Configure linux-armv4 --prefix=$OPENSSL_INSTALL_DIR_ARM32 --cross-compile-prefix=arm-linux-gnueabihf-
make
sudo make install
cd ..

# Compile and install OpenSSL for ARM64
echo "Compiling OpenSSL for ARM64..."
cd openssl-${OPENSSL_VERSION}
make clean
mkdir -p $OPENSSL_INSTALL_DIR_ARM64
./Configure linux-aarch64 --prefix=$OPENSSL_INSTALL_DIR_ARM64 --cross-compile-prefix=aarch64-linux-gnu-
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

# Compile and install Mosquitto for ARM32
echo "Compiling Mosquitto for ARM32..."
cd mosquitto-${MOSQUITTO_VERSION}
mkdir -p $MOSQUITTO_INSTALL_DIR_ARM32
CFLAGS="-I$OPENSSL_INSTALL_DIR_ARM32/include" LDFLAGS="-L$OPENSSL_INSTALL_DIR_ARM32/lib -lssl -lcrypto" \
CC=arm-linux-gnueabihf-gcc CXX=arm-linux-gnueabihf-g++ \
make clean
make
sudo make install DESTDIR=$MOSQUITTO_INSTALL_DIR_ARM32
cd ..

# Compile and install Mosquitto for ARM64
echo "Compiling Mosquitto for ARM64..."
cd mosquitto-${MOSQUITTO_VERSION}
make clean
CFLAGS="-I$OPENSSL_INSTALL_DIR_ARM64/include" LDFLAGS="-L$OPENSSL_INSTALL_DIR_ARM64/lib -lssl -lcrypto" \
CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++ \
make
sudo make install DESTDIR=$MOSQUITTO_INSTALL_DIR_ARM64
cd ..

# Clean up Mosquitto source
rm -rf mosquitto-${MOSQUITTO_VERSION}

# Verification
echo "Verifying installations..."
echo "Mosquitto ARM32:"
$MOSQUITTO_INSTALL_DIR_ARM32/usr/local/bin/mosquitto -h
echo "Mosquitto ARM64:"
$MOSQUITTO_INSTALL_DIR_ARM64/usr/local/bin/mosquitto -h
echo "OpenSSL ARM32 version:"
$OPENSSL_INSTALL_DIR_ARM32/bin/openssl version
echo "OpenSSL ARM64 version:"
$OPENSSL_INSTALL_DIR_ARM64/bin/openssl version

echo "Cross-compilation of Mosquitto with TLS support for ARM32 and ARM64 completed successfully."
