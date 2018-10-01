import numpy as np
import matplotlib.pyplot as plt

rvgs = np.random.normal(123.5, 27.50, 10000)
print("Mean: {:.2f}, Std. Dev: {:.2f}".format(np.mean(rvgs), np.std(rvgs)))
fig = plt.hist(rvgs)
plt.show()
