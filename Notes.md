# ToDo
* add constants that describe the two fixed point formats in types.vhd
* Add overflow and shift to mac thing, based on constants from types.vhd
* Handle output
* Write testbench for first convolution.





# Week plan
	# Report
	* Software model of MNIST-classifier
	* Fixed point format and distribution of numbers, choosing a format({2,14},{1,10}).
	


	# Code
	* FullFillerMac: - Anthon
		* Add fixed point constants in types.vhd
		* Make MAC compatible with 8/16 bit fixed point. 
		* Add saturation to MAC.
		* Testbench.
	* RAM - Simon
		* Translator from x/y/z to block and depth.
			* Use a lookup table.
			* Calculated at synthesis.
			* Use loops to generate table.
		* Input/output and control.
		* Testbench.
		
	* Testbench for first convolution
		* romFirst as input
		* Ram as output
		* FullFillerMac as calculator
		* Experiment with different parallelism.