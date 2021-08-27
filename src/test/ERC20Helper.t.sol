// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.7;

import { DSTest } from "../../lib/ds-test/src/test.sol";

import { ERC20TrueReturner, ERC20FalseReturner, ERC20NoReturner, ERC20Reverter }  from "./mocks/ERC20Mocks.sol";

import { ERC20Helper } from "../ERC20Helper.sol";

contract ERC20HelperTest is DSTest {
    
    ERC20FalseReturner falseReturner;
    ERC20TrueReturner  trueReturner;
    ERC20NoReturner    noReturner;
    ERC20Reverter      reverter;

    function setUp() public {
        falseReturner = new ERC20FalseReturner();
        trueReturner  = new ERC20TrueReturner();
        noReturner    = new ERC20NoReturner();
        reverter      = new ERC20Reverter();
    }

    function prove_trasfer(address to, uint256 amount) public {
        ERC20Helper.transferHelper(address(trueReturner), to, amount);
        ERC20Helper.transferHelper(address(noReturner),   to, amount);
    }

    function prove_trasferFrom(address from, address to, uint256 amount) public {
        ERC20Helper.transferFromHelper(address(trueReturner), from, to, amount);
        ERC20Helper.transferFromHelper(address(noReturner),   from, to, amount);
    }

    function prove_approve(address to, uint256 amount) public {
        ERC20Helper.approveHelper(address(trueReturner), to, amount);
        ERC20Helper.approveHelper(address(noReturner),   to, amount);
    }

    function proveFail_trasfer_reverter(address to, uint256 amount) public {
        ERC20Helper.transferHelper(address(falseReturner), to, amount);
        ERC20Helper.transferHelper(address(reverter),      to, amount);
    }

    function proveFail_trasferFrom_reverter(address from, address to, uint256 amount) public {
        ERC20Helper.transferFromHelper(address(falseReturner), from, to, amount);
        ERC20Helper.transferFromHelper(address(reverter),      from, to, amount);
    }

    function proveFail_approve_reverter(address to, uint256 amount) public {
        ERC20Helper.approveHelper(address(falseReturner), to, amount);
        ERC20Helper.approveHelper(address(reverter),      to, amount);
    }
}


