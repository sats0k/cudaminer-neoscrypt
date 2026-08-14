NeoScrypt CUDAminer
=======

NeoScrypt only. All other algorithms have been removed.

Requires the cURL library for network communication
(also pthreadVC2 and NVAPI on Windows).

### CUDA 12.8 / GCC 16 Compatibility

The current Linux build is tested with CUDA 12.8 and GCC 16.1.

The CUDA 12.8 installation used for development was obtained from the
Arch Linux Archive (ALA). It may differ from the current CUDA packages
available from the distribution or from the official NVIDIA CUDA
toolkit.

When compiling with GCC 16, the following two declarations in
`math_functions.h` need to be changed:

    /opt/cuda/include/crt/math_functions.h

From:

    double                 rsqrt(double x);
    float                  rsqrtf(float x);

To:

    double                 rsqrt(double x) noexcept (true);
    float                  rsqrtf(float x) noexcept (true);

The changes can be applied with:

    sudo sed -i \
      's/double                 rsqrt(double x);/double                 rsqrt(double x) noexcept (true);/' \
      /opt/cuda/include/crt/math_functions.h

    sudo sed -i \
      's/float                  rsqrtf(float x);/float                  rsqrtf(float x) noexcept (true);/' \
      /opt/cuda/include/crt/math_functions.h

No other CUDA files are known to require modification.

The exact provenance and contents of the archived CUDA 12.8 package
used during development are not independently verified here. The
above `math_functions.h` changes are therefore documented as the
compatibility changes required by this build environment, rather than
as modifications made by the CUDA package itself.

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
