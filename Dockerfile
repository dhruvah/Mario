# Use an official Ubuntu base image
FROM ubuntu:latest

# Set the working directory in the container
WORKDIR /usr/src/app

# Install C++, CMake, SDL2, Boost, and other necessary libraries
RUN apt-get update && apt-get install -y \
    g++ \
    cmake \
    libsdl2-dev \
    libsdl2-mixer-dev \
    libboost-all-dev \
    libdevil-dev \
    libdevil1c2 \
    libglu1-mesa-dev \
    mesa-common-dev \
    xorg-dev \
    libglew-dev \
    wget \
    unzip

# Download and set up RapidXML
RUN wget http://sourceforge.net/projects/rapidxml/files/latest/download -O rapidxml.zip \
    && unzip rapidxml.zip -d /tmp/rapidxml \
    && find /tmp/rapidxml -type f -name '*.hpp' -exec mv {} /usr/include/ \; \
    && rm -rf /tmp/rapidxml rapidxml.zip \
    && ls -l /usr/include/*.hpp  # List .hpp files to verify they are moved

# Set the include path for RapidXML if it's not in a standard location
ENV CPLUS_INCLUDE_PATH=/usr/include/rapidxml

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Run CMake to configure the project and generate a Makefile
RUN cmake .

# Build the project
RUN make

# Command to run the executable
CMD ["./MarioGame"]
