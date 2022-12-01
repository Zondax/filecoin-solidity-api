// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.4.25 <=0.8.17;

import "solidity-cborutils/contracts/CBOR.sol";

import {MarketTypes} from "../types/MarketTypes.sol";
import "../utils/CborDecode.sol";
import "../utils/Misc.sol";

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
        buf.writeBytes(Misc.toBytes(params.tokenAmount));

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

library AddressCBOR {
    using CBOR for CBOR.CBORBuffer;
    using CBORDecoder for bytes;

    function serializeAddress(bytes memory addr) internal pure returns (bytes memory) {
        // FIXME what should the max length be on the buffer?
        CBOR.CBORBuffer memory buf = CBOR.create(64);

        buf.writeBytes(addr);

        return buf.data();
    }

    function deserializeAddress(bytes memory ret) internal pure returns (bytes memory) {
        bytes memory addr;
        uint byteIdx = 0;
        uint len;

        (addr, byteIdx) = ret.readBytes(byteIdx);

        return addr;
    }
}

library GetBalanceCBOR {
    using CBORDecoder for bytes;

    function deserialize(MarketTypes.GetBalanceReturn memory ret, bytes memory rawResp) internal pure {
        uint byteIdx = 0;
        uint len;
        bytes memory tmp;

        (len, byteIdx) = rawResp.readFixedArray(byteIdx);
        assert(len == 2);

        (tmp, byteIdx) = rawResp.readBytes(byteIdx);
        ret.balance = Misc.toInt256(tmp, 0);

        (tmp, byteIdx) = rawResp.readBytes(byteIdx);
        ret.locked = Misc.toInt256(tmp, 0);
    }
}

library GetDealDataCommitmentCBOR {
    using CBOR for CBOR.CBORBuffer;
    using CBORDecoder for bytes;

    function serialize(MarketTypes.GetDealDataCommitmentParams memory params) internal pure returns (bytes memory) {
        // FIXME what should the max length be on the buffer?
        CBOR.CBORBuffer memory buf = CBOR.create(64);

        buf.writeUInt64(params.id);

        return buf.data();
    }

    function deserialize(MarketTypes.GetDealDataCommitmentReturn memory ret, bytes memory rawResp) internal pure {
        uint byteIdx = 0;
        uint len;

        (len, byteIdx) = rawResp.readFixedArray(byteIdx);

        if (len > 0) {
            (ret.data, byteIdx) = rawResp.readBytes(byteIdx);
            (ret.size, byteIdx) = rawResp.readUInt64(byteIdx);
        }
    }
}

library GetDealClientCBOR {
    using CBOR for CBOR.CBORBuffer;
    using CBORDecoder for bytes;

    function serialize(MarketTypes.GetDealClientParams memory params) internal pure returns (bytes memory) {
        // FIXME what should the max length be on the buffer?
        CBOR.CBORBuffer memory buf = CBOR.create(64);

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

library GetDealProviderCollateralCBOR {
    using CBOR for CBOR.CBORBuffer;
    using CBORDecoder for bytes;

    function serialize(MarketTypes.GetDealProviderCollateralParams memory params) internal pure returns (bytes memory) {
        // FIXME what should the max length be on the buffer?
        CBOR.CBORBuffer memory buf = CBOR.create(64);

        buf.writeUInt64(params.id);

        return buf.data();
    }

    function deserialize(MarketTypes.GetDealProviderCollateralReturn memory ret, bytes memory rawResp) internal pure {
        uint256 collateral;
        uint byteIdx = 0;
        uint len;

        (len, byteIdx) = rawResp.readFixedArray(byteIdx);
        assert(len == 2);

        (collateral, byteIdx) = rawResp.readUInt256(byteIdx);

        ret.collateral = collateral;
    }
}

library GetDealVerifiedCBOR {
    using CBOR for CBOR.CBORBuffer;
    using CBORDecoder for bytes;

    function serialize(MarketTypes.GetDealVerifiedParams memory params) internal pure returns (bytes memory) {
        // FIXME what should the max length be on the buffer?
        CBOR.CBORBuffer memory buf = CBOR.create(64);

        buf.writeUInt64(params.id);

        return buf.data();
    }

    function deserialize(MarketTypes.GetDealVerifiedReturn memory ret, bytes memory rawResp) internal pure {
        bool verified;
        uint byteIdx = 0;
        uint len;

        (len, byteIdx) = rawResp.readFixedArray(byteIdx);
        assert(len == 2);

        (verified, byteIdx) = rawResp.readBool(byteIdx);

        ret.verified = verified;
    }
}

library GetDealActivationCBOR {
    using CBOR for CBOR.CBORBuffer;
    using CBORDecoder for bytes;

    function serialize(MarketTypes.GetDealActivationParams memory params) internal pure returns (bytes memory) {
        // FIXME what should the max length be on the buffer?
        CBOR.CBORBuffer memory buf = CBOR.create(64);

        buf.writeUInt64(params.id);

        return buf.data();
    }

    function deserialize(MarketTypes.GetDealActivationReturn memory ret, bytes memory rawResp) internal pure {
        int64 activated;
        int64 terminated;
        uint byteIdx = 0;
        uint len;

        (len, byteIdx) = rawResp.readFixedArray(byteIdx);
        assert(len == 2);

        (activated, byteIdx) = rawResp.readInt64(byteIdx);
        (terminated, byteIdx) = rawResp.readInt64(byteIdx);

        ret.activated = activated;
        ret.terminated = terminated;
    }
}

library PublishStorageDealsCBOR {
    using CBOR for CBOR.CBORBuffer;
    using CBORDecoder for bytes;

    function serialize(MarketTypes.PublishStorageDealsParams memory params) internal pure returns (bytes memory) {
        // FIXME what should the max length be on the buffer?
        CBOR.CBORBuffer memory buf = CBOR.create(64);

        buf.startFixedArray(1);
        buf.startFixedArray(uint64(params.deals.length));

        for (uint64 i = 0; i < params.deals.length; i++) {
            buf.startFixedArray(11);

            buf.writeBytes(params.deals[i].proposal.piece_cid);
            buf.writeUInt64(params.deals[i].proposal.piece_size);
            buf.writeBool(params.deals[i].proposal.verified_deal);
            buf.writeBytes(params.deals[i].proposal.client);
            buf.writeBytes(params.deals[i].proposal.provider);
            buf.writeString(params.deals[i].proposal.label);
            buf.writeInt64(params.deals[i].proposal.start_epoch);
            buf.writeInt64(params.deals[i].proposal.end_epoch);
            buf.writeBytes(Misc.toBytes(uint256(params.deals[i].proposal.storage_price_per_epoch)));
            buf.writeBytes(Misc.toBytes(uint256(params.deals[i].proposal.provider_collateral)));
            buf.writeBytes(Misc.toBytes(uint256(params.deals[i].proposal.client_collateral)));

            buf.writeBytes(params.deals[i].client_signature);
        }

        return buf.data();
    }

    function deserialize(MarketTypes.PublishStorageDealsReturn memory ret, bytes memory rawResp) internal pure {
        uint byteIdx = 0;
        uint len;

        (len, byteIdx) = rawResp.readFixedArray(byteIdx);
        ret.ids = new uint64[](len);

        for (uint i = 0; i < len; i++) {
            (ret.ids[i], byteIdx) = rawResp.readUInt64(byteIdx);
        }

        (ret.valid_deals, byteIdx) = rawResp.readBytes(byteIdx);
    }
}
