#!/usr/bin/env bash
set -e

# Import raw keys
curl 'http://localhost:8648' -H 'Content-Type: application/json' \
    --data-raw '{"method": "importRawKey", "params": ["6997d0cd1061c6ffb29cfcb511204f4a25eedddb085f700699e7025966e5abb1", null], "jsonrpc": "2.0", "id": 1}'

curl 'http://localhost:8649' -H 'Content-Type: application/json' \
    --data-raw '{"method": "importRawKey", "params": ["6576c897cbad8d1783cd2852f3ed35054be48bb854930459679b9ef8933e4e74", null], "jsonrpc": "2.0", "id": 1}'

curl 'http://localhost:8650' -H 'Content-Type: application/json' \
    --data-raw '{"method": "importRawKey", "params": ["822fb64650d4093220751fa9a44173ec38607ff411b78dc7e54056273f2852d0", null], "jsonrpc": "2.0", "id": 1}'

curl 'http://localhost:8651' -H 'Content-Type: application/json' \
    --data-raw '{"method": "importRawKey", "params": ["9199d509b139cc849b54bc671b6e3eaa4641994352e18a3e1fa34aa3482c8215", null], "jsonrpc": "2.0", "id": 1}'

# Unlock accounts
curl 'http://localhost:8648' -H 'Content-Type: application/json' \
    --data-raw '{"method": "unlockAccount", "params": ["NQ64 9F95 QT38 4JXR G5XK 52XJ A9XJ M8LD GUEK", null, null], "jsonrpc": "2.0", "id": 1}'

curl 'http://localhost:8649' -H 'Content-Type: application/json' \
    --data-raw '{"method": "unlockAccount", "params": ["NQ50 M8T2 8U7N 2BNQ CSLD 2251 X9EF 5GVD EY9G", null, null], "jsonrpc": "2.0", "id": 1}'

curl 'http://localhost:8650' -H 'Content-Type: application/json' \
    --data-raw '{"method": "unlockAccount", "params": ["NQ43 8U7V C3UE VRGS 8HE7 C43P DEJ3 V0XJ 6NPN", null, null], "jsonrpc": "2.0", "id": 1}'

curl 'http://localhost:8651' -H 'Content-Type: application/json' \
    --data-raw '{"method": "unlockAccount", "params": ["NQ28 RABB NVRL TMD0 KST7 QFJ6 QTNP 72QJ 74J2", null, null], "jsonrpc": "2.0", "id": 1}'

# Send new validator transactions
curl 'http://localhost:8648' -H 'Content-Type: application/json' \
    --data-raw '{"method": "sendNewValidatorTransaction", "params": ["NQ64 9F95 QT38 4JXR G5XK 52XJ A9XJ M8LD GUEK", "NQ64 9F95 QT38 4JXR G5XK 52XJ A9XJ M8LD GUEK", "f32b75bfe2bf091ceb15b08742abb75d0256c5176318fdd5219742b67ba91dfe", "ea7306d61cbb5cea20ccbb3b777fd9f1c21124b856594b5f30d02e3fc1b5dce4fd61ffd39904abfb1738ac9d325179cca65525e0285131ccd52eb55b6552a3986ffbcc97b111c852832813ab7ade1044c72c5387c2f7bd576534e9b1e70200", "NQ64 9F95 QT38 4JXR G5XK 52XJ A9XJ M8LD GUEK", "", 0, "+0"], "jsonrpc": "2.0", "id": 1}'

curl 'http://localhost:8649' -H 'Content-Type: application/json' \
    --data-raw '{"method": "sendNewValidatorTransaction", "params": ["NQ50 M8T2 8U7N 2BNQ CSLD 2251 X9EF 5GVD EY9G", "NQ50 M8T2 8U7N 2BNQ CSLD 2251 X9EF 5GVD EY9G", "df6ac780905ea7fef5337d0a61f55dacf2f26d8d90269db41949117562de31fd", "678f533ab3ded484dfd0bbc80ce8d90033cff4498a010f01854fee958b35ce954bb492b81d80e9be181029c249f370ca79b4acd61afb32310aecf15a689324ecba9f42c4293d8a56e4d481a082285a80641f143ce9cc42b633dfc312e06200", "NQ50 M8T2 8U7N 2BNQ CSLD 2251 X9EF 5GVD EY9G", "", 0, "+0"], "jsonrpc": "2.0", "id": 1}'

curl 'http://localhost:8650' -H 'Content-Type: application/json' \
    --data-raw '{"method": "sendNewValidatorTransaction", "params": ["NQ43 8U7V C3UE VRGS 8HE7 C43P DEJ3 V0XJ 6NPN", "NQ43 8U7V C3UE VRGS 8HE7 C43P DEJ3 V0XJ 6NPN", "b0e7a4ddb0d40912348723eacb26f98755a2be3054d78ee295a46382c44a8032", "bccb4ebea1cf72400afed052f9b7ba318f3fff33e6651a9aa9385e8eee80b596ebf23f132524b21f69d694aa092484a703dde646bf8e547df4e2dae20198ad6d461557502227b7f82ef1baae6d4bc0d05fc676edb9b505a5183b1c2de7bc00", "NQ43 8U7V C3UE VRGS 8HE7 C43P DEJ3 V0XJ 6NPN", "", 0, "+0"], "jsonrpc": "2.0", "id": 1}'

curl 'http://localhost:8651' -H 'Content-Type: application/json' \
    --data-raw '{"method": "sendNewValidatorTransaction", "params": ["NQ28 RABB NVRL TMD0 KST7 QFJ6 QTNP 72QJ 74J2", "NQ28 RABB NVRL TMD0 KST7 QFJ6 QTNP 72QJ 74J2", "b4a92daa43d68aad83f51b41a412f4204702954ad1477a4e6a8578f9aa88c55b", "0ac9ef793c25d400b4aa88eaa79b057a8bb9a110013d061d96dd7cc185918d55312e6b1f5477e94ca065a22e17efd325e6ba082736a25f1c9daca4cd7ccd27709189c8cd39feb723774911809ada8ec4c40db111501602d3459f95860cf800", "NQ28 RABB NVRL TMD0 KST7 QFJ6 QTNP 72QJ 74J2", "", 0, "+0"], "jsonrpc": "2.0", "id": 1}'
