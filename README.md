# ERC20 Helpers

![Foundry CI](https://github.com/marsfoundation/erc20-helpers/actions/workflows/ci.yml/badge.svg)
[![Foundry][foundry-badge]][foundry]
[![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://github.com/marsfoundation/erc20-helpers/blob/master/LICENSE)

[foundry]: https://getfoundry.sh/
[foundry-badge]: https://img.shields.io/badge/Built%20with-Foundry-FFDB1C.svg

## Overview

ERC20Helpers is a repo with utilities for interacting with ERC20 tokens.

- `SafeERC20` is a library that standardizes the behaviors of all commonly used implementations. It contains overridden functions so that both addresses and `IERC20` interfaces can be used.
- `MockERC20` is a contract that can be used in testing for a fully functional ERC20 token that has mint functionality.
- `IERC20` is an interface for interacting with ERC20 tokens that contains permit functionality.

## Setup

```sh
git clone git@github.com:marsfoundation/erc20-helpers.git
cd erc20-helpers
forge install
```

## Testing

To run the tests, do the following:

```
forge test
```

## Acknowledgements

These contracts were inspired by and/or directly modified from the following sources:

- [Maple Finance](https://github.com/maple-labs/erc20-helper/blob/main/src/ERC20Helper.sol) (this repo was forked from Maple Finance's repo).
- [Solmate](https://github.com/Rari-Capital/solmate)
- [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts)
- [Uniswap-v3](https://github.com/Uniswap/uniswap-v3-core/blob/main/contracts/libraries/TransferHelper.sol)

***
*The IP in this repository was assigned to Mars SPC Limited in respect of the MarsOne SP*
