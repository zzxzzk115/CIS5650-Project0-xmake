# Windows CUDA Setup

Build from the repository root with xmake. Windows uses the bundled x64 MSVC
GLEW/GLFW libraries; Linux continues to use its system graphics libraries.

## Requirements

- Windows 11 and an NVIDIA GPU.
- Visual Studio 2022 or its Build Tools, with **Desktop development with C++**.
- CUDA Toolkit 13 or newer and a compatible NVIDIA driver.
- xmake 3.0.0 or newer.

The Windows validation machine uses an RTX 4080 SUPER (`sm_89`), NVIDIA driver
617.42, CUDA Toolkit 13.3, MSVC 14.42.34433, and xmake 3.0.9. The
[course setup guide](https://cis5650-fall-2026.github.io/setup-windows/)
specifies CUDA 13 or newer.

## Build and run

In PowerShell, from the repository root:

```powershell
xmake f -m debug -y
xmake
xmake run saxpy
xmake run transpose
xmake run matmul
xmake run cuda-gl-check
```

Press Esc to close the CUDA/OpenGL window. Executables are written to
`build/debug/*.exe`.

For Release:

```powershell
xmake f -m release -y
xmake
```

Release executables are under `build/release/`. Debug includes CUDA device
symbols (`-G`); Release includes CUDA line information for profiling.

Xmake detects the installed Toolkit and GPU architecture. If the native GPU
probe cannot run, select your GPU architecture explicitly, for example:

```powershell
xmake f -m debug --cuda_arch=sm_89 -y
```

For a custom Toolkit location, add
`--cuda="C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v13.3"` to the
configure command. The GPU driver must support the selected Toolkit; installing
a newer Toolkit alone does not upgrade the display driver.

## CUDA debugging

Use **Visual Studio 2022 + NVIDIA Nsight Visual Studio Edition** for native
Windows GPU debugging. Generate a solution through xmake:

```powershell
xmake project -k vsxmake -m "debug,release"
```

Open `vsxmake2022/CIS5650-Project0-xmake.sln`, select Debug and the desired startup
project, set a breakpoint in a `.cu` kernel, and choose **Start CUDA Debugging**
from the Nsight menu. Keep build settings in the `xmake.lua` files.

The committed VS Code CUDA launch configurations use Linux `cuda-gdb`. Use them
on Linux or a supported remote Linux environment. VS Code's xmake build tasks
can also build the native Windows targets.

Open the shared VS Code workspace with `code CIS5650-Project0.code-workspace`. It uses
relative paths and the same clangd/xmake settings as the folder configuration;
**Ctrl+Shift+B** runs the Debug build task.

## Validation

All four targets build in Debug and Release on the validation machine. SAXPY,
device copy, transpose, and matrix multiplication pass their existing CPU/GPU
comparison checks in both modes. The CUDA/OpenGL check runs for five seconds in
each mode, reports the RTX 4080 SUPER with SM 8.9 in its window title, and exits
normally without CUDA or GLFW errors.

The build generates `.clangd` and `compile_commands.json` using the Windows
Toolkit path. The Visual Studio solution is also generated locally. Generated
files are ignored by Git. A live Nsight breakpoint session and Windows profiler
captures have not been validated.
