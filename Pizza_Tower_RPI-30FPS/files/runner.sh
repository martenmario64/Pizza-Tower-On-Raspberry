VERSION=6
#!/bin/bash

if command -v xrandr > /dev/null; then
    current_v_res=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d'x' -f2)
else
    current_v_res=$(WAYLAND_DISPLAY="wayland-1" wlr-randr | grep '*' | awk '{print $1}' | cut -d'x' -f2 | head -n1)
fi

echo "Current vertical resolution: ${current_v_res}p"
if [ "$current_v_res" -le 720 ]; then
    yad --pulsate --text="  Loading...  (Note If You Want 30 FPS Set The System To Be Above 1280x720)." \
    --width=200 --undecorated --fixed --skip-taskbar \
    --no-buttons --on-top --center &    
    yad_id=$!
    MESA_GL_VERSION_OVERRIDE=3.3 MESA_GLSL_VERSION_OVERRIDE=330 BOX64_LIBGL=libGL.so.1 wine ~/.martenapps/pizzatower/Game/PizzaTower.exe -debug &
else
    yad --pulsate --text="  Loading...  (Note If You Want 45 FPS Set The System To Be Below 1280x960)." \
    --width=200 --undecorated --fixed --skip-taskbar \
    --no-buttons --on-top --center &    
    yad_id=$!
    MESA_GL_VERSION_OVERRIDE=3.3 MESA_GLSL_VERSION_OVERRIDE=330 BOX64_LIBGL=libGL.so.1 wine ~/.martenapps/pizzatower30/Game/PizzaTower.exe -debug &
fi

while ! pgrep -fi "PizzaTower|wine|winedevice" > /dev/null; do
    sleep 1
    if ! kill -0 $yad_id 2>/dev/null; then exit; fi
done

sleep 6

kill $yad_id
