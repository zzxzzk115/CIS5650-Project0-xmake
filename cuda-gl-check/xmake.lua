target("cuda-gl-check")
    set_kind("binary")
    add_files("src/*.cpp", "src/*.cu")
    add_headerfiles("src/*.hpp", "src/*.h")
    add_syslinks("glfw", "GLEW", "GL")
    before_run(function (target)
        if target:is_plat("linux") then
            -- Use XWayland and the NVIDIA GPU for CUDA/OpenGL interop.
            os.setenv("WAYLAND_DISPLAY", nil)
            os.setenv("__NV_PRIME_RENDER_OFFLOAD", "1")
            os.setenv("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
        end
    end)
target_end()
