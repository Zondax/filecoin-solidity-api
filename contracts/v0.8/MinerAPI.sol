// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.4.25 <=0.8.17;

import "./types/MinerTypes.sol";
import "./utils/Misc.sol";
import "./cbor/MinerCbor.sol";
import "./utils/Misc.sol";

uint64 constant ADDRESS_MAX_LEN = 86;
uint64 constant CODEC = 0x71;

/// @title This contract is a proxy to a built-in Miner actor. Calling one of its methods will result in a cross-actor call being performed.
/// @notice During miner initialization, a miner actor is created on the chain, and this actor gives the miner its ID f0.... The miner actor is in charge of collecting all the payments sent to the miner.
/// @dev For more info about the miner actor, please refer to https://lotus.filecoin.io/storage-providers/operate/addresses/
/// @author Zondax AG
contract MinerAPI {
    using ChangeBeneficiaryCBOR for MinerTypes.ChangeBeneficiaryParams;
    using GetOwnerCBOR for MinerTypes.GetOwnerReturn;
    using AddressCBOR for bytes;
    using IsControllingAddressCBOR for MinerTypes.IsControllingAddressReturn;
    using GetSectorSizeCBOR for MinerTypes.GetSectorSizeReturn;
    using GetAvailableBalanceCBOR for MinerTypes.GetAvailableBalanceReturn;
    using GetVestingFundsCBOR for MinerTypes.GetVestingFundsReturn;
    using GetBeneficiaryCBOR for MinerTypes.GetBeneficiaryReturn;

    /*uint32 actor_id;

    constructor(uint32 _actor_id) {
        actor_id = _actor_id
    }*/

    /// @notice Income and returned collateral are paid to this address
    /// @notice This address is also allowed to change the worker address for the miner
    /// @return the owner address of a Miner
    function get_owner() public returns (MinerTypes.GetOwnerReturn memory) {
        // FIXME: find the method num
        uint64 method_num = 0x00;

        bytes memory raw_response = new bytes(0x80);

        assembly {
            let input := mload(0x40)
            mstore(input, method_num)
            mstore(add(input, 0x20), CODEC)
            // address size
            mstore(add(input, 0x40), 0x02)
            // params size
            mstore(add(input, 0x60), 0x00)
            // actual address
            mstore(add(input, 0x80), hex"0066")
            // no params

            // call(gasLimit, to, value, inputOffset, inputSize, outputOffset, outputSize)
            if iszero(call(100000000, 0x0e, 0x00, input, 0x0100, raw_response, 0x80)) {
                revert(0, 0)
            }
        }

        // FIXME create bytes array with correct size
        bytes memory result = new bytes(0x0a);
        uint src;
        uint dst;
        assembly {
            src := add(raw_response, 0x80)
            dst := add(result, 0x20)
        }
        Misc.copy(src, dst, 0x0a);

        MinerTypes.GetOwnerReturn memory response;
        response.deserialize(result);

        return response;
    }

    /// @param addr New owner address
    /// @notice Proposes or confirms a change of owner address.
    /// @notice If invoked by the current owner, proposes a new owner address for confirmation. If the proposed address is the current owner address, revokes any existing proposal that proposed address.
    function change_owner_address(bytes memory addr) public {
        uint64 method_num = 23;

        assembly {
            let kek := mload(add(addr, 0x20))
            let input := mload(0x40)
            mstore(input, method_num)
            mstore(add(input, 0x20), CODEC)
            // address size
            mstore(add(input, 0x40), 0x02)
            // params size
            mstore(add(input, 0x60), mload(addr))
            // actual params
            mstore(add(input, 0x80), kek)
            // actual address
            mstore(add(input, 0xa0), hex"0066")

            // call(gasLimit, to, value, inputOffset, inputSize, outputOffset, outputSize)
            if iszero(call(100000000, 0x0e, 0x00, input, 0x0120, 0x00, 0x00)) {
                revert(0, 0)
            }
        }

        return;
    }

    /// @param addr The "controlling" addresses are the Owner, the Worker, and all Control Addresses.
    /// @return Whether the provided address is "controlling".
    function is_controlling_address(bytes memory addr) public returns (MinerTypes.IsControllingAddressReturn memory) {
        // FIXME: find the method num
        uint64 method_num = 0x00;

        bytes memory raw_response = new bytes(0x20);

        assembly {
            let kek := mload(add(addr, 0x20))
            let input := mload(0x40)
            mstore(input, method_num)
            mstore(add(input, 0x20), CODEC)
            // address size
            mstore(add(input, 0x40), 0x02)
            // params size
            mstore(add(input, 0x60), mload(addr))
            // actual params
            mstore(add(input, 0x80), kek)
            // actual address
            mstore(add(input, 0xa0), hex"0066")
            // call(gasLimit, to, value, inputOffset, inputSize, outputOffset, outputSize)
            if iszero(call(100000000, 0x0e, 0x00, input, 0x0100, raw_response, 0x20)) {
                revert(0, 0)
            }
        }

        // FIXME create bytes array with correct size
        bytes memory result = new bytes(0x0a);
        uint src;
        uint dst;
        assembly {
            src := add(raw_response, 0x80)
            dst := add(result, 0x20)
        }
        Misc.copy(src, dst, 0x0a);

        MinerTypes.IsControllingAddressReturn memory response;
        response.deserialize(result);

        return response;
    }

    /// @return the miner's sector size.
    /// @dev For more information about sector sizes, please refer to https://spec.filecoin.io/systems/filecoin_mining/sector/#section-systems.filecoin_mining.sector
    function get_sector_size() public returns (MinerTypes.GetSectorSizeReturn memory) {
        // FIXME: find the method num
        uint64 method_num = 0x00;

        bytes memory raw_response = new bytes(0x20);

        assembly {
            let input := mload(0x40)
            mstore(input, method_num)
            mstore(add(input, 0x20), CODEC)
            // address size
            mstore(add(input, 0x40), 0x02)
            // params size
            mstore(add(input, 0x60), 0x00)
            // actual address
            mstore(add(input, 0x80), hex"0066")
            // no params
            // call(gasLimit, to, value, inputOffset, inputSize, outputOffset, outputSize)
            if iszero(call(100000000, 0x0e, 0x00, input, 0x0100, raw_response, 0x20)) {
                revert(0, 0)
            }
        }

        // FIXME create bytes array with correct size
        bytes memory result = new bytes(0x0a);
        uint src;
        uint dst;
        assembly {
            src := add(raw_response, 0x80)
            dst := add(result, 0x20)
        }
        Misc.copy(src, dst, 0x0a);

        MinerTypes.GetSectorSizeReturn memory response;
        response.deserialize(result);

        return response;
    }

    /// @notice This is calculated as actor balance - (vesting funds + pre-commit deposit + initial pledge requirement + fee debt)
    /// @notice Can go negative if the miner is in IP debt.
    /// @return the available balance of this miner.
    function get_available_balance() public returns (MinerTypes.GetAvailableBalanceReturn memory) {
        // FIXME: find the method num
        uint64 method_num = 0x00;

        bytes memory raw_response = new bytes(0x20);

        assembly {
            let input := mload(0x40)
            mstore(input, method_num)
            mstore(add(input, 0x20), CODEC)
            // address size
            mstore(add(input, 0x40), 0x02)
            // params size
            mstore(add(input, 0x60), 0x00)
            // actual address
            mstore(add(input, 0x80), hex"0066")
            // no params
            // call(gasLimit, to, value, inputOffset, inputSize, outputOffset, outputSize)
            if iszero(call(100000000, 0x0e, 0x00, input, 0x0100, raw_response, 0x20)) {
                revert(0, 0)
            }
        }

        // FIXME create bytes array with correct size
        bytes memory result = new bytes(0x0a);
        uint src;
        uint dst;
        assembly {
            src := add(raw_response, 0x80)
            dst := add(result, 0x20)
        }
        Misc.copy(src, dst, 0x0a);

        MinerTypes.GetAvailableBalanceReturn memory response;
        response.deserialize(result);

        return response;
    }

    /// @return the funds vesting in this miner as a list of (vesting_epoch, vesting_amount) tuples.
    function get_vesting_funds() public returns (MinerTypes.GetVestingFundsReturn memory) {
        // FIXME: find the method num
        uint64 method_num = 0x00;

        // FIXME: unknown size for the response
        bytes memory raw_response = new bytes(0x0100);

        assembly {
            let input := mload(0x40)
            mstore(input, method_num)
            mstore(add(input, 0x20), CODEC)
            // address size
            mstore(add(input, 0x40), 0x02)
            // params size
            mstore(add(input, 0x60), 0x00)
            // actual address
            mstore(add(input, 0x80), hex"0066")
            // no params
            // call(gasLimit, to, value, inputOffset, inputSize, outputOffset, outputSize)
            if iszero(call(100000000, 0x0e, 0x00, input, 0x0100, raw_response, 0x0100)) {
                revert(0, 0)
            }
        }

        // FIXME create bytes array with correct size
        bytes memory result = new bytes(0x0a);
        uint src;
        uint dst;
        assembly {
            src := add(raw_response, 0x80)
            dst := add(result, 0x20)
        }
        Misc.copy(src, dst, 0x0a);

        MinerTypes.GetVestingFundsReturn memory response;
        response.deserialize(result);

        return response;
    }

    /// @notice Proposes or confirms a change of beneficiary address.
    /// @notice A proposal must be submitted by the owner, and takes effect after approval of both the proposed beneficiary and current beneficiary, if applicable, any current beneficiary that has time and quota remaining.
    /// @notice See FIP-0029, https://github.com/filecoin-project/FIPs/blob/master/FIPS/fip-0029.md
    function change_beneficiary(MinerTypes.ChangeBeneficiaryParams memory params) public {
        bytes memory raw_request = params.serialize();
        uint64 method_num = 0x1e;

        // FIXME: unknown size for the response
        bytes memory raw_response = new bytes(0x0100);

        assembly {
            let request := mload(add(raw_request, 0x20))
            let input := mload(0x40)
            mstore(input, method_num)
            mstore(add(input, 0x20), CODEC)
            // address size
            mstore(add(input, 0x40), 0x02)
            // params size
            mstore(add(input, 0x60), mload(raw_request))
            // actual params
            mstore(add(input, 0x80), request)
            // actual address
            mstore(add(input, 0xa0), hex"0066")
            // no params
            // call(gasLimit, to, value, inputOffset, inputSize, outputOffset, outputSize)
            if iszero(call(100000000, 0x0e, 0x00, input, 0x0100, raw_response, 0x0100)) {
                revert(0, 0)
            }
        }

        return;
    }

    /// @notice This method is for use by other actors (such as those acting as beneficiaries), and to abstract the state representation for clients.
    /// @notice Retrieves the currently active and proposed beneficiary information.
    function get_beneficiary() public returns (MinerTypes.GetBeneficiaryReturn memory) {
        uint64 method_num = 0x1f;

        // FIXME: unknown size for the response
        bytes memory raw_response = new bytes(0x0200);

        assembly {
            let input := mload(0x40)
            mstore(input, method_num)
            mstore(add(input, 0x20), CODEC)
            // address size
            mstore(add(input, 0x40), 0x02)
            // params size
            mstore(add(input, 0x60), 0x00)
            // actual address
            mstore(add(input, 0x80), hex"0066")
            // no params
            // call(gasLimit, to, value, inputOffset, inputSize, outputOffset, outputSize)
            if iszero(call(100000000, 0x0e, 0x00, input, 0xa0, raw_response, 0x0200)) {
                revert(0, 0)
            }
        }

        /*uint256 exit_code = toUint256(raw_response, 0x00);
        uint256 codec = toUint256(raw_response, 0x20);
        uint256 offset = toUint256(raw_response, 0x40);
        uint256 size = toUint256(raw_response, 0x60);*/

        // FIXME create bytes array with correct size
        bytes memory result = new bytes(0x0a);
        uint src;
        uint dst;
        assembly {
            src := add(raw_response, 0x80)
            dst := add(result, 0x20)
        }
        Misc.copy(src, dst, 0x0a);

        MinerTypes.GetBeneficiaryReturn memory response;
        response.deserialize(result);

        return response;
    }
}
