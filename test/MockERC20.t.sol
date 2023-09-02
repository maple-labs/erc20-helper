// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import { MockERC20 } from "../src/MockERC20.sol";

import { Test } from "../lib/forge-std/src/Test.sol";

contract MockERC20Test is Test {

    address internal immutable self = address(this);

    bytes internal constant ARITHMETIC_ERROR = abi.encodeWithSignature("Panic(uint256)", 0x11);

    MockERC20 internal token;

    function setUp() public virtual {
        token = new MockERC20("Token", "TKN", 18);
    }

    function invariant_metadata() public {
        assertEq(token.name(),     "Token");
        assertEq(token.symbol(),   "TKN");
        assertEq(token.decimals(), 18);
    }

    function testFuzz_metadata(string memory name_, string memory symbol_, uint8 decimals_) public {
        MockERC20 mockToken = new MockERC20(name_, symbol_, decimals_);

        assertEq(mockToken.name(),     name_);
        assertEq(mockToken.symbol(),   symbol_);
        assertEq(mockToken.decimals(), decimals_);
    }

    function testFuzz_mint(address account_, uint256 amount_) public {
        token.mint(account_, amount_);

        assertEq(token.totalSupply(),       amount_);
        assertEq(token.balanceOf(account_), amount_);
    }

    function testFuzz_burn(address account_, uint256 amount0_, uint256 amount1_) public {
        if (amount1_ > amount0_) return;  // Mint amount must exceed burn amount.

        token.mint(account_, amount0_);
        token.burn(account_, amount1_);

        assertEq(token.totalSupply(),       amount0_ - amount1_);
        assertEq(token.balanceOf(account_), amount0_ - amount1_);
    }

    function testFuzz_approve(address account_, uint256 amount_) public {
        assertTrue(token.approve(account_, amount_));

        assertEq(token.allowance(self, account_), amount_);
    }

    function testFuzz_increaseAllowance(address account_, uint256 initialAmount_, uint256 addedAmount_) public {
        initialAmount_ = bound(initialAmount_, 0, type(uint256).max / 2);
        addedAmount_   = bound(addedAmount_,   0, type(uint256).max / 2);

        token.approve(account_, initialAmount_);

        assertEq(token.allowance(self, account_), initialAmount_);

        assertTrue(token.increaseAllowance(account_, addedAmount_));

        assertEq(token.allowance(self, account_), initialAmount_ + addedAmount_);
    }

    function testFuzz_decreaseAllowance_infiniteApproval(address account_, uint256 subtractedAmount_) public {
        uint256 MAX_UINT256 = type(uint256).max;

        subtractedAmount_ = bound(subtractedAmount_, 0, MAX_UINT256);

        token.approve(account_, MAX_UINT256);

        assertEq(token.allowance(self, account_), MAX_UINT256);

        assertTrue(token.decreaseAllowance(account_, subtractedAmount_));

        assertEq(token.allowance(self, account_), MAX_UINT256);
    }

    function testFuzz_decreaseAllowance_nonInfiniteApproval(address account_, uint256 initialAmount_, uint256 subtractedAmount_) public {
        initialAmount_    = bound(initialAmount_,    0, type(uint256).max - 1);
        subtractedAmount_ = bound(subtractedAmount_, 0, initialAmount_);

        token.approve(account_, initialAmount_);

        assertEq(token.allowance(self, account_), initialAmount_);

        assertTrue(token.decreaseAllowance(account_, subtractedAmount_));

        assertEq(token.allowance(self, account_), initialAmount_ - subtractedAmount_);
    }

    function testFuzz_transfer(address account_, uint256 amount_) public {
        token.mint(self, amount_);

        assertTrue(token.transfer(account_, amount_));

        assertEq(token.totalSupply(), amount_);

        if (self == account_) {
            assertEq(token.balanceOf(self), amount_);
        } else {
            assertEq(token.balanceOf(self),     0);
            assertEq(token.balanceOf(account_), amount_);
        }
    }

    function testFuzz_transferFrom(address recipient_, uint256 approval_, uint256 amount_) public {
        approval_ = bound(approval_, 0, type(uint256).max - 1);
        amount_   = bound(amount_,   0, approval_);

        address owner = makeAddr("owner");

        token.mint(address(owner), amount_);

        vm.prank(owner);
        token.approve(self, approval_);

        assertTrue(token.transferFrom(address(owner), recipient_, amount_));

        assertEq(token.totalSupply(), amount_);

        approval_ = address(owner) == self ? approval_ : approval_ - amount_;

        assertEq(token.allowance(address(owner), self), approval_);

        if (address(owner) == recipient_) {
            assertEq(token.balanceOf(address(owner)), amount_);
        } else {
            assertEq(token.balanceOf(address(owner)), 0);
            assertEq(token.balanceOf(recipient_), amount_);
        }
    }

    function testFuzz_transferFrom_infiniteApproval(address recipient_, uint256 amount_) public {
        uint256 MAX_UINT256 = type(uint256).max;

        amount_ = bound(amount_, 0, MAX_UINT256);

        address owner = makeAddr("owner");

        token.mint(address(owner), amount_);
        vm.prank(owner);
        token.approve(self, MAX_UINT256);

        assertEq(token.balanceOf(address(owner)),       amount_);
        assertEq(token.totalSupply(),                   amount_);
        assertEq(token.allowance(address(owner), self), MAX_UINT256);

        assertTrue(token.transferFrom(address(owner), recipient_, amount_));

        assertEq(token.totalSupply(),                   amount_);
        assertEq(token.allowance(address(owner), self), MAX_UINT256);

        if (address(owner) == recipient_) {
            assertEq(token.balanceOf(address(owner)), amount_);
        } else {
            assertEq(token.balanceOf(address(owner)), 0);
            assertEq(token.balanceOf(recipient_),     amount_);
        }
    }

    function testFuzz_transfer_insufficientBalance(/*address recipient_, uint256 amount_*/) public {
        uint256 amount_ = 0;
        address recipient_ = address(0);

        amount_ = amount_ == 0 ? 1 : amount_;

        address account = makeAddr("account");

        token.mint(address(account), amount_ - 1);

        vm.expectRevert(ARITHMETIC_ERROR);
        vm.prank(account);
        token.transfer(recipient_, amount_);

        token.mint(address(account), 1);

        vm.prank(account);
        token.transfer(recipient_, amount_);

        assertEq(token.balanceOf(recipient_), amount_);
    }

    function testFuzz_transferFrom_insufficientAllowance(address recipient_, uint256 amount_) public {
        amount_ = amount_ == 0 ? 1 : amount_;

        address owner = makeAddr("owner");

        token.mint(address(owner), amount_);

        vm.prank(owner);
        token.approve(self, amount_ - 1);

        vm.expectRevert(ARITHMETIC_ERROR);
        token.transferFrom(address(owner), recipient_, amount_);

        vm.prank(owner);
        token.approve(self, amount_);
        token.transferFrom(address(owner), recipient_, amount_);

        assertEq(token.balanceOf(recipient_), amount_);
    }

    function testFuzz_transferFrom_insufficientBalance(address recipient_, uint256 amount_) public {
        amount_ = amount_ == 0 ? 1 : amount_;

        address owner = makeAddr("owner");

        token.mint(address(owner), amount_ - 1);
        vm.prank(owner);
        token.approve(self, amount_);

        vm.expectRevert(ARITHMETIC_ERROR);
        token.transferFrom(address(owner), recipient_, amount_);

        token.mint(address(owner), 1);
        token.transferFrom(address(owner), recipient_, amount_);

        assertEq(token.balanceOf(recipient_), amount_);
    }

}
