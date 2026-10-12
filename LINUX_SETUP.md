# Linux CUDA Setup

Build with xmake and debug with VS Code + NVIDIA Nsight. Visual Studio is not required.

All four targets build in Debug and Release. CUDA and the GPU architecture are detected automatically.

## Build and run

From the repository root:

```sh
xmake f -m debug -y
xmake

xmake run cuda-gl-check
```

Press Esc to close the window. The target automatically sets up XWayland and NVIDIA rendering on Linux.

Targets: `cuda-gl-check`, `saxpy`, `transpose`, `matmul`. To build one:

```sh
xmake build saxpy
```

Each subproject has its own `xmake.lua`, included by the root configuration.

Complete the exercise TODOs before running `saxpy`, `transpose`, or `matmul`.

For Release:

```sh
xmake f -m release -y
xmake
```

Binaries are in `build/{debug,release}/`.

## Debug in VS Code

Open the repository root with `code .`. Use the Nsight, clangd, and xmake extensions recommended by this workspace.

1. Set a breakpoint at `cuda-gl-check/src/kernel.cu:79`.
2. Select **CUDA: cuda-gl-check (xmake debug)** in Run and Debug.
3. Focus the source editor and press **F5** to build and stop at `main`; press **F5** again to reach the GPU breakpoint.
4. Add `blockIdx.x`, `threadIdx.x`, and `index` to Watch.
5. Press **Shift+F5** to stop.

**Ctrl+Shift+B** builds Debug. The GL debug configuration handles XWayland automatically through `scripts/cuda-gdb`.

If another extension captures **F5**, use the start button in Run and Debug. Disable **C/C++ Compile Run** for this workspace if installed; its single-file debugger does not use xmake or Nsight.

## Profile with Nsight

Install Nsight Systems (`nsys`, `nsys-ui`) and Nsight Compute (`ncu`, `ncu-ui`) separately from the VS Code Nsight extension. Keep all four commands on `PATH`.

See the README's [Systems workflow](README.md#nsight-systems) and [Compute workflow](README.md#nsight-compute) for collection commands, GUI launch commands, and the views used in the screenshots.

## WebGPU in Edge

Configure these pages manually in Edge:

1. In Settings, search for **graphics acceleration** and enable **Use graphics acceleration when available**.
2. Open `edge://flags/#enable-unsafe-webgpu` and set **Unsafe WebGPU** to **Enabled**.
3. Open `edge://flags/#enable-vulkan` and set **Vulkan** to **Enabled**.
4. Restart Edge using **Restart/Relaunch** on the flags page.
5. Open `edge://gpu` and check for **WebGPU: Hardware accelerated**. Then open [WebGPU Report](https://webgpureport.org/) and check that it lists an adapter.

These flags enable experimental Linux support in Chromium; see the [official troubleshooting guide](https://developer.chrome.com/docs/web-platform/webgpu/troubleshooting-tips). If a flag is unavailable or no adapter appears, check **Problems Detected** in `edge://gpu` before changing more flags.

## Code completion

clangd reads `compile_commands.json` from the repository root. xmake updates it after builds and generates `.clangd` from `.clangd.in` with the detected CUDA path and GPU architecture. The VS Code extension's separate database generation is disabled. Both generated files are ignored by Git. Edit `.clangd.in` for shared clangd options.

C/C++ IntelliSense is disabled to avoid duplicate diagnostics. Compilation still uses nvcc and GCC; clangd provides completion and navigation.

## Using another machine

Install CUDA Toolkit, a working NVIDIA driver, GCC, xmake, GLFW, GLEW, and OpenGL development libraries.

Keep `cuda-gdb` on `PATH`. For a custom CUDA installation, use `xmake f --cuda=/path/to/cuda`. To build without GPU access, specify an architecture such as `--cuda_arch=sm_89`.

The build and local debugger target Linux. Use VS Code Remote SSH or WSL when editing from Windows or macOS.
