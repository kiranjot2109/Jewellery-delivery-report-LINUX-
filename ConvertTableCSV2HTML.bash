#!/bin/bash

# ConvertTableCSV2HTML.bash
# Fri Mar 12 14:45:18 PST 2010
# Chieh Cheng
# http://www.CynosureX.com/

# GNU General Public License (GPL) Version 2, June 1991

  scriptDir=`dirname "$0"`
  scriptName=`basename "$0"`

  singleLine=0

function process ()
{
  for file
  do
    if [ "${file}" = "-singleLine" ]
    then
      singleLine=1
    else
      if [ "${file}" = "-" ]
      then
        processStdIn
      else
        processFile "${file}"
      fi
    fi
  done
}

function processFile ()
{
  file="$1"

  if [ -f "${file}" ]
  then
    printf "<table border=\"1\" cellpadding=\"10\" width=\"500px\">"

    if [ ${singleLine} -eq 0 ]
    then
      echo
    fi

    cat "${file}" | sed 's|,|</td><td>|g'  |
    while read line
    do
      printf "<tr><td>${line}</td></tr>"

      if [ ${singleLine} -eq 0 ]
      then
        echo
      fi
    done

    printf "</table>"
    echo
  else
    # send error to stderr
    echo "${file} does not exist!" >&2
  fi
}

function processStdIn ()
{
  tempFile=`GetTempPathName.ksh "${scriptName}"`

  while read line
  do
    echo "${line}" >> "${tempFile}"
  done

  processFile "${tempFile}"

  rm "${tempFile}"
}

function usage ()
{
  echo "  Usage:   ${scriptName} [ -singleLine ] \"file 1\" [ . . . \"file N\" ]"
  echo
  echo "             You may substitute '-' in place of a file to read from STDIN."
  echo
  echo "             Use the -singleLine flag if you want to generate the HTML on"
  echo "             a single line. This flag may show up anywhere on the command-"
  echo "             line. But only data specified after this flag will be"
  echo "             generated in this manner."
}

  if [ $# -gt 0 ]
  then
    process "$@"
  else
    usage
  fi
