// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.4.25 <=0.8.17;

import "solidity-cborutils/contracts/CBOR.sol";

import {MarketTypes} from "../types/MarketTypes.sol";
import "../utils/CborDecode.sol";

/// @title FIXME
/// @author Zondax AG
library WithdrawBalanceCBOR {
    using CBOR for CBOR.CBORBuffer;
    using CBORDecoder for bytes;

    function serialize(MarketTypes.WithdrawBalanceParams memory params) internal pure returns (bytes memory) {
        // FIXME what should the max length be on the buffer?
        CBOR.CBORBuffer memory buf = CBOR.create(64);

        buf.startFixedArray(2);
        buf.writeBytes(params.provider_or_client);
        buf.writeUInt256(params.tokenAmount);

        return buf.data();
    }

    function deserialize(MarketTypes.WithdrawBalanceReturn memory ret, bytes memory rawResp) internal pure {
        uint256 amount_withdrawn;
        uint byteIdx = 0;
        uint len;

        (len, byteIdx) = rawResp.readFixedArray(byteIdx);
        assert(len == 1);

        (amount_withdrawn, byteIdx) = rawResp.readUInt256(byteIdx);

        ret.amount_withdrawn = amount_withdrawn;
    }
}

library GetBalanceCBOR {
    using CBORDecoder for bytes;

    function deserialize(MarketTypes.GetBalanceReturn memory ret, bytes memory rawResp) internal pure {
        uint256 balance;
        uint256 locked;
        uint byteIdx = 0;
        uint len;

        (len, byteIdx) = rawResp.readFixedArray(byteIdx);
        assert(len == 2);

        (balance, byteIdx) = rawResp.readUInt256(byteIdx);
        (locked, byteIdx) = rawResp.readUInt256(byteIdx);

        ret.balance = balance;
        ret.locked = locked;
    }
}

library GetDealDataCommitmentCBOR {
    using CBOR for CBOR.CBORBuffer;
    using CBORDecoder for bytes;

    function serialize(MarketTypes.GetDealDataCommitmentParams memory params) internal pure returns (bytes memory) {
        // FIXME what should the max length be on the buffer?
        CBOR.CBORBuffer memory buf = CBOR.create(64);

        buf.startFixedArray(1);
        buf.writeUInt64(params.id);

        return buf.data();
    }

    function deserialize(MarketTypes.GetDealDataCommitmentReturn memory ret, bytes memory rawResp) internal pure {
        bytes memory data;
        uint64 size;
        uint byteIdx = 0;
        uint len;

        (len, byteIdx) = rawResp.readFixedArray(byteIdx);
        assert(len == 2);

        (data, byteIdx) = rawResp.readBytes(byteIdx);
        (size, byteIdx) = rawResp.readUInt64(byteIdx);

        ret.data = data;
        ret.size = size;
    }
}

library GetDealClientCBOR {
    using CBOR for CBOR.CBORBuffer;
    using CBORDecoder for bytes;

    function serialize(MarketTypes.GetDealClientParams memory params) internal pure returns (bytes memory) {
        // FIXME what should the max length be on the buffer?
        CBOR.CBORBuffer memory buf = CBOR.create(64);

        buf.startFixedArray(1);
        buf.writeUInt64(params.id);

        return buf.data();
    }

    function deserialize(MarketTypes.GetDealClientReturn memory ret, bytes memory rawResp) internal pure {
        bytes memory client;
        uint byteIdx = 0;
        uint len;

        (len, byteIdx) = rawResp.readFixedArray(byteIdx);
        assert(len == 2);

        (client, byteIdx) = rawResp.readBytes(byteIdx);

        ret.client = client;
    }
}

