FROM ubuntu:xenial AS mxe-base

LABEL maintainer="Stefan Löffler <st.loeffler@gmail.com>" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date="2019-03-01T16:10:12+00:00" \
      org.label-schema.description="Base image of a MXE build" \
      org.label-schema.url="http://mxe.cc/" \
      org.label-schema.vcs-url="https://github.com/mxe/mxe" \
      org.label-schema.vcs-ref="881e632b70334dc0f459410ba1a31b11ae8a4d80" \
      mxe.pkg_versions="binutils (2.28), gcc (5.5.0), gmp (6.1.2), isl (0.15), libtool (2.4.4), mingw-w64 (6.0.0), mpc (1.1.0), mpfr (3.1.5), mxe-conf (1), pkgconf (da179fd)"

# Set working directory
WORKDIR /opt/mxe

RUN apt-get update && apt-get install -y --no-install-recommends autoconf automake autopoint bison bzip2 flex g++ g++-multilib gettext git gperf intltool libc6-dev-i386 libgdk-pixbuf2.0-dev libltdl-dev libssl-dev libtool-bin libxml-parser-perl lzip make openssl p7zip-full patch perl pkg-config python ruby unzip wget xz-utils && \
    wget -O- https://github.com/mxe/mxe/archive/881e632b70334dc0f459410ba1a31b11ae8a4d80.tar.gz | tar -xz --strip-components=1 && echo 'MXE_TARGETS := i686-w64-mingw32.static' > settings.mk && \
    make -j cc && \
    make clean-junk && \
    rm -rf pkg && \
    apt-get -y remove autoconf automake autopoint bison bzip2 flex g++ g++-multilib gettext git gperf intltool libc6-dev-i386 libgdk-pixbuf2.0-dev libltdl-dev libssl-dev libtool-bin libxml-parser-perl lzip make openssl p7zip-full patch perl pkg-config python ruby unzip wget xz-utils


FROM mxe-base AS mxe-pre-qt

LABEL maintainer="Stefan Löffler <st.loeffler@gmail.com>" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date="2019-03-01T16:10:12+00:00" \
      org.label-schema.description="Image of a MXE build including prerequisites for Qt5" \
      org.label-schema.url="http://mxe.cc/" \
      org.label-schema.vcs-url="https://github.com/mxe/mxe" \
      org.label-schema.vcs-ref="881e632b70334dc0f459410ba1a31b11ae8a4d80" \
      mxe.pkg_versions="binutils (2.28), bzip2 (1.0.6), cairo (1.16.0), cmake (3.10.0), cmake-conf (1), dbus (1.13.8), expat (2.2.6), fontconfig (2.13.1), freetds (1.00.111), freetype (2.9.1), freetype-bootstrap (2.9.1), gcc (5.5.0), gettext (0.19.8.1), glib (2.50.2), gmp (6.1.2), harfbuzz (2.2.0), icu4c (56.1), isl (0.15), jpeg (9c), libffi (3.2.1), libiconv (1.15), libmysqlclient (6.1.6), libpng (1.6.36), libtool (2.4.4), lzo (2.10), mingw-w64 (6.0.0), mpc (1.1.0), mpfr (3.1.5), mxe-conf (1), openssl (1.1.1b), pcre (8.43), pcre2 (10.32), pixman (0.33.6), pkgconf (da179fd), postgresql (9.2.4), pthreads (POSIX 1003.1-2001), sqlite (3270200), zlib (1.2.11)"

# Set working directory
WORKDIR /opt/mxe

RUN apt-get update && apt-get install -y --no-install-recommends autoconf automake autopoint bison bzip2 flex g++ g++-multilib gettext git gperf intltool libc6-dev-i386 libgdk-pixbuf2.0-dev libltdl-dev libssl-dev libtool-bin libxml-parser-perl lzip make openssl p7zip-full patch perl pkg-config python ruby unzip wget xz-utils && \
    wget -O- https://github.com/mxe/mxe/archive/881e632b70334dc0f459410ba1a31b11ae8a4d80.tar.gz | tar -xz --strip-components=1 && echo 'MXE_TARGETS := i686-w64-mingw32.static' > settings.mk && \
    make -j libiconv fontconfig freetype gmp freetype-bootstrap libpng openssl pthreads libffi glib pixman cc pcre isl icu4c harfbuzz sqlite libtool bzip2 gcc mxe-conf zlib cairo gettext cmake-conf cmake autotools postgresql pcre2 mingw-w64 jpeg lzo binutils mpfr pkgconf dbus freetds expat libmysqlclient mpc && \
    make clean-junk && \
    rm -rf pkg && \
    apt-get -y remove autoconf automake autopoint bison bzip2 flex g++ g++-multilib gettext git gperf intltool libc6-dev-i386 libgdk-pixbuf2.0-dev libltdl-dev libssl-dev libtool-bin libxml-parser-perl lzip make openssl p7zip-full patch perl pkg-config python ruby unzip wget xz-utils


FROM mxe-pre-qt AS mxe-qt

