// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {GaussianCDF} from "../src/GaussianCDF.sol";

contract GaussianCDFTest is Test {
    GaussianCDF public cdf;

    function setUp() public {
        // mean = 12, std = 5; in 18 decimal fixed point
        cdf = new GaussianCDF(5000000000000000000, 12000000000000000000);
    }

    function testErf() public {
        int256 x = 1000000000000000000; // 1 in 18 decimal fixed point
        int256 result = cdf.erf(x);
        console.log("erf(x) = ", result);
        assertEq(result, -388422981738950516);
    }

    function testCdf() public {
        int256 x = 5500000000000000000; // 1 in 18 decimal fixed point
        int256 result = cdf.cdf(x);
        console.log("cdf(x) = ", result);
        assertEq(result, 713375488833109878);
    }
}
