// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.7;

import { Test } from "../lib/forge-std/src/Test.sol";

import { ERC20Helper } from "../src/ERC20Helper.sol";

import {
    ERC20TrueReturner,
    ERC20FalseReturner,
    ERC20NoReturner,
    ERC20Reverter
} from "./mocks/ERC20Mocks.sol";

contract ERC20HelperTest is Test {

    using ERC20Helper for address;

    address internal falseReturner;
    address internal trueReturner;
    address internal noReturner;
    address internal reverter;

    function setUp() public {
        falseReturner = address(new ERC20FalseReturner());
        trueReturner  = address(new ERC20TrueReturner());
        noReturner    = address(new ERC20NoReturner());
        reverter      = address(new ERC20Reverter());
    }

    /**********************************************************************************************/
    /*** `safeTransfer` Tests                                                                   ***/
    /**********************************************************************************************/

    function testFuzz_safeTransfer_trueReturner(address to, uint256 amount) public {
        assertTrue(trueReturner.safeTransfer(to, amount));
    }

    function testFuzz_safeTransfer_noReturner(address to, uint256 amount) public {
        assertTrue(noReturner.safeTransfer(to, amount));
    }

    function testFuzz_safeTransfer_falseReturner(address to, uint256 amount) public {
        assertTrue(!falseReturner.safeTransfer(to, amount));
    }

    function testFuzz_safeTransfer_reverter(address to, uint256 amount) public {
        assertTrue(!reverter.safeTransfer(to, amount));
    }

    function testFuzz_safeTransfer_notContract(address to, uint256 amount) public {
        assertTrue(!address(1).safeTransfer(to, amount));
    }

    /**********************************************************************************************/
    /*** `safeTransferFrom` Tests                                                               ***/
    /**********************************************************************************************/

    function testFuzz_safeTransferFrom_trueReturner(address from, address to, uint256 amount)
        public
    {
        assertTrue(trueReturner.safeTransferFrom(from, to, amount));
    }

    function testFuzz_safeTransferFrom_noReturner(address from, address to, uint256 amount) public {
        assertTrue(noReturner.safeTransferFrom(from, to, amount));
    }

    function testFuzz_safeTransferFrom_falseReturner(address from, address to, uint256 amount)
        public
    {
        assertTrue(!falseReturner.safeTransferFrom(from, to, amount));
    }

    function testFuzz_safeTransferFrom_reverter(address from, address to, uint256 amount) public {
        assertTrue(!reverter.safeTransferFrom(from, to, amount));
    }

    function testFuzz_safeTransferFrom_notContract(address from, address to, uint256 amount)
        public
    {
        assertTrue(!address(1).safeTransferFrom(from, to, amount));
    }

    /**********************************************************************************************/
    /*** `safeApprove` Tests                                                                    ***/
    /**********************************************************************************************/

    function testFuzz_safeApprove_trueReturner(address to, uint256 amount) public {
        assertTrue(trueReturner.safeApprove(to, amount));
    }

    function testFuzz_safeApprove_noReturner(address to, uint256 amount) public {
        assertTrue(noReturner.safeApprove(to, amount));
    }

    function testFuzz_safeApprove_falseReturner(address to, uint256 amount) public {
        assertTrue(!falseReturner.safeApprove(to, amount));
    }

    function testFuzz_safeApprove_reverter(address to, uint256 amount) public {
        assertTrue(!reverter.safeApprove(to, amount));
    }

    function testFuzz_safeApprove_notContract(address to, uint256 amount) public {
        assertTrue(!address(1).safeApprove(to, amount));
    }

}
