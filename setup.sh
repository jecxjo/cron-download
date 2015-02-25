#!/bin/sh

show_help() {
cat << EOF
Usage: ${0##/*} [-h] [-d DESTDIR] [-p PREFIX] [-b BINDIR]

    -h              Display this help and exit
    -d DESTDIR      Sets the DESTDIR variable, used for staged install
    -p PREFIX       Sets the PREFIX variable, base for install. Typically /usr
    -b BINDIR       Sets the BINDIR variable, typically PREFIX/bin

EOF
}

DESTDIR=
PREFIX=/usr
BINDIR=${PREFIX}/bin
SYSCONFDIR=/etc

OPTIND=1


while getopts "hd:p:b:s:" opt; do
  case "$opt" in
    h)
      show_help
      exit 0
      ;;
    d)
      DESTDIR="$OPTARG"
      ;;
    p)
      PREFIX="$OPTARG"
      ;;
    b)
      BINDIR="$OPTARG"
      ;;
    '?')
      show_help
      exit 1
      ;;
  esac
done
shift "$((OPTIND-1))"

echo "Creating directories"
install -m 755 -d "$DESTDIR/$PREFIX"
install -m 755 -d "$DESTDIR/$BINDIR"
install -m 755 -d "$DESTDIR/$SYSCONFDIR"

echo "Installing files"
install -m 755 ./cron-download "$DESTDIR/$BINDIR"
install -m 755 ./schedule-download "$DESTDIR/$BINDIR"
install -m 644 ./cron-download.conf "$DESTDIR/$SYSCONFDIR"

echo "done"
