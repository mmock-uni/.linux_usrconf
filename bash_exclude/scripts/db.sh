#!/bin/bash

# This script does a POST request via curl to "https://reiseauskunft.bahn.de" to show train connections between given start, destination, time and date.
if [[ ! ($# -eq 2 || $# -eq 3 || $# -eq 4) ]]; then
  echo "Usage: db START DESTINATION [DATE] [TIME]"
  exit 1
fi

START="$1"
DEST="$2"
DATE="$3"
TIME="$4"

# default date is today
if [ "$DATE" = "" ]; then
  DATE=$(date "+%d%m%y")
fi

# default time is now
if [ "$TIME" = "" ]; then
  TIME=$(date "+%H:%M:%S")
fi

echo "POST: start=$START destination=$DEST date=$DATE time=$TIME"

FORMACTION="https://reiseauskunft.bahn.de/bin/query.exe/dn?ld=36251&protocol=https:&seqnr=1&ident=fq.026695251.1539027464&rt=1&OK"
DEFAULTDATA="HWAI%3DQUERY%21rit=no&queryPageDisplayed=yes&HWAI%3DQUERY%21displayed=yes&HWAI%3DJS%21ajax=yes&HWAI%3DJS%21js=yes&REQ0JourneyStopsS0A=255&ignoreTypeCheck=yes&REQ0JourneyStopsS0a=131072&REQ0JourneyStopsZ0A=255&REQ0JourneyStopsZ0o=8&REQ0JourneyStopsZ0a=131072&REQ1JourneyDate=&REQ1JourneyTime=&REQ1HafasSearchForw=1&REQ0JourneyRevia=yes&HWAI%3DQUERY%24via%240%21number=0&REQ0JourneyStops1ID=&REQ0JourneyStops2ID=&HWAI%3DQUERY%24via%241%21number=0&REQ1JourneyStops1ID=&REQ1JourneyStops2ID=&HWAI%3DQUERY%21prodAdvanced=0&existOptimizePrice=1&REQ0HafasOptimize1=0%3A1&existProductNahverkehr=1&HWAI%3DQUERY%24PRODUCTS%240_0%21show=yes&HWAI%3DQUERY%24PRODUCTS%240_0%21show=yes&advancedProductMode=yes&REQ0JourneyProduct_prod_section_0_0=1&REQ0JourneyProduct_prod_section_0_1=1&REQ0JourneyProduct_prod_section_0_2=1&REQ0JourneyProduct_prod_section_0_3=1&REQ0JourneyProduct_prod_section_0_4=1&REQ0JourneyProduct_prod_section_0_5=1&REQ0JourneyProduct_prod_section_0_6=1&REQ0JourneyProduct_prod_section_0_7=1&REQ0JourneyProduct_prod_section_0_8=1&REQ0JourneyProduct_prod_section_0_9=1&REQ0JourneyProduct_opt_section_0_list=0%3A0000&existProductAutoReturn=yes&REQ0HafasChangeTime=0%3A1&existIntermodalDep_enable=yes&REQ0JourneyDep__enable=Foot&existIntermodalDest_enable=yes&REQ0JourneyDest__enable=Foot&HWAI%3DQUERY%21hideExtInt=no&REQ0JourneyDep_Foot_minDist=0&REQ0JourneyDest_Foot_minDist=0&REQ0JourneyDep_Foot_maxDist=2000&REQ0JourneyDest_Foot_maxDist=2000&REQ0JourneyDep_Bike_minDist=0&REQ0JourneyDest_Bike_minDist=0&REQ0JourneyDep_Bike_maxDist=5000&REQ0JourneyDest_Bike_maxDist=5000&REQ0JourneyDep_KissRide_minDist=2000&REQ0JourneyDest_KissRide_minDist=2000&REQ0JourneyDep_KissRide_maxDist=50000&REQ0JourneyDest_KissRide_maxDist=50000&travelProfile=&traveller_Nr=1&REQ0Tariff_TravellerType.1=E&REQ0Tariff_TravellerReductionClass.1=0&REQ0Tariff_TravellerAge.1=&REQ0Tariff_Class=2&existOptionBits=yes&rtMode=12&start=Suchen"

curl \
--data "REQ0JourneyStopsS0G=$START" \
--data "REQ0JourneyStopsZ0G=$DEST" \
--data "REQ0JourneyTime=$TIME" \
--data "REQ0JourneyDate=$DATE" \
--data "REQ0HafasSearchForw=0" \
--data "$DEFAULTDATA" "$FORMACTION" -o db.html -s
( chromium-browser db.html & ) > /dev/null 2>&1
