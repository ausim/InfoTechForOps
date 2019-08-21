# Set things up
import matplotlib.pyplot as plt
import numpy as np

# Sample numpy array (linearly spaced values)
x = np.linspace(0, 10, 100)

# Plot sin(x) and cos(x)
plt.plot(x, np.sin(x))
plt.plot(x, np.cos(x))

# Save default plot to file
plt.savefig('myplot.png')

# Show in interactive mode
plt.show()
