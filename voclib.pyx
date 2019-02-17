cimport pyvoclib as vl
from libc.string cimport memcpy
from cython.view cimport *
from cpython.mem cimport PyMem_Malloc, PyMem_Free

cdef class vocoder_exception(Exception):
	pass

cdef class vocoder:
	cdef vl.voclib_instance* v
	def __cinit__(self):
		self.v = <vl.voclib_instance*> PyMem_Malloc(sizeof(vl.voclib_instance*))
		if not self.v:
			raise MemoryError()

	def __dealloc__(self):
		if self.v:
			PyMem_Free(<void*>self.v)

	def __init__(self, unsigned char bands, unsigned char filters, int sample_rate, carrier_channels):
		if vl.voclib_initialize (self.v, <unsigned char>bands, <unsigned char>filters, <int>sample_rate, <unsigned char>carrier_channels) == 0:
			raise vocoder_exception()

	def process (self, float[:] carrier_buffer not None, float[:] modulator_buffer not None, float[:] output_buffer, int frames):
		if vl.voclib_process (self.v, &carrier_buffer[0], &modulator_buffer[0], &output_buffer[0], frames) == 0:
			raise vocoder_exception()

	def reset_history(self):
		vl.voclib_reset_history(self.v)

	def set_reaction_time(self, float t):
		vl.voclib_set_reaction_time(self.v, t)

	def get_reaction_time(self):
		return vl.voclib_get_reaction_time(self.v)

	def set_formant_shift(self, float fs):
		vl.voclib_set_formant_shift(self.v, fs)

	def get_formant_shift(self):
		return vl.voclib_get_formant_shift(self.v)
