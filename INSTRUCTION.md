# Project 0

This project consists of two parts:

1. CUDA GL Check
    * This is due **August 28 2026**. (See [late policy](#late-policy) at the bottom)
    * Instructions for this project are below.
2. CUDA Introduction
    * This is an exercise for you to grasp core CUDA concepts that are taught in the first 2 lectures.
    * Instructions of this exercise are in [CUDA Introduction - README](./cuda-introduction/README.md).
    * It is strongly recommended that you complete these before you tackle Project 1 - CUDA Boids.
    * It will likely take you 1-2 hours to complete. You can spend additional time trying out Nsight Debugger and other tools.
    * Submission is not required. These are for your onboarding into CUDA programming.

# CUDA GL Check: Instructions

**Summary:** In this project, you will set up your GPU development tools and verify that you can build, run, and do performance analysis.

This project contains:

1. **CUDA**: A simple program that demonstrates CUDA and OpenGL functionality and interoperability, testing that CUDA has been properly installed. If the machine you are working on has CUDA and OpenGL 4.0 support, then when you run the program, you should see either one or two colors depending on your graphics card.
2. **WebGL**: A guide to enable WebGL support on your machine.
3. **WebGPU**: A guide to choose a browser that supports WebGPU

**If your machine fails any of these (CUDA, WebGL, WebGPU), use the CETS Virtual Lab or SIGLAB's computers for your development. Your submission will require certain screenshots.**

## Part 1: Setup your Development Environment

CIS 5650 projects require a compatible NVIDIA GPU. As some of you may not have an NVIDIA GPU in your personal computers, we have made them available through the CETS Virtual Lab.

Follow the [Hardware and Software Setup](https://cis5650-fall-2026.github.io/setup/) pages on the course website to set up your development environment.

This fork uses xmake on Linux and Windows. See [Linux Setup](LINUX_SETUP.md) or
[Windows Setup](WINDOWS_SETUP.md) for build and debug commands.

### Setup you Git Environment

0. You will need Git installed. Some computers including CETS Virtual Lab may have Git installed. To check if Git is installed, open Command Prompt/Git Bash/Terminal and run `git`. To install Git:
    * **Windows:** [Git](https://git-scm.com/download/win)
    * **Linux:** `apt install git` on Debian/Ubuntu
1. If you haven't used Git, you'll need to set up a few things.
    * On Windows: In order to use Git commands, you can use Git Bash. You can right-click in a folder and open Git Bash there.
    * On Linux: Open a terminal.
    * Configure git with some basic options by running these commands:
        * `git config --global push.default simple`
        * `git config --global user.name "YOUR NAME"`
        * `git config --global user.email "GITHUB_USER@users.noreply.github.com"`
        * (Or, you can use your own address, but remember that it will be public!)
2. Clone from GitHub onto your machine:
    * Navigate to the directory where you want to keep your 5650 projects, then
     clone your fork.
        * `git clone` the clone URL from your GitHub fork homepage.

Note: Do not clone projects directly from the [CIS5650-Fall-2026](https://github.com/CIS5650-Fall-2026) GitHub organization. Be sure to fork the project on GitHub first to your own account and then clone it using your fork.

*Getting Started with GitHub Resources:*

* [How to use GitHub](https://guides.github.com/activities/hello-world/)
* [How to use Git](http://git-scm.com/docs/gittutorial)

## Part 2.1: Project Instructions - CUDA

### Part 2.1.1: Build and Run CUDA GL Check

Build and run the project and follow the instructions below to complete your README.

In your README, report the Compute Capability of your CUDA-compatible GPU (sometimes called `sm`). Here is the [list of CUDA-compatible GPUs](https://developer.nvidia.com/cuda-gpus) along with their Compute Capabilities.

* `cuda-gl-check/src/` contains the source code.
* `cuda-gl-check/external/` contains the Windows binaries and headers for GLEW and GLFW.

Build from the repository root:

```sh
xmake f -m debug -y
xmake build cuda-gl-check
xmake run cuda-gl-check
```

Edit `cuda-gl-check/xmake.lua` for target-specific build settings. The root `xmake.lua` includes both subprojects. See [Linux Setup](LINUX_SETUP.md) for VS Code tasks and debugging.

### Part 2.1.2: Modify the CUDA Project and Take a Screenshot

1. Search the code for `TODO`: you'll find one in `cuda-gl-check/src/main.cpp` on line 13. Change the string to your name, rebuild, and run. (`m_yourName = "TODO: YOUR NAME HERE";`)
2. Take a screenshot of the window (including title bar) and save it to the `images` directory for Part 3.
3. You're done with some code changes now; make a commit!
    * Make sure to `git add` the `main.cpp` file.
    * Use `git status` to make sure you didn't miss anything.
    * Use `git commit` to save a version of your code including your changes.Write a short message describing your changes.
    * Use `git push` to sync your code history to the GitHub server.

### Part 2.1.3: Nsight Debugging

CUDA programs that run on the GPU require the Nsight Debugger for inspection. In this section, you'll learn about setting breakpoints, inspecting variables, configuring windows, controlling execution, and more.

#### Nsight Debugging on Windows using Nsight Visual Studio Edition

1. Switch your build configuration to "Debug" and `Rebuild` the solution.
2. Select the Nsight menu in Visual Studio and select *Start CUDA Debugging (Next-Gen)*.
3. If prompted, select the *Connect Unsecurely* option to start Nsight.
4. Exit the app.
5. Now place a breakpoint at Line 79 of `kernel.cu` => `if (x <= width && y <= height) {`
6. Restart the CUDA Debugging. This time, the breakpoint should be hit.
    * The *Autos* and *Locals* debugging tabs should appear at the bottom. (You can also open this from Debug -> Windows -> Autos/Locals)
    * Notice the values that are in the autos.
7. The following steps should be done with Nsight CUDA Debugging running.
8. Go to Nsight menu and select *Next Active Warp*. Now notice the values that have changed (highlighted in red).
9. Now, let's try to go to a particular index (pick your own number - anything greater than 1000).
    * Right click the breakpoint and select conditions.
    * The window that pops up should have defaults *Conditional Expression* and *is true*.
    * In the third box, put it `index == <your number>`.
    * Click close.
10. Now click *Continue* in the Visual Studio toolbar.
11. The breakpoint should be hit one more time. This time, the Autos window will should `index` as your number.
12. Goto  `Nsight` -> `Windows` -> `Warp Info`(if using older versions of Nsight, go to `Nsight` -> `Windows` -> `CUDA Info` -> `CUDA Info 1`).
    * This window shows information about the kernel, threads, blocks, warps, memory allocations etc. Choose from the drop downs to view each.
    * If using older version of Nsight, you may need to select *Warp* and keep it that way.
13. Find the yellow arrow by mapping `blockIdx` and `threadIdx` in `Autos` -> to `CTA` and `Thread` respectively under the `Shader Info` column. Click on the row to highlight it. Take a screenshot of this *Autos* window and the *Warp Info* as a image and save it under `images`.
    * Optionally, you may choose to double click on any one of the boxes in the "Threads" grid and watch the *Autos* window update the value.
14. Play around with Nsight debugger as much as you want. The debugger will be your best friend for CUDA Programming.

More documentation for Nsight Visual Studio Edition is available at https://docs.nvidia.com/nsight-visual-studio-edition/index.html.

#### Nsight Debugging on Linux using Nsight Visual Studio Code Edition

1. Open the repository root in VS Code.
2. Set a breakpoint at `cuda-gl-check/src/kernel.cu:79`.
3. Select **CUDA: cuda-gl-check (xmake debug)** and press **F5**. The launch task builds Debug automatically.
4. Press **F5** again to continue from `main` to the GPU breakpoint.
5. Inspect variables, threads, blocks, and warps in the CUDA views. Add `blockIdx.x`, `threadIdx.x`, and `index` to Watch.
6. Save the required debugger screenshots under `images`.

See [Linux Setup](LINUX_SETUP.md) for the full setup.

### Part 2.1.4: Nsight Systems

NVIDIA Nsight Systems is a system-wide performance analysis tool designed to visualize an application’s algorithms, identify the largest opportunities to optimize, and tune to scale efficiently across any quantity or size of CPUs and GPUs, from large servers to our smallest systems-on-a-chip (SoCs).

Full Nsight Systems User Guide is available at https://docs.nvidia.com/nsight-systems/UserGuide/index.html.

#### Nsight Systems on Windows & Linux

1. From Start Menu, open "Nsight Systems"
2. Create a new project if needed.
3. From *Select target for profiling`, select your local computer.
4. Under *Target application -> Command line with arguments*, enter the full path to the compiled executable (from your previous build).
    * You may optionally do multiple runs with different options selected to explore the capabilities of Nsight Systems.
5. Run the program for a few seconds, then close it.  Then wait for Systems to generate the report.
6. Go through the *Analysis Summary* and the *Timeline*.
7. Take a screenshot of this tab and save it to `images`, for Part 3.

### Part 2.1.5: Nsight Compute

NVIDIA Nsight Compute is an interactive profiler for CUDA and NVIDIA OptiX that provides detailed performance metrics and API debugging via a user interface and command-line tool. Users can run guided analysis and compare results with a customizable and data-driven user interface, as well as post-process and analyze results in their own workflows.

Full Nsight Compute documentation is available at https://docs.nvidia.com/nsight-compute/.

**NOTE**: Enable NVIDIA GPU Performance Counters using https://developer.nvidia.com/ERR_NVGPUCTRPERM.

#### Nsight Compute on Windows & Linux

1. From Windows Start Menu, open "Nsight Compute"
2. Create a new project if needed.
3. Click *Start Activity*.
4. In the pop up window
    1. Select the *Application Executable* as the compiled executable (from your previous build).
    2. Set the path for the *Output File*. It is common to use the `.ncp-rep` as extension, but you can use anything, eg. `.txt`.
    * Optionally, set the *Working Directory*.
    * Optionally, you can run this multiple times with different filter, metrics, etc.
5. Click *Launch*.
    * You may need to enable ports in your firewall. If you see error regarding `GPU Performance Counters`, see the note above.
6. Run the program for a few seconds, then close it.  Then wait for Compute to generate the report.
7. Browse the report in Compute. The more you explore, the more it will be helpful later.
8. Take a screenshot of the *Summary* and *Details* tab and save it to `images`, for Part 3.

## Part 2.2: Project Instructions - WebGL

1. Download [Google Chrome](https://www.google.com/chrome/) if not already installed
2. Check that you have [WebGL support](https://webglreport.com)
3. If step 2 doesn't show WebGL compatibility, then try the following:
    * *Enabling WebGL*
        * Go to `chrome://settings` (in the address bar)
        * Click the `Advanced` button at the bottom of the page
        * In the `System` section, ensure the `Use hardware acceleration when available` checkbox is checked (you'll need to relaunch Chrome for any changes to take effect)
        * Go to `chrome://flags`
        * Ensure that `Disable WebGL` is not activated (you'll need to relaunch Chrome for any changes to take effect)
            * In newer versions, this option of `Disable WebGL` will not be available, you will instead have to search for `WebGL 2.0` (or some different version)
            * If an option appears as `Default`, changed it to `Enabled`
            * You should also change `Override software rendering list` to `Enabled`
    * *Checking WebGL status*
        * Go to `chrome://gpu`
        * Inspect the WebGL item in the Graphics Feature Status list. The status will be one of the following:
            * Hardware accelerated - WebGL is *enabled* and hardware-accelerated (running on the graphics card).
            * Software only, hardware acceleration unavailable - WebGL is *enabled*, but running in software.
            * Unavailable - WebGL is *not available* in hardware or software.

**Take a screenshot** the output of `https://webglreport.com` or `chrome:\\gpu` and save it to `\images`. Your submission must show that WebGL works on your machine (or any machine you plan to develop on, e.g: Moore or SIGLAB machines).

## Part 2.3: Project Instructions - WebGPU

1. Download [Google Chrome](https://www.google.com/chrome/) if not already installed
    * See a list of supported browsers and versions at https://github.com/gpuweb/gpuweb/wiki/Implementation-Status.
2. Check that you have [WebGPU support](https://webgpureport.org/)
    * If you have multiple GPUs on your computer (eg. Intel and NVIDIA), then look at the `Adapter Info`. Use your device settings to change the GPU and then refresh the page to see if the GPU has updated.
3. If step 2 doesn't show WebGPU compatibility, then follow the instruction in https://developer.chrome.com/docs/web-platform/webgpu/troubleshooting-tips.

**Take a screenshot** the output of https://webgpureport.org or any one of https://webgpu.github.io/webgpu-samples/ and save it to `\images`. Your submission must show that WebGPU works on your machine (or any machine you plan to develop on, e.g: Moore or SIGLAB machines).

## Part 3: Write-up

1. Update ALL of the TODOs at the top of this README:
    * Finish your `README.md`
    * Add your name, computer, and whether it's a personal or lab computer.
    * Embed the screenshots you took: `![](images/example.png)`
    * Syntax help: https://help.github.com/articles/writing-on-github/
2. Add, commit, and push your screenshots and README.
    * Make sure your README looks good on GitHub!
3. Mention build configuration changes, including the migration to xmake.

## Submit

If you are using a private fork and do not want to make a public pull request, contact the staff to submit. You still must submit before the due date.

Open a GitHub pull request so that we can see that you have finished.
The title should be "Project 0: YOUR NAME".
The template of the comment section of your pull request is attached below, you can do some copy and paste:

* [Repo Link](https://link-to-your-repo)
* (Briefly) Mentions features that you've completed. Especially those bells and whistles you want to highlight
    * Feature 0
    * Feature 1
    * ...
* Feedback on the project itself, if any.

And you're done!

## Late-Policy

* Due at midnight on the due date
* Submitted using GitHub
* Late Policy
    * Up to 1 week late:  50% deduction
    * Use up to 4 bonus days over the semester to extend the due date without penalty
    * Examples
        * Extend 4 projects by 1 day each
        * OR: Extend 1 project by 4 days
        * OR: Extend 2 projects by 2 days each
* Can't be used for the final project
