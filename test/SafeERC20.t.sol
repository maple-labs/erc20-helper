// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import "../lib/forge-std/src/Test.sol";

import { IERC20 } from "../src/interfaces/IERC20.sol";

import { SafeERC20Wrapper } from "./harnesses/SafeERC20Wrapper.sol";

import {
    ERC20ApproveSetToZero,
    ERC20ApproveFailOnSetToAmount,
    ERC20FalseReturner,
    ERC20NoReturner,
    ERC20Reverter,
    ERC20TrueReturner
} from "./mocks/ERC20Mocks.sol";

contract ERC20HelperTest is Test {

    address public approveAmountFail;
    address public approveZero;
    address public falseReturner;
    address public noReturner;
    address public reverter;
    address public trueReturner;

    // NOTE: This contract is necessary so that error messages can be parsed properly by
    //       `vm.expectRevert()`. This isn't possible if `using` keyword is used in test. Plus,
    //       this demonstrates more clearly how the library is used in practice.
    SafeERC20Wrapper public wrapper;

    function setUp() public {
        approveAmountFail = address(new ERC20ApproveFailOnSetToAmount());
        approveZero       = address(new ERC20ApproveSetToZero());
        falseReturner     = address(new ERC20FalseReturner());
        noReturner        = address(new ERC20NoReturner());
        reverter          = address(new ERC20Reverter());
        trueReturner      = address(new ERC20TrueReturner());

        wrapper = new SafeERC20Wrapper();
    }

    /**********************************************************************************************/
    /*** `safeTransfer` Tests                                                                   ***/
    /**********************************************************************************************/

    function testFuzz_safeTransfer_trueReturner(address to, uint256 amount) public {
        wrapper.safeTransfer(trueReturner, to, amount);
    }

    function testFuzz_safeTransfer_trueReturner_IERC20(address to, uint256 amount) public {
        wrapper.safeTransferIERC20(IERC20(trueReturner), to, amount);
    }

    function testFuzz_safeTransfer_noReturner(address to, uint256 amount) public {
        wrapper.safeTransfer(noReturner, to, amount);
    }

    function testFuzz_safeTransfer_noReturner_IERC20(address to, uint256 amount) public {
        wrapper.safeTransferIERC20(IERC20(noReturner), to, amount);
    }

    function testFuzz_safeTransfer_falseReturner(address to, uint256 amount) public {
        vm.expectRevert("SafeERC20/transfer-failed");
        wrapper.safeTransfer(falseReturner, to, amount);
    }

    function testFuzz_safeTransfer_falseReturner_IERC20(address to, uint256 amount) public {
        vm.expectRevert("SafeERC20/transfer-failed");
        wrapper.safeTransferIERC20(IERC20(falseReturner), to, amount);
    }

    function testFuzz_safeTransfer_reverter_IERC20(address to, uint256 amount) public {
        vm.expectRevert("SafeERC20/transfer-failed");
        wrapper.safeTransferIERC20(IERC20(reverter), to, amount);
    }

    function testFuzz_safeTransfer_reverter(address to, uint256 amount) public {
        vm.expectRevert("SafeERC20/transfer-failed");
        wrapper.safeTransfer(reverter, to, amount);
    }

    function testFuzz_safeTransfer_notContract(address to, uint256 amount) public {
        vm.expectRevert("SafeERC20/transfer-failed");
        wrapper.safeTransfer(address(1), to, amount);
    }

    function testFuzz_safeTransfer_notContract_IERC20(address to, uint256 amount) public {
        vm.expectRevert("SafeERC20/transfer-failed");
        wrapper.safeTransferIERC20(IERC20(address(1)), to, amount);
    }

    /**********************************************************************************************/
    /*** `safeTransferFrom` Tests                                                               ***/
    /**********************************************************************************************/

    function testFuzz_safeTransferFrom_trueReturner(address from, address to, uint256 amount)
        public
    {
        wrapper.safeTransferFrom(trueReturner, from, to, amount);
    }

    function testFuzz_safeTransferFrom_trueReturner_IERC20(address from, address to, uint256 amount)
        public
    {
        wrapper.safeTransferFromIERC20(IERC20(trueReturner), from, to, amount);
    }

    function testFuzz_safeTransferFrom_noReturner(address from, address to, uint256 amount) public {
        wrapper.safeTransferFrom(noReturner, from, to, amount);
    }

    function testFuzz_safeTransferFrom_noReturner_IERC20(address from, address to, uint256 amount)
        public
    {
        wrapper.safeTransferFromIERC20(IERC20(noReturner), from, to, amount);
    }

    function testFuzz_safeTransferFrom_falseReturner(address from, address to, uint256 amount)
        public
    {
        vm.expectRevert("SafeERC20/transfer-from-failed");
        wrapper.safeTransferFrom(falseReturner, from, to, amount);
    }

    function testFuzz_safeTransferFrom_falseReturner_IERC20(
        address from,
        address to,
        uint256 amount
    )
        public
    {
        vm.expectRevert("SafeERC20/transfer-from-failed");
        wrapper.safeTransferFromIERC20(IERC20(falseReturner), from, to, amount);
    }

    function testFuzz_safeTransferFrom_reverter(address from, address to, uint256 amount) public {
        vm.expectRevert("SafeERC20/transfer-from-failed");
        wrapper.safeTransferFrom(reverter, from, to, amount);
    }

    function testFuzz_safeTransferFrom_reverter_IERC20(address from, address to, uint256 amount)
        public
    {
        vm.expectRevert("SafeERC20/transfer-from-failed");
        wrapper.safeTransferFromIERC20(IERC20(reverter), from, to, amount);
    }

    function testFuzz_safeTransferFrom_notContract(address from, address to, uint256 amount)
        public
    {
        vm.expectRevert("SafeERC20/transfer-from-failed");
        wrapper.safeTransferFrom(address(1), from, to, amount);
    }

    function testFuzz_safeTransferFrom_notContract_IERC20(address from, address to, uint256 amount)
        public
    {
        vm.expectRevert("SafeERC20/transfer-from-failed");
        wrapper.safeTransferFromIERC20(IERC20(address(1)), from, to, amount);
    }

    /**********************************************************************************************/
    /*** `safeApprove` Tests                                                                    ***/
    /**********************************************************************************************/

    function testFuzz_safeApprove_trueReturner(address to, uint256 amount) public {
        wrapper.safeApprove(trueReturner, to, amount);
    }

    function testFuzz_safeApprove_trueReturner_IERC20(address to, uint256 amount) public {
        wrapper.safeApproveIERC20(IERC20(trueReturner), to, amount);
    }

    function testFuzz_safeApprove_noReturner(address to, uint256 amount) public {
        wrapper.safeApprove(noReturner, to, amount);
    }

    function testFuzz_safeApprove_noReturner_IERC20(address to, uint256 amount) public {
        wrapper.safeApproveIERC20(IERC20(noReturner), to, amount);
    }

    function testFuzz_safeApprove_falseReturner(address to, uint256 amount) public {
        vm.expectRevert("SafeERC20/approve-zero-failed");
        wrapper.safeApprove(falseReturner, to, amount);
    }

    function testFuzz_safeApprove_falseReturner_IERC20(address to, uint256 amount) public {
        vm.expectRevert("SafeERC20/approve-zero-failed");
        wrapper.safeApproveIERC20(IERC20(falseReturner), to, amount);
    }

    function testFuzz_safeApprove_reverter(address to, uint256 amount) public {
        vm.expectRevert("SafeERC20/approve-zero-failed");
        wrapper.safeApprove(reverter, to, amount);
    }

    function testFuzz_safeApprove_reverter_IERC20(address to, uint256 amount) public {
        vm.expectRevert("SafeERC20/approve-zero-failed");
        wrapper.safeApproveIERC20(IERC20(reverter), to, amount);
    }

    function testFuzz_safeApprove_notContract(address to, uint256 amount) public {
        vm.expectRevert("SafeERC20/approve-zero-failed");
        wrapper.safeApprove(address(1), to, amount);
    }

    function testFuzz_safeApprove_notContract_IERC20(address to, uint256 amount) public {
        vm.expectRevert("SafeERC20/approve-zero-failed");
        wrapper.safeApproveIERC20(IERC20(address(1)), to, amount);
    }

    function testFuzz_safeApprove_approveAmountFailure(address to, uint256 amount) public {
        vm.assume(amount != 0);

        vm.expectRevert("SafeERC20/approve-amount-failed");
        wrapper.safeApprove(approveAmountFail, to, amount);
    }

    function testFuzz_safeApprove_approveAmountFailure_IERC20(address to, uint256 amount) public {
        vm.assume(amount != 0);

        vm.expectRevert("SafeERC20/approve-amount-failed");
        wrapper.safeApproveIERC20(IERC20(approveAmountFail), to, amount);
    }

    function testFuzz_safeApprove_approveNonZero(address to, uint256 amount) public {
        vm.assume(amount != 0);

        // Show that direct interaction doesn't allow to set without setting to zero first.
        ERC20ApproveSetToZero(approveZero).approve(to, amount);

        vm.expectRevert("ERC20/approve-set-to-non-zero");
        ERC20ApproveSetToZero(approveZero).approve(to, amount);

        ERC20ApproveSetToZero(approveZero).approve(to, 0);

        ERC20ApproveSetToZero(approveZero).approve(to, amount);

        // Show that wrapper handles this case by making two approvals
        wrapper.safeApprove(approveZero, to, amount);

        wrapper.safeApprove(approveZero, to, amount);
    }

    function testFuzz_safeApprove_approveNonZero_IERC20(address to, uint256 amount) public {
        vm.assume(amount != 0);

        // Show that direct interaction doesn't allow to set without setting to zero first.
        ERC20ApproveSetToZero(approveZero).approve(to, amount);

        vm.expectRevert("ERC20/approve-set-to-non-zero");
        ERC20ApproveSetToZero(approveZero).approve(to, amount);

        ERC20ApproveSetToZero(approveZero).approve(to, 0);

        ERC20ApproveSetToZero(approveZero).approve(to, amount);

        // Show that wrapper handles this case by making two approvals
        wrapper.safeApproveIERC20(IERC20(approveZero), to, amount);

        wrapper.safeApproveIERC20(IERC20(approveZero), to, amount);
    }

}

