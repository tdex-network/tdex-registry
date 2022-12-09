# tdex-registry
Public list of tdex liquidity providers

Any always-on endpoint that implements the [BOTD#4 Trade Protocol](https://github.com/TDex-network/tdex-specs/blob/master/04-trade-protocol.md#trade) HTTP2 interface could be registered in this list. Being in this list is not required to be "discovered" by the `tdex-app`, `tdex-cli` or other `tdex-sdk`-based clients, anyone could connect to you directly. This aims to be a public list that helps advanced traders to discover liquidity providers that guarantee highly available and professional service.


## Add a provider

1. [Test with tdex clients](#1-test)
2. [Submit your provider via Pull Request](#2-submit)
3. [Be sure to stay online](#3-availability)


### 1. Test

Before submitting yout endpoint, be sure to test with any tdex clients, such as [TDex Mobile App](https://github.com/TDex-network/tdex-app) or [TDex CLI](https://github.com/vulpemventures/tdex-cli).

* With the app goes to `Settings` > `Manage Liquidity Provider` > `Connect`
* With the cli use `tdex-cli connect <your_endpoint>`
* With the command-line use the following curl command(s):

**Replace endpoint with your actual public reachable endpoint, comprhensive of http or https.**

```sh
curl -w "%{http_code}" -o /dev/null -s -X POST <endpoint>/v1/markets \
  --header 'Content-Type: application/json' \
  --data-raw '{}'
```

**For Tor hidden services, run a Tor Browser and add the `--socks5-hostname` flag to the command:**

```sh
curl -w "%{http_code}" -o /dev/null -s -X POST <endpoint>/v1/markets \
  --header 'Content-Type: application/json' \
  --data-raw '{}' \
  --socks5-hostname localhost:9150
```

### 2. Submit

To add your provider to the list, first fork the repository and [open a pull request](https://github.com/TDex-network/tdex-registry/pulls) adding your provider in the `registry.json` file at the end of the array.

```json
[
  {
    "name": "My Awesome Exchange",
    "endpoint": "https://my.provider.com:9945"
  }
]
```

### 3. Availability

We automatically check your provider: we call the `Markets` service endpoint looking for succesful reply and a **non-empty array** of markets. 


# JSON SCHEMA

The `tdex-registry` is a simple public reachable file that follows the [JSON SCHEMA](https://json-schema.org) specification. Anyone is welcome to create a custom registry and source to tdex clients directly.
