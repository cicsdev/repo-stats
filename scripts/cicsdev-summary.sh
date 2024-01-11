#!/bin/sh

statsdir=./cicsdev
outdir=./summary
tempdir="$outdir/temp"

if ! command -v qsv >/dev/null 2>&1
then
    echo >&2 "This script requires qsv."
    exit 1
fi

if [ ! -d "$statsdir" ]; then
    echo >&2 "Cannot find cicsdev directory: $statsdir"
    exit 1
fi

mkdir -p "$tempdir"

for csvfile in forks stargazers; do
    echo "Combining $csvfile.csv files..."
    echo "repo,total" > "$tempdir/$csvfile.csv"
    find "$statsdir" -name "$csvfile.csv" -type f -exec sh -c 'repo=$(echo "$1" | cut -d "/" -f3); printf "$repo,"; tail -n 1 $1 | cut -d , -f 2' _ {} \; >> "$tempdir/$csvfile.csv"
    qsv sort -s repo "$tempdir/$csvfile.csv" > "$outdir/$csvfile.csv"
    qsv sort -NR -s total "$tempdir/$csvfile.csv" | head -n 11 > "$outdir/${csvfile}_top10.csv"
done

for col in clones views; do
    echo "Combining $col data..."
    mkdir -p "$tempdir/$col"

    find "$statsdir" -name "views_clones_aggregate.csv" -type f -exec sh -c 'repo=$(echo "$1" | cut -d "/" -f3); qsv select time_iso8601,$2_total "$1" | qsv rename date,$repo - > "$3/$repo.csv"' _ {} "$col" "$tempdir/$col" \;

    rm -f "$tempdir/$col.csv"

    for filename in "$tempdir/$col/"*.csv
    do
        if [ ! -f "$filename" ]; then
            echo "Skipping $filename"
            continue
        elif [ ! -f "$tempdir/$col.csv" ]; then
            echo "Copying $filename"

            cp "$filename" "$tempdir/$col.csv"
        else
            echo "Joining $filename"

            qsv joinp --null-value "0" --full date "$tempdir/$col.csv" date "$filename" > "$tempdir/joined_$col.csv"
            mv "$tempdir/joined_$col.csv" "$tempdir/$col.csv"
        fi
    done

    qsv sort -s date "$tempdir/$col.csv" > "$outdir/$col.csv"
    qsv stats "$tempdir/$col.csv" | qsv select field,sum | qsv sort -NR -s sum | qsv rename repo,$col | head -n 11 > "$outdir/${col}_top10.csv"
done
