// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


import {PrecisionMath} from "./utils/PrecisionMath.sol";

contract GaussianCDF {
    using PrecisionMath for int256;


    //=================
    // Constants
    //=================
    int256 immutable STANDARD_DEVIATION; // standard deviation in 18 decimal fixed point
    int256 immutable MEAN; // mean in 18 decimal fixed point


    int256 constant A1 = 170000000000000000;  // 0.170 in 18 decimal fixed point
    int256 constant A2 = 89000000000000000;   // 0.089 in 18 decimal fixed point
    int256 constant A3 = 5000000000000000;    // 0.005 in 18 decimal fixed point
    int256 constant A4 = 2000000000000000;    // 0.002 in 18 decimal fixed point
    int256 constant A5 = 700000000000000;     // 0.0007 in 18 decimal fixed point


    function erf(int256 x) public pure returns (int256) {
        int256 absX = x >= 0 ? x : -x;

        int256 term1 = PrecisionMath.ONE; // 1
        int256 term2 = A1.mul(absX); // a1*z
        int256 term3 = A2.mul(absX).mul(absX); // (a2*z^2)
        int256 term4 = A3.mul(absX).mul(absX).mul(absX); // (a3*z^3)
        int256 term5 = A4.mul(absX).mul(absX).mul(absX).mul(absX); // (a4*z^4)
        int256 term6 = A5.mul(absX).mul(absX).mul(absX).mul(absX).mul(absX); // (a5*z^5)

        int256 termSumation = term1 + term2 + term3 + term4 + term5 + term6;
        int256 termSumPow4 = termSumation.mul(termSumation).mul(termSumation).mul(termSumation);
        int256 termsumInverse = PrecisionMath.ONE.div(termSumPow4);
        int256 erfResult = 1 - termsumInverse;

        return x >= 0 ? erfResult : -erfResult;
    }

    function cdf(int256 x) public view returns (int256) {
        return cdfWithCustomConfig(x, STANDARD_DEVIATION, MEAN);
    }

    function cdfWithCustomConfig(int256 x, int256 std, int256 mean) public pure returns (int256) {
        require(-1e20 <= mean && mean <= 1e20, "mu out of range");
        require(0 < std && std <= 1e19, "sigma out of range");
        require(-1e23 <= x && x <= 1e23, "x out of range");

        int256 z = (x - mean).div(std.mul(PrecisionMath.SQRT2));
        int256 erf_ = erf(z);
        return (PrecisionMath.ONE + erf_).div(PrecisionMath.TWO);
    }
}
