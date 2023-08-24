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

    function testFuzz_transfer_trueReturner(address to, uint256 amount) public {
        assertTrue(trueReturner.safeTransfer(to, amount));
    }

    function testFuzz_transfer_noReturner(address to, uint256 amount) public {
        assertTrue(noReturner.safeTransfer(to, amount));
    }

    function testFuzz_transferFrom_trueReturner(address from, address to, uint256 amount) public {
        assertTrue(trueReturner.safeTransferFrom(from, to, amount));
    }

    function testFuzz_transferFrom_noReturner(address from, address to, uint256 amount) public {
        assertTrue(noReturner.safeTransferFrom(from, to, amount));
    }

    function testFuzz_approve_trueReturner(address to, uint256 amount) public {
        assertTrue(trueReturner.safeApprove(to, amount));
    }

    function testFuzz_approve_noReturner(address to, uint256 amount) public {
        assertTrue(noReturner.safeApprove(to, amount));
    }

    function testFuzz_fail_transfer_falseReturner(address to, uint256 amount) public {
        assertTrue(!falseReturner.safeTransfer(to, amount));
    }

    function testFuzz_fail_transfer_reverter(address to, uint256 amount) public {
        assertTrue(!reverter.safeTransfer(to, amount));
    }

    function testFuzz_fail_transfer_notContract(address to, uint256 amount) public {
        assertTrue(!address(1).safeTransfer(to, amount));
    }

    function testFuzz_fail_transferFrom_falseReturner(address from, address to, uint256 amount)
        public
    {
        assertTrue(!falseReturner.safeTransferFrom(from, to, amount));
    }

    function testFuzz_fail_transferFrom_reverter(address from, address to, uint256 amount) public {
        assertTrue(!reverter.safeTransferFrom(from, to, amount));
    }

    function testFuzz_fail_transferFrom_notContract(address from, address to, uint256 amount)
        public
    {
        assertTrue(!address(1).safeTransferFrom(from, to, amount));
    }

    function testFuzz_fail_approve_falseReturner(address to, uint256 amount) public {
        assertTrue(!falseReturner.safeApprove(to, amount));
    }

    function testFuzz_fail_approve_reverter(address to, uint256 amount) public {
        assertTrue(!reverter.safeApprove(to, amount));
    }

    function testFuzz_fail_approve_notContract(address to, uint256 amount) public {
        assertTrue(!address(1).safeApprove(to, amount));
    }

}
