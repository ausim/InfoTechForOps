import numpy as np

rolls = np.random.randint(1, 7, 10000)
print("Mean: {:.3f}; Std. Dev.: {:.3f}".format(np.mean(rolls), np.std(rolls)))
print([list(rolls).count(j) for j in range(1, 7)])
print([list(rolls).count(j)/10000 for j in range(1, 7)])
