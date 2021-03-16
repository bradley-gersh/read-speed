#!/bin/bash

FORMAT_SEC() {
    local SEC=$1
    local MIN=$(echo "scale=0; $SEC/60" | bc)
    SEC=$(echo "$SEC - (60 * $MIN)" | bc)
    local HRS=$(echo "scale=0; $MIN/60" | bc)
    MIN=$(echo "$MIN - (60 * $HRS)" | bc)

    if [[ $SEC -lt 10 ]]; then
        SEC="0$SEC"
    fi
    if [[ $MIN -lt 10 ]]; then
        MIN="0$MIN"
    fi

    echo $HRS h $MIN m $SEC s
}

echo AVERAGE PAGE TIMER

echo How many total pages are there?
read PAGE_COUNT

echo Press ENTER every time you finish a page. Press x on the last page to quit.

PAGE=1
LAST_TIME_POINT_SEC=$SECONDS
TIME_SO_FAR=0
AVERAGE=0

echo Press ENTER when you start reading ...
read COMMAND

while [ true ]
do
    echo "Press ENTER when done with page $PAGE (x to quit)..."
    read COMMAND
    if [[ "$COMMAND" == "x" || "$COMMAND" == "X" ]]; then break
    fi
    NEW_TIME_POINT_SEC=$SECONDS
    LAST_PAGE_SEC=$(( $NEW_TIME_POINT_SEC - $LAST_TIME_POINT_SEC ))
    TIME_SO_FAR_SEC=$(( $TIME_SO_FAR_SEC + $LAST_PAGE_SEC ))
    AVERAGE_SEC=$(echo "scale=1; $TIME_SO_FAR_SEC/$PAGE" | bc)

    LAST_PAGE_FORM=$(FORMAT_SEC $LAST_PAGE_SEC)
    TIME_SO_FAR_FORM=$(FORMAT_SEC $TIME_SO_FAR_SEC)
    TOTAL_TIME_EST_SEC=$(echo "($PAGE_COUNT*$AVERAGE_SEC)/1" | bc)
    TOTAL_TIME_EST_FORM=$(FORMAT_SEC $TOTAL_TIME_EST_SEC)
    TIME_LEFT_SEC=$(( $TOTAL_TIME_EST_SEC - $TIME_SO_FAR_SEC ))
    TIME_LEFT_FORM=$(FORMAT_SEC $TIME_LEFT_SEC)

    PAGE_LFT=$(( $PAGE_COUNT-$PAGE ))

    echo "---------------------------------------------
   $PAGE of $PAGE_COUNT pages read ($PAGE_LFT remaining)
   Time on last page:    $LAST_PAGE_FORM
   Average:              $AVERAGE_SEC sec/page

   Reading time so far:  $TIME_SO_FAR_FORM
   Estimated total time: $TOTAL_TIME_EST_FORM
   Estimated time left:  $TIME_LEFT_FORM
---------------------------------------------
"

    PAGE=$(( $PAGE+1 ))
    LAST_TIME_POINT_SEC=$NEW_TIME_POINT_SEC
done