// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.7;

import "../lib/forge-std/src/Test.sol";

import { ERC20Helper } from "../src/ERC20Helper.sol";

import { IERC20Like } from "./IERC20Like.sol";

import {
    ERC20TrueReturner,
    ERC20FalseReturner,
    ERC20NoReturner,
    ERC20Reverter
} from "./mocks/ERC20Mocks.sol";

contract ERC20HelperTest is Test {

    using ERC20Helper for address;

    address public falseReturner;
    address public trueReturner;
    address public noReturner;
    address public reverter;

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

contract ERC20HelperMainnetTests is Test {

    using ERC20Helper for address;

    address public constant USDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
    address public constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address public constant DAI  = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address public constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    address[] public tokens = [USDT, USDC, DAI, WETH];

    address public from   = makeAddr("from");
    address public to     = makeAddr("to");
    address public caller = makeAddr("caller");
    uint256 public amount = 1000 ether;

    function setUp() external {
        vm.createSelectFork(getChain('mainnet').rpcUrl, 17_985_000);
    }

    function test_safeTransfer() public {
        for (uint256 i = 0; i < tokens.length; i++) {
            deal(tokens[i], address(this), amount);

            IERC20Like token = IERC20Like(tokens[i]);

            assertEq(token.balanceOf(address(this)), amount);
            assertEq(token.balanceOf(to),            0);

            assertTrue(!tokens[i].safeTransfer(to, amount + 1));
            assertTrue( tokens[i].safeTransfer(to, amount));

            assertEq(token.balanceOf(address(this)), 0);
            assertEq(token.balanceOf(to),            amount);
        }
    }

    function test_safeTransferFrom_balanceChecks() public {
        for (uint256 i = 0; i < tokens.length; i++) {
            deal(tokens[i], from, amount);

            vm.startPrank(from);
            tokens[i].safeApprove(caller, amount + 1);
            vm.stopPrank();

            IERC20Like token = IERC20Like(tokens[i]);

            assertEq(token.allowance(from, caller), amount + 1);
            assertEq(token.balanceOf(from), amount);
            assertEq(token.balanceOf(to),   0);

            vm.startPrank(caller);
            assertTrue(!tokens[i].safeTransferFrom(from, to, amount + 1));
            assertTrue( tokens[i].safeTransferFrom(from, to, amount));
            vm.stopPrank();

            assertEq(token.allowance(from, caller), 1);
            assertEq(token.balanceOf(from), 0);
            assertEq(token.balanceOf(to),   amount);
        }
    }

    function test_safeTransferFrom_approvalChecks() public {
        for (uint256 i = 0; i < tokens.length; i++) {
            deal(tokens[i], from, amount + 1);

            vm.startPrank(from);
            tokens[i].safeApprove(caller, amount);
            vm.stopPrank();

            IERC20Like token = IERC20Like(tokens[i]);

            assertEq(token.allowance(from, caller), amount);
            assertEq(token.balanceOf(from), amount + 1);
            assertEq(token.balanceOf(to),   0);

            vm.startPrank(caller);
            assertTrue(!tokens[i].safeTransferFrom(from, to, amount + 1));
            assertTrue( tokens[i].safeTransferFrom(from, to, amount));
            vm.stopPrank();

            assertEq(token.allowance(from, caller), 0);
            assertEq(token.balanceOf(from), 1);
            assertEq(token.balanceOf(to),   amount);
        }
    }

    function test_safeApprove() public {
        for (uint256 i = 0; i < tokens.length; i++) {
            IERC20Like token = IERC20Like(tokens[i]);

            assertEq(token.allowance(address(this), caller), 0);

            assertTrue(tokens[i].safeApprove(caller, amount));

            assertEq(token.allowance(address(this), caller), amount);
        }
    }

}
