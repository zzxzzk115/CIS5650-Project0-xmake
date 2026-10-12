for _, name in ipairs({"saxpy", "transpose", "matmul"}) do
    target(name)
        set_kind("binary")
        add_files("source/" .. name .. ".cu", "source/common.cu")
        add_headerfiles("source/*.h", "source/*.hpp")
    target_end()
end
