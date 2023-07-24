from mcclient import SLPClient
from mcstatus.protocol.connection import Connection
from typing import Any
from io import StringIO


VERSION_FLAG_IGNORESERVERONLY = 0b1
IGNORESERVERONLY = "optional"


class ExtraConnection(Connection):
    __slots__ = ()

    def write_bool(self, value: bool) -> None:
        self.write(self._pack("?", value))

    def read_bool(self) -> bool:
        return self._unpack("?", self.read(1)) == 1


def decode_optimized(string: str) -> ExtraConnection:
    text = StringIO(string)

    def read() -> int:
        result = text.read(1)

        if not result:
            return 0

        return ord(result)

    size = read() | (read() << 15)

    buffer = ExtraConnection()
    value = 0
    bits = 0

    for _ in range(len(string) - 2):
        while bits >= 8:
            buffer.receive(
                (value & 0xFF).to_bytes(
                    length=1, byteorder="big", signed=False
                )
            )

            value >>= 8
            bits -= 8

        value |= (read() & 0x7FFF) << bits
        bits += 15

    while buffer.remaining() < size:
        buffer.receive(
            (value & 0xFF).to_bytes(length=1, byteorder="big", signed=False)
        )

        value >>= 8
        bits -= 8

    return buffer


def process_response(response: dict) -> dict[str, Any]:
    data: dict[str, Any] = response

    if "forgeData" not in response:
        return data

    forge = response["forgeData"]

    if "d" not in forge:
        return data

    buffer = decode_optimized(forge["d"])

    channels: dict[tuple[str, str], tuple[str, bool]] = {}
    mods: dict[str, str] = {}

    try:
        truncated = buffer.read_bool()
        mod_size = buffer.read_ushort()

        for _ in range(mod_size):
            channel_version_flags = buffer.read_varint()

            channel_size = channel_version_flags >> 1
            is_server = (
                channel_version_flags & VERSION_FLAG_IGNORESERVERONLY != 0
            )
            mod_id = buffer.read_utf()

            mod_version = IGNORESERVERONLY

            if not is_server:
                mod_version = buffer.read_utf()

            for _ in range(channel_size):
                name = buffer.read_utf()
                version = buffer.read_utf()
                client_required = buffer.read_bool()
                channels[(mod_id, name)] = (version, client_required)

            mods[mod_id] = mod_version

        non_mod_channel_size = buffer.read_varint()

        for _ in range(non_mod_channel_size):
            mod_name, mod_id = buffer.read_utf().split(":", 1)
            channel_key: tuple[str, str] = mod_name, mod_id
            version = buffer.read_utf()
            client_required = buffer.read_bool()
            channels[channel_key] = (version, client_required)
    except Exception as ex:
        if not truncated:
            print(
                f"Encountered {ex!r} decoding forge response, "
                "silently ignoring"
            )

    new_forge = {}

    for k, v in forge.items():
        if k == "d":
            continue

        new_forge[k] = v

    new_forge["truncated"] = truncated
    new_forge["mods"] = mods
    new_forge["channels"] = channels
    data["forgeData"] = new_forge

    return data

if __name__ == "__main__":
    client = SLPClient("vanilla.fairyfromalfeya.com")

    res = process_response(client.get_status().res)

    for key in res:
        if key != "forgeData":
            print(f"{key:>35}: {str(res[key]):<50}")

    for key in res["forgeData"]:
        if type(res["forgeData"][key]) != dict:
            print(f"{'forgeData.' + key:>35}: {res['forgeData'][key]:<50}")

    print("\nFORGE DATA | CHANNELS:\n")

    channels = res["forgeData"]["channels"]

    for key in channels:
        print(f"{str(key):>35}: {str(channels[key]):<20}")

    print("\nFORGE DATA | MODS:\n")

    mods = res["forgeData"]["mods"]

    for key in mods:
        print(f"{str(key):>35}: {mods[key]:<20}")
