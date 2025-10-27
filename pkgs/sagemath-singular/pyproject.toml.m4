include(`sage_spkg_versions_toml.m4')dnl' -*- conf-toml -*-
[build-system]
# Minimum requirements for the build system to execute.
requires = [
    SPKG_INSTALL_REQUIRES_setuptools
    SPKG_INSTALL_REQUIRES_pkgconfig
    SPKG_INSTALL_REQUIRES_sage_conf
    SPKG_INSTALL_REQUIRES_sage_setup
    SPKG_INSTALL_REQUIRES_sagemath_environment
    SPKG_INSTALL_REQUIRES_sagemath_categories
    SPKG_INSTALL_REQUIRES_sagemath_ntl
    SPKG_INSTALL_REQUIRES_sagemath_flint
    SPKG_INSTALL_REQUIRES_sagemath_modules
    SPKG_INSTALL_REQUIRES_cython
    SPKG_INSTALL_REQUIRES_cysignals
    SPKG_INSTALL_REQUIRES_sagemath_pari
    SPKG_INSTALL_REQUIRES_memory_allocator
]
build-backend = "setuptools.build_meta"

[project]
name = "passagemath-singular"
description = "passagemath: Computer algebra, algebraic geometry, singularity theory with Singular"
dependencies = [
    SPKG_INSTALL_REQUIRES_sagemath_pari
    SPKG_INSTALL_REQUIRES_cysignals
    SPKG_INSTALL_REQUIRES_memory_allocator
    SPKG_INSTALL_REQUIRES_pexpect
    SPKG_INSTALL_REQUIRES_sagemath_environment
    SPKG_INSTALL_REQUIRES_sagemath_categories
    SPKG_INSTALL_REQUIRES_sagemath_modules
    SPKG_INSTALL_REQUIRES_sagemath_flint
]
dynamic = ["version"]
include(`pyproject_toml_metadata.m4')dnl'

[project.readme]
file = "README.rst"
content-type = "text/x-rst"

[project.optional-dependencies]
test = [
    "passagemath-repl",
]
jupyterkernel = [
    SPKG_INSTALL_REQUIRES_singular_jupyter
]
jupyterlab      = [
    "passagemath-singular[jupyterkernel]",
    SPKG_INSTALL_REQUIRES_jupyterlab
]
notebook        = [
    "passagemath-singular[jupyterkernel]",
    SPKG_INSTALL_REQUIRES_notebook
]


[tool.cibuildwheel.linux]
# Unfortunately CIBW_REPAIR_WHEEL_COMMAND does not expand {project} (and other placeholders),
# so there is no clean way to refer to the repair_wheel.py script
# https://github.com/pypa/cibuildwheel/issues/1931
repair-wheel-command = [
    'python3 -m pip install passagemath-conf auditwheel',
    'python3 pkgs/sagemath-singular/repair_wheel.py {wheel}',
    'auditwheel repair -w {dest_dir} {wheel}',
]
[tool.cibuildwheel.macos]
repair-wheel-command = [
    'python3 -m pip install passagemath-conf auditwheel',
    'python3 pkgs/sagemath-singular/repair_wheel.py {wheel}',
    'delocate-wheel --require-archs {delocate_archs} -w {dest_dir} -v {wheel}',
]

[tool.setuptools]
include-package-data = false

[tool.setuptools.dynamic]
version = {file = ["VERSION.txt"]}

[external]
# External dependencies in the format proposed by https://peps.python.org/pep-0725
build-requires = [
  "virtual:compiler/c",
  "virtual:compiler/cpp",
  "pkg:generic/pkg-config",
]

host-requires = [
  "pkg:generic/gmp",
  "pkg:generic/mpc",
  "pkg:generic/mpfr",
  "pkg:generic/singular",
  "pkg:generic/givaro",
]

dependencies = [
]
