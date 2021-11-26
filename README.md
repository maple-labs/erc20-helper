# ERC20 Helper

[![CircleCI](https://circleci.com/gh/maple-labs/erc20-helper/tree/main.svg?style=svg)](https://circleci.com/gh/maple-labs/erc20-helper/tree/main) [![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)

**DISCLAIMER: This code has NOT been externally audited and is actively being developed. Please do not use in production without taking the appropriate steps to ensure maximum security.**

Basic library designed to be used as a middleware between general smart contracts diverse erc20 tokens. It standardizes the behaviours of all commonly used implementations.

Note, unlike other similar libraries, this  library does not revert on failures, so it can be more flexible for contracts that:
- Want to choose their own revert strings, or none at all (i.e. `require(ERC20Helper.transfer(asset, msg.sender, amount), "FOO:FAILED_TRANSFER");`).
- Want to use the returns as booleans (i.e. `require(ERC20Helper.transfer(asset1, msg.sender, amount) || ERC20Helper.transfer(asset2, msg.sender, amount));`).
- Do not care about the result of a transfer.

To clone, set up and run tests:

```
git clone git@github.com:maple-labs/erc20-helper.git
dapp update
make test
```

## Acknowledgements

These contracts were inspired by and/or directly modified from the following sources:

- [Solmate](https://github.com/Rari-Capital/solmate)
- [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts)
- [Uniswap-v3](https://github.com/Uniswap/uniswap-v3-core/blob/main/contracts/libraries/TransferHelper.sol)

---

<p align="center">
  <img src="https://user-images.githubusercontent.com/44272939/116272804-33e78d00-a74f-11eb-97ab-77b7e13dc663.png" height="100" />
</p>
