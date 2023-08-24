// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.7;

import { TestUtils } from "../../lib/contract-test-utils/contracts/test.sol";

import { ERC20Helper } from "../ERC20Helper.sol";

import {
    ERC20TrueReturner,
    ERC20FalseReturner,
    ERC20NoReturner,
    ERC20Reverter
} from "./mocks/ERC20Mocks.sol";

import { IERC20 } from "./IERC20.sol";

contract ERC20HelperTest is TestUtils {

    using ERC20Helper for IERC20;

    IERC20 internal falseReturner;
    IERC20 internal trueReturner;
    IERC20 internal noReturner;
    IERC20 internal reverter;

    function setUp() public {
        falseReturner = IERC20(address(new ERC20FalseReturner()));
        trueReturner  = IERC20(address(new ERC20TrueReturner()));
        noReturner    = IERC20(address(new ERC20NoReturner()));
        reverter      = IERC20(address(new ERC20Reverter()));
    }

    function testFuzz_transfer_trueReturner(address to, uint256 amount) public {
        assertTrue(trueReturner.safeTransfer(to, amount));
    }

    function testFuzz_transfer_noReturner(address to, uint256 amount) public {
        assertTrue(ERC20Helper.transfer(address(noReturner), to, amount));
    }

    function testFuzz_transferFrom_trueReturner(address from, address to, uint256 amount) public {
        assertTrue(ERC20Helper.transferFrom(address(trueReturner), from, to, amount));
    }

    function testFuzz_transferFrom_noReturner(address from, address to, uint256 amount) public {
        assertTrue(ERC20Helper.transferFrom(address(noReturner), from, to, amount));
    }

    function testFuzz_approve_trueReturner(address to, uint256 amount) public {
        assertTrue(ERC20Helper.approve(address(trueReturner), to, amount));
    }

    function testFuzz_approve_noReturner(address to, uint256 amount) public {
        assertTrue(ERC20Helper.approve(address(noReturner), to, amount));
    }

    function testFuzz_fail_transfer_falseReturner(address to, uint256 amount) public {
        assertTrue(!ERC20Helper.transfer(address(falseReturner), to, amount));
    }

    function testFuzz_fail_transfer_reverter(address to, uint256 amount) public {
        assertTrue(!ERC20Helper.transfer(address(reverter), to, amount));
    }

    function testFuzz_fail_transfer_notContract(address to, uint256 amount) public {
        assertTrue(!ERC20Helper.transfer(address(1), to, amount));
    }

    function testFuzz_fail_transferFrom_falseReturner(address from, address to, uint256 amount)
        public
    {
        assertTrue(!ERC20Helper.transferFrom(address(falseReturner), from, to, amount));
    }

    function testFuzz_fail_transferFrom_reverter(address from, address to, uint256 amount) public {
        assertTrue(!ERC20Helper.transferFrom(address(reverter), from, to, amount));
    }

    function testFuzz_fail_transferFrom_notContract(address from, address to, uint256 amount)
        public
    {
        assertTrue(!ERC20Helper.transferFrom(address(1), from, to, amount));
    }

    function testFuzz_fail_approve_falseReturner(address to, uint256 amount) public {
        assertTrue(!ERC20Helper.approve(address(falseReturner), to, amount));
    }

    function testFuzz_fail_approve_reverter(address to, uint256 amount) public {
        assertTrue(!ERC20Helper.approve(address(reverter), to, amount));
    }

    function testFuzz_fail_approve_notContract(address to, uint256 amount) public {
        assertTrue(!ERC20Helper.approve(address(1), to, amount));
    }

}
