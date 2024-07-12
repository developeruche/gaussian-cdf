## Gaussian-cdf

_This is one of the test questions for the paradigm fellowship_

**Question**
Implement a maximally optimized gaussian CDF on the EVM for arbitrary 18 decimal fixed point parameters x, μ, σ. Assume -1e20 ≤ μ ≤ 1e20 and 0 < σ ≤ 1e19. Should have an error less than 1e-8 vs errcw/gaussian for all x on the interval [-1e23, 1e23].


Gaussian CDF Implementation

The Gaussian CDF,  \Phi(x) , is given by:

 $$\Phi(x) = \frac{1}{2} \left( 1 + \text{erf} \left( \frac{x - \mu}{\sigma \sqrt{2}} \right) \right)$$

Error Function Approximation

The error function can be approximated using numerical methods. One common approximation is:

 $\text{erf}(z) \approx 1 - \frac{1}{(1 + a_1 z + a_2 z^2 + a_3 z^3 + a_4 z^4 + a_5 z^5)^4}$ 

where  $z = \frac{x - \mu}{\sigma \sqrt{2}}$  and  $a_1, a_2, a_3, a_4, a_5$  are pre-determined constants.



## Usage

### Build Solidity Implemention

```shell
$ forge build
```

### Test Solidity Implemention

```shell
$ forge test
```


