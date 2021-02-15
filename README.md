# tdex-registry
Curated list of tdex liquidity providers

Any always-on endpoint that implements the [BOTD#4 Trade Protocol](https://github.com/TDex-network/tdex-specs/blob/master/04-trade-protocol.md#trade) HTTP2 interface could be registered in this list. Being in this list is not required to be "discovered" by the `tdex-app`, `tdex-cli` or other `tdex-sdk`-based clients, anyone could connect to you directly. This aims to be a curated list that helps advanced traders to discover liquidity providers that guarantee highly available and professional service.


## Add a provider

1. [Test with tdex clients](#1-test)
2. [Submit your provider via Pull Request](#2-submit)
3. [Be sure to stay online](#3-availability)


### 1. Test

Before submitting yout endpoint, be sure to test with any tdex clients, such as [TDex Mobile App](https://github.com/TDex-network/tdex-app) or [TDex CLI](https://github.com/vulpemventures/tdex-cli).

* With the app goes to `Settings` > `Manage Liquidity Provider` > `Connect`
* With the cli use `tdex-cli connect <your_endpoint>`

### 2. Submit

To add your provider to the list, [open an issue](https://github.com/TDex-network/tdex-registry/issues/new?assignees=&labels=provider+request&template=provider-request.md)

### 3. Availability

We automatically check your provider every 12 hours: we call the `Markets` service endpoint looking for succesful reply and a **non-empty array** of markets. 


# JSON SCHEMA

The `tdex-registry` is a simple public reachable file that follows the [JSON SCHEMA](https://json-schema.org) specification. Anyone is welcome to create his own registry and source to tdex clients directly.
