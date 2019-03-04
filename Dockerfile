FROM debian:stretch

ARG OPENCV_VERSION=3.4.5

RUN apt-get update && \
    apt-get -y install python3-pip \
        python3-pyocr \
        wget \
        build-essential \
        cmake \
        git \
        unzip \
        pkg-config \
        python-dev \
        python-opencv \
        libopencv-dev \
        libav-tools  \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        libgtk2.0-dev \
        python-numpy \
        python-pycurl \
        libatlas-base-dev \
        gfortran \
        webp \
        python-opencv \
        qt5-default \
        libvtk6-dev \
        zlib1g-dev \
        libxvidcore-dev \
        libx264-dev \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libv4l-dev \
        libjpeg-dev \
        libtesseract-dev
#        libjasper-dev \

RUN mkdir -p ~/opencv cd ~/opencv && \
    wget -O opencv.zip https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip && \
    wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip && \
    unzip opencv.zip && \
    unzip opencv_contrib.zip && \
    mv opencv-$OPENCV_VERSION opencv && \
    mv opencv_contrib-$OPENCV_VERSION opencv_contrib && \
    cd opencv && \
    mkdir build && \
    cd build && \
    cmake \
        -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr \
        -D INSTALL_PYTHON_EXAMPLES=ON \
        -D INSTALL_C_EXAMPLES=OFF \
        -D OPENCV_ENABLE_NONFREE=ON \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
        -D PYTHON_EXECUTABLE=/usr/bin/python3 \
        -D BUILD_EXAMPLES=ON .. && \
    make -j4 && \
    make install && \
    ldconfig

RUN rm -rf opencv
