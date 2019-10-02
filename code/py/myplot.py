# Set things up
import matplotlib.pyplot as plt
import numpy as np

# Sample numpy array (linearly spaced values)
x = np.linspace(0, 10, 100)

# Plot sin(x) and cos(x)
plt.plot(x, np.sin(x), 'r-')
plt.plot(x, np.cos(x), 'b-')
plt.title("Sine and Cosine Functions")
plt.axis([-1, 11, -1.5, 1.5])

# Save default plot to file
plt.savefig('myplot.png')

# Show in interactive mode
plt.show()
