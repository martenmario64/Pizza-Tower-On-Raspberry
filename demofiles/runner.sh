#runner.sh contents

VERSION=6

if [ "$1" != "--in-terminal" ]; then
    lxterminal -e "bash -c '$0 --in-terminal; exec bash'"
    exit
fi

MESA_GL_VERSION_OVERRIDE=3.3 MESA_GLSL_VERSION_OVERRIDE=330 BOX64_LIBGL=libGL.so.1 wine ~/.martenapps/pizzatowermm64demo/Game/PizzaTower_GM2.exe
