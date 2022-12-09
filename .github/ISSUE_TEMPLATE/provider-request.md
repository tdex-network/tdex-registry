---
name: Provider Request
about: Request a provider addition to the registry
title: 'Add {NAME}'
labels: provider request
assignees: ''
---

**Please read the following instructions carefully.**

Test your provider is reachable making the following HTTP request and make sure the response code is `200`.

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

**Please read and accept the following statements carefully.**

- [ ] I understand that provider listing is not required to accept trades on the tdex network.
- [ ] I understand that filing an issue or adding liquidity does not guarantee addition to the tdex public registry.
- [ ] I will not ping the Telegram group or contact any developer about this listing request.
- [ ] I have tested the `/v1/markets` endpoint and can confirm that it is returning valid data.




**Please provide the following information for your provider.**

#### Name (max 40 characters)
My Awesome Provider

#### Endpoint (valid uri with protocol://hostname:port)
provider.tdex.network:9945
