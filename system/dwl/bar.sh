#!/usr/bin/env bash

# Configuration
INTERVAL=5                              # Update interval in seconds
WIFI_INTERFACE="wlp2s0"                 # Your wireless interface (e.g., wlan0, wlpXs0)
ETHERNET_INTERFACE="eth0"               # Your ethernet interface (e.g., eth0, enpXs0)
BAT_PATH="/sys/class/power_supply/BAT0" # Adjust if your battery is BAT1, BATC, etc.

# --- Helper Functions ---

# Get current date and time
get_datetime() {
  DATE_ICON="" # Calendar icon (Nerd Font)
  TIME_ICON="" # Clock icon (Nerd Font)
  printf "%s %s %s %s" "$DATE_ICON" "$(date '+%b %d')" "$TIME_ICON" "$(date '+%H:%M')"
}

# Get battery status
get_battery() {
  if [ -d "$BAT_PATH" ]; then
    CAPACITY=$(cat "$BAT_PATH/capacity")
    STATUS=$(cat "$BAT_PATH/status")

    # Consider changing '充电' to a lightning bolt if your font renders it better
    # '' (U+F1E6, Lightning bolt)
    if [[ $STATUS == "Charging" ]]; then
      BAT_ICON="" # Charging icon (Lightning bolt)
    elif [[ $CAPACITY -ge 90 ]]; then
      BAT_ICON="" # Full battery
    elif [[ $CAPACITY -ge 70 ]]; then
      BAT_ICON="" # 3/4 battery
    elif [[ $CAPACITY -ge 50 ]]; then
      BAT_ICON="" # 1/2 battery
    elif [[ $CAPACITY -ge 20 ]]; then
      BAT_ICON="" # 1/4 battery
    else
      BAT_ICON="" # Low battery
    fi
    printf "%s %s%%" "$BAT_ICON" "$CAPACITY"
  else
    printf "" # No battery found
  fi
}

# Get volume status (using wpctl)
get_volume() {
  if command -v wpctl &>/dev/null; then
    SINK_INFO=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

    # Extract the decimal volume and multiply by 100
    # Use grep -oP to extract the number, then bc for calculation
    VOLUME_DECIMAL=$(echo "$SINK_INFO" | grep -oP '\d+\.\d+') # Extract "0.50"

    # Handle cases where volume might be 1.0 (no decimal shown by grep -oP from \d+ only)
    if [ -z "$VOLUME_DECIMAL" ] && echo "$SINK_INFO" | grep -q '1\.0'; then
      VOLUME_DECIMAL="1.0"
    elif [ -z "$VOLUME_DECIMAL" ]; then # If no decimal is found, it's likely 0.0 or muted.
      VOLUME_DECIMAL="0.0"
    fi

    VOLUME=$(echo "scale=0; $VOLUME_DECIMAL * 100 / 1" | bc) # Convert to integer percentage

    MUTE_STATUS=$(echo "$SINK_INFO" | grep -q 'MUTED' && echo "true" || echo "false")

    if [ "$MUTE_STATUS" = "true" ]; then
      VOL_ICON="" # Muted icon
    elif [ "$VOLUME" -ge 70 ]; then
      VOL_ICON="" # High volume
    elif [ "$VOLUME" -ge 30 ]; then
      VOL_ICON="" # Medium volume
    else
      VOL_ICON="" # Low volume
    fi
    printf "%s %s%%" "$VOL_ICON" "$VOLUME"
  else
    printf "No wpctl"
  fi
}

# Get network status
get_network() {
  WIFI_STATUS=""
  ETHERNET_STATUS=""

  # Check Wi-Fi
  if ip link show "$WIFI_INTERFACE" up &>/dev/null; then
    WIFI_SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d':' -f2)
    if [ -n "$WIFI_SSID" ]; then
      WIFI_ICON="" # Wi-Fi icon
      WIFI_STATUS="$WIFI_ICON $WIFI_SSID"
    fi
  fi

  # Check Ethernet
  if ip link show "$ETHERNET_INTERFACE" up &>/dev/null; then
    ETH_ICON="" # Ethernet icon
    ETHERNET_STATUS="$ETH_ICON Eth"
  fi

  if [ -n "$WIFI_STATUS" ] && [ -n "$ETHERNET_STATUS" ]; then
    printf "%s | %s" "$WIFI_STATUS" "$ETHERNET_STATUS"
  elif [ -n "$WIFI_STATUS" ]; then
    printf "%s" "$WIFI_STATUS"
  elif [ -n "$ETHERNET_STATUS" ]; then
    printf "%s" "$ETHERNET_STATUS"
  else
    printf " Disconnected" # Disconnected icon
  fi
}

# Get CPU Usage
# Requires 'grep' and 'awk'
get_cpu_usage() {
  CPU_ICON="" # CPU icon (Nerd Font)
  # Get total and idle CPU times from /proc/stat
  # This requires two samples to calculate actual usage over time
  # For a simpler, immediate (though less precise) value, we can parse 'top' or 'htop' output.
  # Using 'top' in batch mode for simplicity, takes ~100ms
  # Alternatively, you can calculate from /proc/stat over 1 second, but it makes the script slower.
  # We'll use a snapshot method.
  CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | cut -d'.' -f1)
  printf "%s %s%%" "$CPU_ICON" "$CPU_USAGE"
}

# Get Memory Usage
# Requires 'awk'
get_memory_usage() {
  MEM_ICON="" # RAM icon (Nerd Font - or another like  or  depending on preference)
  # Using free -h is simpler than parsing /proc/meminfo directly
  # Total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
  # Free=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
  # Used_KB=$((Total - Free))
  # Used_MB=$((Used_KB / 1024))

  # Get total and used in MB using 'free' command
  read -r TOTAL_MEM USED_MEM <<<"$(free -m | awk 'NR==2{print $2, $3}')"

  if ((TOTAL_MEM > 0)); then
    MEM_PERCENT=$((USED_MEM * 100 / TOTAL_MEM))
    printf "%s %s%%" "$MEM_ICON" "$MEM_PERCENT"
  else
    printf "%s N/A" "$MEM_ICON"
  fi
}

# --- Main Loop ---
while true; do
  # You can arrange the order of widgets as you prefer
  STATUS_BAR=""
  STATUS_BAR+=" $(get_network) "
  STATUS_BAR+="| $(get_cpu_usage) "
  STATUS_BAR+="| $(get_memory_usage) "
  STATUS_BAR+="| $(get_volume) "
  STATUS_BAR+="| $(get_battery) "
  STATUS_BAR+="| $(get_datetime)"

  # Send the status to standard output
  echo "$STATUS_BAR"

  sleep "$INTERVAL"
done