LABEL maintainer="Stefan Löffler <st.loeffler@gmail.com>" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date="2019-03-01T16:10:12+00:00" \
      org.label-schema.description="Image of a MXE build including (most of) Qt5" \
      org.label-schema.url="http://mxe.cc/" \
      org.label-schema.vcs-url="https://github.com/mxe/mxe" \
      org.label-schema.vcs-ref="881e632b70334dc0f459410ba1a31b11ae8a4d80" \
      mxe.pkg_versions="binutils (2.28), bzip2 (1.0.6), cairo (1.16.0), cmake (3.10.0), cmake-conf (1), dbus (1.13.8), expat (2.2.6), fontconfig (2.13.1), freetds (1.00.111), freetype (2.9.1), freetype-bootstrap (2.9.1), gcc (5.5.0), gettext (0.19.8.1), glib (2.50.2), gmp (6.1.2), harfbuzz (2.2.0), icu4c (56.1), isl (0.15), jpeg (9c), libffi (3.2.1), libiconv (1.15), libmysqlclient (6.1.6), libpng (1.6.36), libtool (2.4.4), lzo (2.10), mingw-w64 (6.0.0), mpc (1.1.0), mpfr (3.1.5), mxe-conf (1), openssl (1.1.1b), pcre (8.43), pcre2 (10.32), pixman (0.33.6), pkgconf (da179fd), postgresql (9.2.4), pthreads (POSIX 1003.1-2001), qtactiveqt (5.12.1), qtbase (5.12.1), qtdeclarative (5.12.1), qtscript (5.12.1), qtsvg (5.12.1), qttools (5.12.1), qtxmlpatterns (5.12.1), sqlite (3270200), zlib (1.2.11)"

# Set working directory
WORKDIR /opt/mxe

RUN apt-get update && apt-get install -y --no-install-recommends autoconf automake autopoint bison bzip2 flex g++ g++-multilib gettext git gperf intltool libc6-dev-i386 libgdk-pixbuf2.0-dev libltdl-dev libssl-dev libtool-bin libxml-parser-perl lzip make openssl p7zip-full patch perl pkg-config python ruby unzip wget xz-utils && \
    wget -O- https://github.com/mxe/mxe/archive/881e632b70334dc0f459410ba1a31b11ae8a4d80.tar.gz | tar -xz --strip-components=1 && echo 'MXE_TARGETS := i686-w64-mingw32.static' > settings.mk && \
    make -j qtscript qttools && \
    make clean-junk && \
    rm -rf pkg && \
    apt-get -y remove autoconf automake autopoint bison bzip2 flex g++ g++-multilib gettext git gperf intltool libc6-dev-i386 libgdk-pixbuf2.0-dev libltdl-dev libssl-dev libtool-bin libxml-parser-perl lzip make openssl p7zip-full patch perl pkg-config python ruby unzip wget xz-utils


FROM mxe-qt AS mxe-tw

LABEL maintainer="Stefan Löffler <st.loeffler@gmail.com>" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date="2019-03-01T16:10:12+00:00" \
      org.label-schema.description="Image of a MXE build used for cross-compiling TeXworks (http://www.tug.org/texworks/) for Windows" \
      org.label-schema.url="http://mxe.cc/" \
      org.label-schema.vcs-url="https://github.com/mxe/mxe" \
      org.label-schema.vcs-ref="881e632b70334dc0f459410ba1a31b11ae8a4d80" \
      mxe.pkg_versions="binutils (2.28), bzip2 (1.0.6), cairo (1.16.0), cmake (3.10.0), cmake-conf (1), curl (7.64.0), dbus (1.13.8), expat (2.2.6), fontconfig (2.13.1), freetds (1.00.111), freetype (2.9.1), freetype-bootstrap (2.9.1), gcc (5.5.0), gettext (0.19.8.1), glib (2.50.2), gmp (6.1.2), gnutls (3.6.6), harfbuzz (2.2.0), hunspell (1.6.1), icu4c (56.1), isl (0.15), jpeg (9c), lcms (2.9), libffi (3.2.1), libgcrypt (1.8.4), libgnurx (2.6.1), libgpg_error (1.35), libiconv (1.15), libidn2 (2.1.1), libmysqlclient (6.1.6), libpng (1.6.36), libssh2 (1.8.0), libtool (2.4.4), libunistring (0.9.10), lua (5.3.3), lzo (2.10), mingw-w64 (6.0.0), mpc (1.1.0), mpfr (3.1.5), mxe-conf (1), nettle (3.4.1), openssl (1.1.1b), pcre (8.43), pcre2 (10.32), pixman (0.33.6), pkgconf (da179fd), postgresql (9.2.4), pthreads (POSIX 1003.1-2001), qtactiveqt (5.12.1), qtbase (5.12.1), qtdeclarative (5.12.1), qtscript (5.12.1), qtsvg (5.12.1), qttools (5.12.1), qtxmlpatterns (5.12.1), readline (8.0), sqlite (3270200), termcap (1.3.1), tiff (4.0.10), xz (5.2.4), zlib (1.2.11)"

# Set working directory
WORKDIR /opt/mxe

RUN apt-get update && apt-get install -y --no-install-recommends autoconf automake autopoint bison bzip2 flex g++ g++-multilib gettext git gperf intltool libc6-dev-i386 libgdk-pixbuf2.0-dev libltdl-dev libssl-dev libtool-bin libxml-parser-perl lzip make openssl p7zip-full patch perl pkg-config python ruby unzip wget xz-utils && \
    wget -O- https://github.com/mxe/mxe/archive/881e632b70334dc0f459410ba1a31b11ae8a4d80.tar.gz | tar -xz --strip-components=1 && echo 'MXE_TARGETS := i686-w64-mingw32.static' > settings.mk && \
    make -j cairo curl freetype gettext glib hunspell jpeg lcms libiconv libpng lua pthreads qtscript qttools readline tiff zlib && \
    make clean-junk && \
    rm -rf pkg && \
    apt-get -y remove autoconf automake autopoint bison bzip2 flex g++ g++-multilib gettext git gperf intltool libc6-dev-i386 libgdk-pixbuf2.0-dev libltdl-dev libssl-dev libtool-bin libxml-parser-perl lzip make openssl p7zip-full patch perl pkg-config python ruby unzip wget xz-utils