contract ERC20HelperMainnetTests is Test {

    address public constant USDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
    address public constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address public constant DAI  = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address public constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    address[] public tokens = [USDT, USDC, DAI, WETH];

    address public to     = makeAddr("to");
    uint256 public amount = 1000 ether;

    // NOTE: These contracts are necessary so that error messages can be parsed properly by
    //       `vm.expectRevert()`. This isn't possible if `using` keyword is used in test. Plus,
    //       this demonstrates more clearly how the library is used in practice.
    SafeERC20Wrapper public caller;
    SafeERC20Wrapper public from;

    function setUp() external {
        vm.createSelectFork(getChain('mainnet').rpcUrl, 17_985_000);

        caller = new SafeERC20Wrapper();
        from   = new SafeERC20Wrapper();
    }

    function test_safeTransfer() public {
        for (uint256 i = 0; i < tokens.length; i++) {
            deal(tokens[i], address(from), amount);

            IERC20 token = IERC20(tokens[i]);

            assertEq(token.balanceOf(address(from)), amount);
            assertEq(token.balanceOf(to),            0);

            vm.expectRevert("SafeERC20/transfer-failed");
            from.safeTransfer(tokens[i], to, amount + 1);

            from.safeTransfer(tokens[i], to, amount);

            assertEq(token.balanceOf(address(from)), 0);
            assertEq(token.balanceOf(to),            amount);
        }
    }

    function test_safeTransfer_IERC20() public {
        for (uint256 i = 0; i < tokens.length; i++) {
            deal(tokens[i], address(from), amount);

            IERC20 token = IERC20(tokens[i]);

            assertEq(token.balanceOf(address(from)), amount);
            assertEq(token.balanceOf(to),            0);

            vm.expectRevert("SafeERC20/transfer-failed");
            from.safeTransferIERC20(token, to, amount + 1);

            from.safeTransferIERC20(token, to, amount);

            assertEq(token.balanceOf(address(from)), 0);
            assertEq(token.balanceOf(to),            amount);
        }
    }

    function test_safeTransferFrom_balanceChecks() public {
        for (uint256 i = 0; i < tokens.length; i++) {
            deal(tokens[i], address(from), amount);

            from.safeApprove(tokens[i], address(caller), amount + 1);

            IERC20 token = IERC20(tokens[i]);

            assertEq(token.allowance(address(from), address(caller)), amount + 1);

            assertEq(token.balanceOf(address(from)), amount);
            assertEq(token.balanceOf(to),            0);

            vm.expectRevert("SafeERC20/transfer-from-failed");
            caller.safeTransferFrom(tokens[i], address(from), to, amount + 1);

            caller.safeTransferFrom(tokens[i], address(from), to, amount);

            assertEq(token.allowance(address(from), address(caller)), 1);

            assertEq(token.balanceOf(address(from)), 0);
            assertEq(token.balanceOf(to),            amount);
        }
    }

    function test_safeTransferFrom_balanceChecks_IERC20() public {
        for (uint256 i = 0; i < tokens.length; i++) {
            deal(tokens[i], address(from), amount);

            from.safeApprove(tokens[i], address(caller), amount + 1);

            IERC20 token = IERC20(tokens[i]);

            assertEq(token.allowance(address(from), address(caller)), amount + 1);

            assertEq(token.balanceOf(address(from)), amount);
            assertEq(token.balanceOf(to),            0);

            vm.expectRevert("SafeERC20/transfer-from-failed");
            caller.safeTransferFromIERC20(token, address(from), to, amount + 1);

            caller.safeTransferFromIERC20(token, address(from), to, amount);

            assertEq(token.allowance(address(from), address(caller)), 1);

            assertEq(token.balanceOf(address(from)), 0);
            assertEq(token.balanceOf(to),            amount);
        }
    }

    function test_safeTransferFrom_approvalChecks() public {
        for (uint256 i = 0; i < tokens.length; i++) {
            deal(tokens[i], address(from), amount + 1);

            from.safeApprove(tokens[i], address(caller), amount);

            IERC20 token = IERC20(tokens[i]);

            assertEq(token.allowance(address(from), address(caller)), amount);

            assertEq(token.balanceOf(address(from)), amount + 1);
            assertEq(token.balanceOf(to),            0);

            vm.expectRevert("SafeERC20/transfer-from-failed");
            caller.safeTransferFrom(tokens[i], address(from), to, amount + 1);

            caller.safeTransferFrom(tokens[i], address(from), to, amount);

            assertEq(token.allowance(address(from), address(caller)), 0);

            assertEq(token.balanceOf(address(from)), 1);
            assertEq(token.balanceOf(to),            amount);
        }
    }

    function test_safeTransferFrom_approvalChecks_IERC20() public {
        for (uint256 i = 0; i < tokens.length; i++) {
            deal(tokens[i], address(from), amount + 1);

            from.safeApprove(tokens[i], address(caller), amount);

            IERC20 token = IERC20(tokens[i]);

            assertEq(token.allowance(address(from), address(caller)), amount);

            assertEq(token.balanceOf(address(from)), amount + 1);
            assertEq(token.balanceOf(to),            0);

            vm.expectRevert("SafeERC20/transfer-from-failed");
            caller.safeTransferFromIERC20(token, address(from), to, amount + 1);

            caller.safeTransferFromIERC20(token, address(from), to, amount);

            assertEq(token.allowance(address(from), address(caller)), 0);

            assertEq(token.balanceOf(address(from)), 1);
            assertEq(token.balanceOf(to),            amount);
        }
    }

    function test_safeApprove() public {
        for (uint256 i = 0; i < tokens.length; i++) {
            IERC20 token = IERC20(tokens[i]);

            assertEq(token.allowance(address(from), address(caller)), 0);

            from.safeApprove(tokens[i], address(caller), amount);

            assertEq(token.allowance(address(from), address(caller)), amount);
        }
    }

    function test_safeApprove_IERC20() public {
        for (uint256 i = 0; i < tokens.length; i++) {
            IERC20 token = IERC20(tokens[i]);

            assertEq(token.allowance(address(from), address(caller)), 0);

            from.safeApproveIERC20(token, address(caller), amount);

            assertEq(token.allowance(address(from), address(caller)), amount);
        }
    }

}
