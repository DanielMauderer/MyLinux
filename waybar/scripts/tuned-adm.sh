#!/usr/bin/env bash

# Power profiles for tuned-adm
PROFILES=("balanced-battery" "balanced" "latency-performance")
ICONS=("󰁹" "󰾅" "󰓅")  # Battery, Balanced, Performance
LABELS=("Battery" "Balanced" "Performance")

# Check if tuned-adm is available
if ! command -v tuned-adm &> /dev/null; then
    echo "󰁹 N/A"
    exit 0
fi

# Get current active profile
CURRENT_PROFILE=$(tuned-adm active 2>/dev/null | grep -oP 'Current active profile: \K.*' | xargs)

# If we couldn't get the profile, try alternative method
if [ -z "$CURRENT_PROFILE" ]; then
    CURRENT_PROFILE=$(tuned-adm active 2>/dev/null | awk '/Current active profile:/ {print $4}')
fi

# Find index of current profile
CURRENT_INDEX=-1
for i in "${!PROFILES[@]}"; do
    if [[ "$CURRENT_PROFILE" == "${PROFILES[$i]}" ]]; then
        CURRENT_INDEX=$i
        break
    fi
done

# If current profile not in our list, default to balanced
if [ $CURRENT_INDEX -eq -1 ]; then
    CURRENT_INDEX=1
fi

# If script is called with "cycle" argument, switch to next profile
if [[ "$1" == "cycle" ]]; then
    # Calculate next index
    NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#PROFILES[@]} ))
    NEXT_PROFILE="${PROFILES[$NEXT_INDEX]}"
    NEXT_LABEL="${LABELS[$NEXT_INDEX]}"
    
    if tuned-adm profile "$NEXT_PROFILE" 2>/dev/null; then
        notify-send "Power Profile" "Switched to: $NEXT_LABEL ($NEXT_PROFILE)" -t 2000
    else
        notify-send "Power Profile" "Failed to switch profile" -t 2000
    fi

    
    # Update current index after switching
    CURRENT_INDEX=$NEXT_INDEX
fi

# Display current profile with icon
echo "${ICONS[$CURRENT_INDEX]} ${LABELS[$CURRENT_INDEX]}"
