#!/usr/bin/env bash
#--------------------------------------------------------------------------------------------------------
# MERGE PDFS FOR PRINTING
#--------------------------------------------------------------------------------------------------------
#
# Merge PDF : Merge PDFs for printing purposes (or others)
# By 0phoff
# MIT license
#
#--------------------------------------------------------------------------------------------------------
#
# Usage: mergepdf [-r] [-o output] *.pdf
#
#--------------------------------------------------------------------------------------------------------

# Default Values
BLANK="_blank"
TMPFOLDER="mergepdf-XXXXX"
OUTPUT="out.pdf"
RECTO=false

# Functions
help()
{
    printf "Merge PDFs:\n  mergepdf [-r] [-o output] *.pdf\n\n"
    printf "Flags:\n"
    printf "  -o output [optional]\tOutput pdf file (default: $OUTPUT)\n"
    printf "  -r        [optional]\tMerge PDFs for recto verso printing\n"
    printf "\nNote:\n"
    printf "  This script requires pdftk and ps2pdf\n"
    printf "  It also only works with A4 paper\n"
    exit
}

create_blank()
{
    if [ ! -f "$1/$BLANK.pdf" ]; then
        touch "$1/$BLANK.ps"
        ps2pdf "$1/$BLANK.ps" "$1/$BLANK.pdf"
    fi
}

create_tmpfolder()
{
    local tmp=$(mktemp -d -t $TMPFOLDER)
    echo "$tmp"
}

# prepare_pdf_recto_verso tmpfolder count file
prepare_pdf_recto_verso()
{
    newpdf=$(printf "%08d.pdf" $2)
    pages=$(pdftk "$3" dump_data|grep NumberOfPages| awk '{print $2}')

    if [ $((pages%2)) -eq 0 ]; then
        cp "$3" "$1/$newpdf"
    else
        pdftk A="$3" B="$1/$BLANK.pdf" cat A1-end B1 output "$1/$newpdf"

        pages=$(pdftk "$1/$newpdf" dump_data|grep NumberOfPages| awk '{print $2}')
    fi
}

# Parse arguments
while getopts ":o:rh" flag; do
    case "$flag" in
        r)  RECTO=true
            ;;
        o)  OUTPUT=$OPTARG
            ;;
        h)  help
            ;;
        *)  ;;
    esac
done
shift $((OPTIND - 1))

# Check if necessary commands exist
command -v pdftk >/dev/null && CMDEXISTS=1 || CMDEXISTS=0
if [ "$CMDEXISTS" -eq 0 ]; then
    printf "Please install the pdftk package to use this script\n\n"
    help
fi

command -v pdftk >/dev/null && CMDEXISTS=1 || CMDEXISTS=0
if [ "$CMDEXISTS" -eq 0 ]; then
    printf "Please install the ps2pdf command to use this script\n\n"
    help
fi

# Check input
if [ $# -eq 0 ]; then
    printf "Please enter pdfs to merge!\n\n"
    help
fi

if [ -f "$OUTPUT" ]; then
    printf "Output file already exists! [$OUTPUT]\n\n"
    help
fi

# Create merged PDF
if [ $RECTO = true ]; then
    # Add empty page to odd numbered pdfs
    tmp=$(create_tmpfolder)
    create_blank $tmp
    count=0
    for file in "$@"; do
        prepare_pdf_recto_verso $tmp $count "$file"
        (( count++ ))
    done

    # Merge pdfs
    pdftk $tmp/0*.pdf cat output $OUTPUT
else
    # Merge pdfs
    pdftk "$@" cat output $OUTPUT
fi
