from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

exts = [
Extension("pyvoclib", sources = ["voclib.pyx"], define_macros=[("VOCLIB_IMPLEMENTATION", 1)])
]

setup(name="fsuipc",
ext_modules=cythonize(exts))
