import numpy as np

reps = 5000
rolls = np.random.randint(1, 7, reps)
print("Simulating {:,d} die rolls".format(reps))
print("Mean: {:.3f}; Std. Dev.: {:.3f}".format(np.mean(rolls), np.std(rolls)))
print([list(rolls).count(j) for j in range(1, 7)])
print([list(rolls).count(j)/reps for j in range(1, 7)])

