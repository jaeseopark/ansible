## Proxy

The managed installation of Home Assistant on the Raspberry Pi does not allow Ansible to interact with its underlying OS. This breaks the existing Ansible playbooks for WireGuard and the Nginx reverse proxy. As a workaround, I am adding an additional Nginx proxy layer, which isn't ideal but is still better than other installation methods.



## Zigbee2Mqtt

### Tuyma ZMS-102

```json
{
    "data": {
        "definition": {
            "description": "Motion sensor",
            "exposes": [
                {
                    "access": 1,
                    "description": "Indicates whether the device detected occupancy",
                    "label": "Occupancy",
                    "name": "occupancy",
                    "property": "occupancy",
                    "type": "binary",
                    "value_off": false,
                    "value_on": true
                },
                {
                    "access": 1,
                    "category": "diagnostic",
                    "description": "Indicates if the battery of this device is almost empty",
                    "label": "Battery low",
                    "name": "battery_low",
                    "property": "battery_low",
                    "type": "binary",
                    "value_off": false,
                    "value_on": true
                },
                {
                    "access": 1,
                    "category": "diagnostic",
                    "description": "Remaining battery in %, can take up to 24 hours before reported",
                    "label": "Battery",
                    "name": "battery",
                    "property": "battery",
                    "type": "numeric",
                    "unit": "%",
                    "value_max": 100,
                    "value_min": 0
                },
                {
                    "access": 1,
                    "category": "diagnostic",
                    "description": "Voltage of the battery in millivolts",
                    "label": "Voltage",
                    "name": "voltage",
                    "property": "voltage",
                    "type": "numeric",
                    "unit": "mV"
                },
                {
                    "access": 7,
                    "description": "PIR sensor sensitivity",
                    "label": "Sensitivity",
                    "name": "sensitivity",
                    "property": "sensitivity",
                    "type": "enum",
                    "values": [
                        "low",
                        "medium",
                        "high"
                    ]
                },
                {
                    "access": 7,
                    "description": "PIR keep time in seconds",
                    "label": "Keep time",
                    "name": "keep_time",
                    "property": "keep_time",
                    "type": "enum",
                    "values": [
                        30,
                        60,
                        120
                    ]
                },
                {
                    "access": 1,
                    "category": "diagnostic",
                    "description": "Link quality (signal strength)",
                    "label": "Linkquality",
                    "name": "linkquality",
                    "property": "linkquality",
                    "type": "numeric",
                    "unit": "lqi",
                    "value_max": 255,
                    "value_min": 0
                }
            ],
            "model": "ZMS-102",
            "options": [],
            "supports_ota": false,
            "vendor": "Tuya"
        },
        "friendly_name": "0xa4c1389c1f0c9894",
        "ieee_address": "0xa4c1389c1f0c9894",
        "status": "successful",
        "supported": true
    },
    "type": "device_interview"
}
```

