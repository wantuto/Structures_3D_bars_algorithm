# Structures_3D_bars_algorithm
General code solving stresses, displacements, safety parameters of 3D structures composed by bars not neglecting weight.

In this code you would find a general code for solving aeronautical 3D structures such as a parachute, a delta wing, etc.

In the first place you should fill the input_data_02 file with your structure geometry.

You will find a numerical expression to solve the variation of velocity and acceleration that would affect Drag and Lift.

Finally, the postprocess function will return you 4 plots: safety factor vs time, maximum stresses (traction/compression) vs time, stresses in each bar at t_end, and displacements in each bar at t_end.
