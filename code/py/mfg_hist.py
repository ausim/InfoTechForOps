# File:  mfg.py - Monte Carlo Simulation of the New Product
#        Manufacturing example from class
#
# Created (Jeff Smith) August 27, 2014
#
# $Id: $
#-------------------------

# imports
import random
import matplotlib.pyplot as plt

# ------------------------------------------------------
# ------------ Parameter Definitions Start Here --------
# ------------------------------------------------------
# Number of replications of the simulation
Replications = 500000
# Number of bins in the histogram
NumBins = 35
# Debug -- if > 1, show the individual replication values
Debug = 0

# ------------------------------------------------------
# ------------ Function Definitions Start Here ---------
# ------------------------------------------------------
# function to sample the population
def sample() :
    q = random.uniform(8000,12000)
    v = random.normalvariate(7,2)
    while (v < 1.5 or v > 10) :
        v = random.normalvariate(7,2)
    p = random.normalvariate(10,3)
    while p < 1.0 :
        p = random.normalvariate(10,3)
    return (q*(p-v)-5000)

# ------------------------------------------------------
# ----------------- Model Starts Here ------------------
# ------------------------------------------------------
# Store the observations
tps = []
if (Debug > 0) :
    print("Replications:")
for i in range (Replications) :
    # sample the value
    tp = sample()
    # print if requested
    if (Debug > 0) :
        print(tp)
    # Accumulate for the average
    tps.append(tp)

# compute average
AvgTP = float(sum(tps))/Replications

# show solution
print("\nBased on {:,d} replications:".format(Replications))
print("\tAverage : {:.2f}".format(AvgTP))
print("\t  Range : ({:,.2f}, {:,.2f})".format(min(tps), max(tps)))
print("\tpr(<0)) : {:.4f}".format(
    float(len([v for v in tps if v < 0]))/Replications)
)

# create histogram
plt.hist(tps, bins=NumBins)
# yellow line at the sample mean
plt.axvline(AvgTP, color='y', linestyle='solid', linewidth=4)
# red line at 0
plt.axvline(0, color='r', linestyle='solid', linewidth=2)
plt.show()
