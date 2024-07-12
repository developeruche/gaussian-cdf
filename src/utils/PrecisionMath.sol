// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;



library PrecisionMath {
    int256 constant PRECISION = 1e18;
    
    function mul(int256 a, int256 b) internal pure returns (int256) {
        return (a * b) / PRECISION;
    }

    function div(int256 a, int256 b) internal pure returns (int256) {
        return (a * PRECISION) / b;
    }
    
    function sqrt(int256 x) internal pure returns (int256) {
        int256 z = (x + 1) / 2;
        int256 y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
        return y;
    }
    
    function pow(int256 base, int256 exponent) internal pure returns (int256) {
        if (exponent == 0) {
            return 1; // Anything raised to the power of 0 is 1
        }
        int256 result = 1;
        int256 x = base;
        while (exponent > 0) {
            if (exponent % 2 == 1) {
                result = result * x;
            }
            x = x * x;
            exponent = exponent / 2;
        }
        return result;
    }
}