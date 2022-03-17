# Octo Fusion
A component/library for working with the Github API using ColdFusion. 

* [Organization Functions](#organization-functions)
* [Webhook Functions](#webhook-functions)

## Required

| name | value |
| :-- | :-- | 
| `GITHUB_TOKEN` | access token for authentication |
| `GITHUB_WEBHOOK_SECRET` | secret used for validating webhook requests |

## Functions

### Organization Functions

* [getMembers](#getmembers)

#### getMembers

Gets all members of a given organization.

##### arguments

| name   | type  | required |
| :--    | :--   | :--      |
| `none` |       |          |

##### returns

| type     | notes |
| :--      | :--   |
| `string` | returns the `filecontent` string from the result of a `cfhttp` request |

### Webhook Functions

* [pingWebhook](#pingwebhook)
* [verifySignature](#verifysignature)

#### pingWebhook

Sends the `ping` event to a webhook url.

##### arguments

| name     | type     | required |
| :--      | :--      | :--      |
| `hookId` | `string` | true     |

##### returns

| type     | notes |
| :--      | :--   |
| `string` | returns the `filecontent` string from the result of a `cfhttp` request |

#### verifySignature

Validates the signature provided by the webhook request header. **Requires** the `GITHUB_WEBHOOK_SECRET` environment variable. The secret can also be defined
inline, but this is not recommended for security reasons.

##### arguments

| name        | type     | required |
| :--         | :--      | :--      |
| `signature` | `string` | true     |
| `payload`   | `string` | true     |
| `secret`    | `string` | true     |

##### returns

| type      | notes |
| :--       | :--   |
| `boolean` | true or false if signature from request matches the generated signature using the known `secret` value |
