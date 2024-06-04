#!/bin/bash

# weather-conky get_weather.sh
# by @wim66
# june 2 2024

# Determine the path to the script and its folders
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
CACHE_DIR="$SCRIPT_DIR/cache"
ICON_DIR="$SCRIPT_DIR/weather-icons/light/spils-icons"
WEATHER_DATA_FILE="$SCRIPT_DIR/resources/weather_data"

API_KEY="$OWM_API_KEY" # put your OpenWeatherMap api here (or in your env) https://openweathermap.org/
CITY_ID="2759794"      # find your city id in the url box https://openweathermap.org/city/2759794
URL="http://api.openweathermap.org/data/2.5/weather?id=${CITY_ID}&appid=${API_KEY}&units=metric"

# Create cache directory if it does not exist
mkdir -p $CACHE_DIR

WEATHER_DATA=$(curl -s $URL)

# Get weather icon and other data
CITY=$(echo $WEATHER_DATA | jq -r .name)
WEATHER_ICON=$(echo $WEATHER_DATA | jq -r .weather[0].icon)
WEATHER_DESC=$(echo $WEATHER_DATA | jq -r .weather[0].description)


: ' comment (remove this line to use translations)

# Translate the weather description into your own language
translate_weather() {
    case $1 in
        "clear sky") echo "Helder weer" ;;
        "few clouds") echo "Lichte bewolking" ;;
        "scattered clouds") echo "verspreide wolken" ;;
        "broken clouds") echo "Gedeeltelijk bewolkt" ;;
        "overcast clouds") echo "Overwegend bewolkt" ;;
        "shower rain") echo "Buiige regen" ;;
        "rain") echo "Regen" ;;
        "thunderstorm") echo "Onweer" ;;
        "snow") echo "Sneeuw" ;;
        "mist") echo "Mist" ;;
        *) echo "$1" ;;
    esac
}

MY_WEATHER_DESC=$(translate_weather "$WEATHER_DESC")

(remove this line to use translations) end comment '


# Copy the icon to the cache directory
cp ${ICON_DIR}/${WEATHER_ICON}.png ${CACHE_DIR}/weathericon.png

# Save the weather data
echo "CITY=${CITY}" > $SCRIPT_DIR/weather_data
echo "WEATHER_ICON=${WEATHER_ICON}" >> $SCRIPT_DIR/weather_data

echo "WEATHER_DESC=${WEATHER_DESC}" >> $SCRIPT_DIR/weather_data      # English, disable if you use own language
#echo "WEATHER_DESC=${MY_WEATHER_DESC}" >> $SCRIPT_DIR/weather_data  # Use this line for your own language

