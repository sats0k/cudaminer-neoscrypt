NeoScrypt CUDAminer
=======

NeoScrypt only. All other algorithms have been removed.

Requires the cURL library for network communication
(also pthreadVC2 and NVAPI on Windows).

### CUDA 12.8 / GCC 16 Compatibility

The current Linux build is tested with CUDA 12.8 and GCC 16.1.

When using CUDA 12.8 with GCC 16, two declarations in
`math_functions.h` need to be adjusted for exception-specification
compatibility.

The only modification required to the CUDA toolkit is the following
change to:

    /opt/cuda/include/crt/math_functions.h

Apply:

    sudo sed -i \
      's/double                 rsqrt(double x);/double                 rsqrt(double x) noexcept (true);/' \
      /opt/cuda/include/crt/math_functions.h

    sudo sed -i \
      's/float                  rsqrtf(float x);/float                  rsqrtf(float x) noexcept (true);/' \
      /opt/cuda/include/crt/math_functions.h

Or, equivalently, change:

    double                 rsqrt(double x);
    float                  rsqrtf(float x);

to:

    double                 rsqrt(double x) noexcept (true);
    float                  rsqrtf(float x) noexcept (true);

No CUDA libraries or binaries need to be modified. Only
`math_functions.h` is patched.

This patch is required for the current GCC 16 build environment and
is not a modification to the CUDA runtime or NVIDIA driver.

### Build Requirements

- NVIDIA CUDA Toolkit 12.8
- GCC/G++ 16.1 or compatible GCC 16.x compiler
- NVIDIA GPU with Compute Capability 3.5 or newer
- cURL
- pthreads
- OpenMP
- NVML for NVIDIA GPU monitoring

### Supported GPUs

Supports NVIDIA Kepler (GK110), Maxwell and Pascal architecture
GPUs only.

Compute Capability 3.5+ is required due to the use of funnel-shift
instructions.

### Windows

Windows support is retained from the original CUDAminer project.
Build requirements may differ from the current Linux toolchain.
