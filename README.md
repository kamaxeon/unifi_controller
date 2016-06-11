# unifi_controller

Configure [Unifi Controller](https://www.ubnt.com/enterprise/software/) for Linux.

At this moment, only DIY package is supported.

## Supported Version

* 4.8.15
* 4.8.18

## Supported Platforms

[//]: <>(* CentOs 6 (SELinux must be disabled)
* CentOS 7 (SELinux must be disabled)

## Attributes

TODO

## Recipes

## Usage

TODO

## Limitations
* Support debian derivates 
* Include SELinux Rules for REHL and derivates

[//]: <> (<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['iz-postfix']['data_bag']['name']</tt></td>
    <td>Symbol</td>
    <td>Name of the data bag where are the domains</td>
    <td><tt>:domains</tt></td>
  </tr>
  <tr>
    <td><tt>['iz-postfix']['data_bag']['search']</tt></td>
    <td>String</td>
    <td>Search conditions</td>
    <td><tt>mail:true</tt></td>
  </tr>
  <tr>
    <td><tt>['iz-postfix']['main']['relay_recipient']</tt></td>
    <td>String</td>
    <td>File location of relay_recipient</td>
    <td><tt>/etc/postfix/relay_recipients</tt></td>
  </tr>
  <tr>
    <td><tt>['iz-postfix']['main']['transport']</tt></td>
    <td>Symbol</td>
    <td>File location of transport</td>
    <td><tt>/etc/postfix/transport</tt></td>
  </tr>
</table>

## Usage

### iz-postfix::default

Include `iz-postfix::default` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[iz-postfix::default]"
  ]
}
```
### iz-postfix::backup

Include `iz-postfix::backup` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[iz-postfix::backup]"
  ]
	override_attributes(
  "iz-postfix" => {
    "data_bag" => {
      "name" => :domains,
      "search" => "mail:true"
    },
		"main" => {
			"relay_recipient" => "/etc/postfix/relay_recipients",
			"transport" => "/etc/postfix/transport"
      }
  }
}
```

### Data bag item example

* Domain with backup
```json
{
  "id": "foo.com",
  "mail": true,
  "main-mx": "127.0.0.2",
  "port": "590"
}
```
* Domain without backup
```json
{
  "id": "foobar.com",
  "mail": false
}
```

```json
{
  "id": "barfoo.com"
}
```
)
## License and Authors

Author:: Israel Santana (isantana@inerza.com)
