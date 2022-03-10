export JAVA_HOME=/home/ayush/Studio/android-studio/jre

uiautomator() {
        export JAVA_HOME=\/usr/lib/jvm/java-1.8.0-openjdk-amd64/
        export ANDROID_HOME=/home/ayush/Android/Sdk
        export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools:$ANDROID_HOME/tools
        /home/ayush/Android/Sdk/tools/bin/uiautomatorviewer
}

export PATH="$HOME/.poetry/bin:$PATH"
source "$HOME/.cargo/env"
export PKG_CONFIG_ALLOW_CROSS=1
#export SYSROOT=build/root
#export PKG_CONFIG_LIBDIR=${SYSROOT}/usr/lib/pkgconfig:${SYSROOT}/usr/share/pkgconfig
export PKG_CONFIG_SYSROOT_DIR=/home/ayush/Android/Sdk/ndk/21.1.6352462/sysroot
export PKG_CONFIG_PATH=/usr/lib/pkgconfig
