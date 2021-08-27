// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.7;

//@title Small Library to standardize erc20 token interactions
library ERC20Helper {

    /**************************/
    /*** Internal Functions ***/
    /**************************/
    function transferHelper(
        address token,
        address to,
        uint256 amount
    ) internal {
        _call(token, abi.encodeWithSignature("transfer(address,uint256)", to, amount));
    }

    function transferFromHelper(
        address token,
        address from,
        address to,
        uint256 amount
    ) internal {
        _call(token, abi.encodeWithSignature("transferFrom(address,address,uint256)", from, to, amount));
    }

    function approveHelper(
        address token,
        address spender,
        uint256 amount
    ) internal {
        _call(token, abi.encodeWithSignature("approve(address,uint256)", spender, amount));
    }

    function _call(address token, bytes memory data) private {
        (bool ok, bytes memory returnData) = token.call(data);

        require(ok);

        if (returnData.length > 0) require(abi.decode(returnData, (bool)));
    }
}