library GetDealProviderCBOR {
    using CBOR for CBOR.CBORBuffer;
    using CBORDecoder for bytes;

    function serialize(MarketTypes.GetDealProviderParams memory params) internal pure returns (bytes memory) {
        // FIXME what should the max length be on the buffer?
        CBOR.CBORBuffer memory buf = CBOR.create(64);

        buf.startFixedArray(1);
        buf.writeUInt64(params.id);

        return buf.data();
    }

    function deserialize(MarketTypes.GetDealProviderReturn memory ret, bytes memory rawResp) internal pure {
        bytes memory provider;
        uint byteIdx = 0;
        uint len;

        (len, byteIdx) = rawResp.readFixedArray(byteIdx);
        assert(len == 2);

        (provider, byteIdx) = rawResp.readBytes(byteIdx);

        ret.provider = provider;
    }
}

library GetDealLabelCBOR {
    using CBOR for CBOR.CBORBuffer;
    using CBORDecoder for bytes;

    function serialize(MarketTypes.GetDealLabelParams memory params) internal pure returns (bytes memory) {
        // FIXME what should the max length be on the buffer?
        CBOR.CBORBuffer memory buf = CBOR.create(64);

        buf.startFixedArray(1);
        buf.writeUInt64(params.id);

        return buf.data();
    }

    function deserialize(MarketTypes.GetDealLabelReturn memory ret, bytes memory rawResp) internal pure {
        string memory label;
        uint byteIdx = 0;
        uint len;

        (len, byteIdx) = rawResp.readFixedArray(byteIdx);
        assert(len == 2);

        (label, byteIdx) = rawResp.readString(byteIdx);

        ret.label = label;
    }
}

library GetDealTermCBOR {
    using CBOR for CBOR.CBORBuffer;
    using CBORDecoder for bytes;

    function serialize(MarketTypes.GetDealTermParams memory params) internal pure returns (bytes memory) {
        // FIXME what should the max length be on the buffer?
        CBOR.CBORBuffer memory buf = CBOR.create(64);

        buf.startFixedArray(1);
        buf.writeUInt64(params.id);

        return buf.data();
    }

    function deserialize(MarketTypes.GetDealTermReturn memory ret, bytes memory rawResp) internal pure {
        int64 start;
        int64 end;
        uint byteIdx = 0;
        uint len;

        (len, byteIdx) = rawResp.readFixedArray(byteIdx);
        assert(len == 2);

        (start, byteIdx) = rawResp.readInt64(byteIdx);
        (end, byteIdx) = rawResp.readInt64(byteIdx);

        ret.start = start;
        ret.end = end;
    }
}

library GetDealEpochPriceCBOR {
    using CBOR for CBOR.CBORBuffer;
    using CBORDecoder for bytes;

    function serialize(MarketTypes.GetDealEpochPriceParams memory params) internal pure returns (bytes memory) {
        // FIXME what should the max length be on the buffer?
        CBOR.CBORBuffer memory buf = CBOR.create(64);

        buf.startFixedArray(1);
        buf.writeUInt64(params.id);

        return buf.data();
    }

    function deserialize(MarketTypes.GetDealEpochPriceReturn memory ret, bytes memory rawResp) internal pure {
        uint256 price_per_epoch;
        uint byteIdx = 0;
        uint len;

        (len, byteIdx) = rawResp.readFixedArray(byteIdx);
        assert(len == 2);

        (price_per_epoch, byteIdx) = rawResp.readUInt256(byteIdx);

        ret.price_per_epoch = price_per_epoch;
    }
}

library GetDealClientCollateralCBOR {
    using CBOR for CBOR.CBORBuffer;
    using CBORDecoder for bytes;

    function serialize(MarketTypes.GetDealClientCollateralParams memory params) internal pure returns (bytes memory) {
        // FIXME what should the max length be on the buffer?
        CBOR.CBORBuffer memory buf = CBOR.create(64);

        buf.startFixedArray(1);
        buf.writeUInt64(params.id);

        return buf.data();
    }

    function deserialize(MarketTypes.GetDealClientCollateralReturn memory ret, bytes memory rawResp) internal pure {
        uint256 collateral;
        uint byteIdx = 0;
        uint len;

        (len, byteIdx) = rawResp.readFixedArray(byteIdx);
        assert(len == 2);

        (collateral, byteIdx) = rawResp.readUInt256(byteIdx);

        ret.collateral = collateral;
    }
}
