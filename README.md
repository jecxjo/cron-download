#Cron Download

## Install

Copy the two executables to a location in your path.

    install -m 755 cron-download /usr/bin
    install -m 755 schedule-download /usr/bin

Copy the configuration file to `/etc/cron-download.conf` or make a local
copy `$HOME/.cron-download.conf`.

## Usage

There are two executables in this application:

`cron-download` scans the work directory for download tasks to perform. The
task files contain the URL and the File Name.

    URL=http://example.com/test.txt
    FILE=test.txt

The `FILE` value allows the script to save to a different file name than the
one assumed from the URL.

`schedule-download` generates the download task file and saves it to the
work directory. To generate the task above...

    # schedule-download http://example.com/test.txt test.txt

Files will be downloaded to the `complete` directory set in your configuration
file.

### Cron Configuration

Cron configuration is simple. Enter the time at which you'd like the command
to execute and the command. The cron format is as follows:

    *    *    *    *    *    * Command
    -    -    -    -    -    -
    |    |    |    |    |    |
    |    |    |    |    |    + year [optional]
    |    |    |    |    +----- day of week (0 - 7) (Sunday=0 or 7)
    |    |    |    +---------- month (1 - 12)
    |    |    +--------------- day of month (1 - 31)
    |    +-------------------- hour (0 - 23)
    +------------------------- min (0 - 59)

Since the download script is very simple, low resource and locks itself, you
can trigger this script every minute without worrying about slowing down
your system.

     * * * * * /usr/bin/cron-download
