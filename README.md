Code for: Linking light-dependent life history traits with population dynamics for \it{Prochlorococcus} and cyanophages

This manuscript investigates the role of light-dark cycles on the infection dynamics of \it{Prochlorococcus} by cyanophages. Model fitting to the data is performed using a Markov Chain Monte Carlo DRAM algorithm from the MATLAB MCMC toolbox [1,2]. We modify slightly the original MCMC toolbox plotting codes (mcmcplot.m and mcmcpred.m) to adjust them to our specific model and dataset.

To plot the figures you will need additional functions:
- datamerge (from MCMC toolbox)
- fillyy (from MCMC toolbox)
- vfill (from Chad Greene 2019 [3])

Download and installation instructions for [1],[2] and [3] can be found here:
- MCMC toolbox by Marko Laine (MATLAB): https://mjlaine.github.io/mcmcstat/
- vfill function: https://www.mathworks.com/matlabcentral/fileexchange/43090-hfill-and-vfill

A preprint of the manuscript can be found on BioRxiv: XXX

This code is archived on Zenodo: [![DOI](https://zenodo.org/badge/196264197.svg)](https://zenodo.org/badge/latestdoi/196264197)

[1]: H. Haario, M. Laine, A. Mira and E. Saksman, 2006. DRAM: Efficient adaptive MCMC, Statistics and Computing 16, pp. 339-354. doi: 10.1007/s11222-006-9438-0.
[2]: H. Haario, E. Saksman and J. Tamminen, 2001. An adaptive Metropolis algorithm Bernoulli 7, pp. 223-242. doi: 10.2307/3318737
[3]: C. Greene (2019). hfill and vfill (https://www.mathworks.com/matlabcentral/fileexchange/43090-hfill-and-vfill), MATLAB Central File Exchange. Retrieved June 11, 2019.
