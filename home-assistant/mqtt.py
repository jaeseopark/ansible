#!/usr/bin/python3

import json
from typing import Callable

# TODO: ensure the remote host has PyYaml installed.
import yaml

entity_registry = {}


def entity_handler(target_attr: str = "sensors"):
    def wrapper(func: Callable):
        def inner_wrapper(*args, **kwargs):
            return func(*args, **kwargs), target_attr

        entity_registry[func.__name__] = inner_wrapper
        return inner_wrapper

    return wrapper


@entity_handler("binary_sensors")
def binary_battery_low(device, entity):
    return dict(
        device_class="battery",
        name="Battery",
        state_topic=device["topic"],
        value_template=f'{{{{ value_json.{entity["key"]} }}}}',
        payload_on=entity["payload_on"],
        payload_off=entity["payload_off"]
    )


@entity_handler("binary_sensors")
def occupancy(device, entity):
    return dict(
        device_class="occupancy",
        name="Occupancy",
        state_topic=device["topic"],
        value_template=f'{{{{ value_json.{entity["key"]} }}}}',
        payload_on=entity["payload_on"],
        payload_off=entity["payload_off"]
    )


@entity_handler()
def battery_voltage(device, entity):
    return dict(
        device_class="voltage",
        name="Battery Voltage",
        state_topic=device["topic"],
        value_template=f'{{{{ value_json.{entity["key"]} }}}}',
        unit_of_measurement=entity["unit"]
    )


@entity_handler()
def battery_percentage(device, entity):
    return dict(
        device_class="battery",
        name="Battery Percentage",
        state_topic=device["topic"],
        value_template=f'{{{{ value_json.{entity["key"]} }}}}'
    )


@entity_handler()
def temperature(device, entity):
    return dict(
        device_class="temperature",
        name="Temperature",
        state_topic=device["topic"],
        value_template=f'{{{{ value_json.{entity["key"]} }}}}',
        unit_of_measurement='°C'
    )


@entity_handler()
def humidity(device, entity):
    return dict(
        device_class="humidity",
        name="Humidity",
        state_topic=device["topic"],
        value_template=f'{{{{ value_json.{entity["key"]} }}}}',
        unit_of_measurement='%'
    )


class Mqtt:
    sensors = []
    binary_sensors = []

    def __init__(self, data: dict) -> None:
        self.data = data

    def get_yaml(self) -> dict:
        self.sensors.clear()
        self.binary_sensors.clear()

        for id, device in self.data["devices"].items():
            if "inherit" in device:
                device = {
                    **self.data["devices"][device["inherit"]],
                    **dict(
                        name=device["name"],
                        topic=device["topic"]
                    )
                }

            assert "-" not in id, "use underscores instead of dashes"
            assert device["protocol"] in self.data["allowed_protocols"]
            try:
                for i, entity in enumerate(device["entities"]):
                    self.process_entity(id, device, entity, is_first_entity=i == 0)
            except Exception as e:
                print(f"{id=} {e}")
                raise

        return dict(
            sensor=self.sensors,
            binary_sensor=self.binary_sensors
        )

    def process_entity(self, id, device, entity, is_first_entity):
        entity_type = entity["type"]
        sensor, target_attr = entity_registry[entity_type](device, entity)

        sensor.update(dict(
            unique_id=f"{id}_{entity_type}",
            device=dict(identifiers=[id])
        ))

        if is_first_entity:
            sensor["device"].update(dict(
                name=device["name"],
                manufacturer=device["manufacturer"],
                model=device["model"]
            ))

        getattr(self, target_attr).append(sensor)


def run(json_path: str = "mqtt.json", yaml_path: str = "mqtt.yaml"):
    with open(json_path) as fp:
        data = json.load(fp)

    mqtt = Mqtt(data)
    with open(yaml_path, "w") as fp:
        yaml.safe_dump(mqtt.get_yaml(), fp)


if __name__ == "__main__":
    run()
