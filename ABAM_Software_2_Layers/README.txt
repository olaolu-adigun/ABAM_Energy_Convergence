 BIDIRECTIONAL ASSOCIATIVE MEMORY (BAM)  SIMULATION FOR A 2-LAYER NETWORK.

This software alternates between forward synaptic projection and backward synatic projection on a weight matrix W until the energy converges to a fixed point. 


INPUTS:
-- ox    - Initial input vector.
-- W    - Weight matrix connecting the two layers. You can choose the elements of W randomly or otherwise depending on your choice.
-- mode - Set the mode to 'Bipolar' for bipolar representation otherwise it works as binary representation.
-- I    - Size of input neurons.
-- J    - Size of output neurons.
-- thr1 - Threshold value for input neurons
-- thr2 - Threshold value for output neurons
  
OUTPUTS
The software writes the following information to a result file:
-- ax   - Inpuut layer activation after convergence
-- ay   - Output layer activation after convergence
-- E    - Energy after each iteration


Instruction.
(1). Adjust the inputs in BAM_2_Layers.m to suit your purpose.
(2). Run the program.
(3). Open the output file (result.txt) to see the result.