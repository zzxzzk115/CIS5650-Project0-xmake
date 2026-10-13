target("cuda-gl-check")
    set_kind("binary")
    add_files("src/*.cpp", "src/*.cu")
    add_headerfiles("src/*.hpp", "src/*.h")
    if is_plat("windows") then
        -- The bundled x64 MSVC libraries use the DLL CRT in both build modes.
        set_arch("x64")
        set_runtimes("MD")
        add_defines("GLEW_STATIC")
        add_includedirs("external/include")
        add_linkdirs("external/lib/vc2015")
        add_links("glew32s", "glfw3")
        add_syslinks("opengl32", "gdi32", "user32", "shell32")
    else
        add_syslinks("glfw", "GLEW", "GL")
    end
    before_run(function (target)
        if target:is_plat("linux") then
            -- Use XWayland and the NVIDIA GPU for CUDA/OpenGL interop.
            os.setenv("WAYLAND_DISPLAY", nil)
            os.setenv("__NV_PRIME_RENDER_OFFLOAD", "1")
            os.setenv("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
        end
    end)
target_end()
