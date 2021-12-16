#!/bin/sh
set -e

MIC_SOURCE=   # number from 'pactl list short sources'
OUTPUT_SINK=  # number from 'pactl list short sinks'
MIX_SOURCE=   # number for sink monitor of all mixed audio (without mic)
MIX_LOOPBACK= # number for mix loopback module (MIX_SOURCE -> OUTPUT_SINK)

setup() {
	pactl list short modules | grep -q 'Virtual_Sink' && return

	if [ -z "$MIC_SOURCE" ]; then
		first_source=$(pactl list short sources | head -1 | awk '{print $1;}') # e.g. 0
		pactl list short sources
		read -p ">> Source (input) number to use [$first_source]: " user_source
		[ -z "$user_source" ] && user_source=$first_source
		MIC_SOURCE=$user_source
		echo
		first_sink=$(pactl list short sinks | head -1 | awk '{print $1;}') # e.g. 1
		pactl list short sinks
		read -p ">> Sink (output) number to use [$first_sink]: " user_sink
		[ -z "$user_sink" ] && user_sink=$first_sink
		OUTPUT_SINK=$user_sink
		echo
	fi

	pactl load-module module-null-sink sink_name=Virtual_Output sink_properties=device.description=Virtual_Output > /dev/null
	pactl load-module module-null-sink sink_name=Virtual_Sink sink_properties=device.description=Virtual_Sink > /dev/null
	MIX_SOURCE=$(pactl list short sources | grep 'Virtual_Sink' | awk '{print $1;}') # e.g. 14

	pactl load-module module-loopback latency_msec=1 source=$MIC_SOURCE sink=Virtual_Output > /dev/null
	pactl load-module module-loopback latency_msec=1 source=$MIX_SOURCE sink=Virtual_Output > /dev/null
	MIX_LOOPBACK=$(pactl load-module module-loopback latency_msec=1 source=$MIX_SOURCE sink=$OUTPUT_SINK)
}

cleanup() {
	virtual_sink=$(pactl list short modules | grep 'Virtual_Sink' | awk '{print $1;}') # e.g. 30
	[ -z "$virtual_sink" ] && return
	read -p '>> Press enter to unload PulseAudio modules for the virtual mix...'

	[ ! -z "$MIX_LOOPBACK" ] && pactl unload-module $MIX_LOOPBACK || pactl unload-module module-loopback
	pactl list short modules | grep -E 'Virtual_(Sink|Output)' | awk '{print $1;}' | xargs -L1 pactl unload-module
}

setup
echo ">> Your virtual mix is currently active! Feel free to open e.g. 'pavucontrol' now."
echo
echo ">> For software that should have their audio included in the mix, move them"
echo "   to the 'Virtual_Sink' under the 'Playback' tab."
echo ">> For software that should capture the mixed audio, head to the 'Recording'"
echo "   tab and make the software use 'Monitor of Virtual_Output' as their input."
echo
cleanup
