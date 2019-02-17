# voclib wrapper
# written by amir ramezani

cdef extern from "voclib.h":
	ctypedef struct voclib_instance:
		pass

	# functions
	cdef int voclib_initialize ( voclib_instance* instance, unsigned char bands, unsigned char filters_per_band, unsigned int sample_rate, unsigned char carrier_channels )
	cdef int voclib_process ( voclib_instance* instance, const float* carrier_buffer, const float* modulator_buffer, float* output_buffer, unsigned int frames )
	cdef void voclib_reset_history ( voclib_instance* instance )
	cdef int voclib_set_reaction_time ( voclib_instance* instance, float reaction_time )
	cdef float voclib_get_reaction_time ( const voclib_instance* instance )
	cdef int voclib_set_formant_shift ( voclib_instance* instance, float formant_shift )
	cdef float voclib_get_formant_shift ( const voclib_instance* instance )
