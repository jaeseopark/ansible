# This script is WIP

BUTTON_MAP = {}


def button(binding):  # 'binding' is a hashable object (commonly: int or str)
    def outer_wrapper(func):
        def wrapper(*args, **kwargs):
            return func(*args, **kwargs)
        return wrapper
    return outer_wrapper


@button(1)
def toggle_screen():
    # TODO: change state of optoma uhd35
    pass


@button(4)
def toggle_basement_light():
    # TODO
    pass


def get_handle_function(cmd):
    if cmd not in BUTTON_MAP:
        def log_unrecognized_button():
            pass
        return log_unrecognized_button

    return BUTTON_MAP[cmd]


handle = get_handle_function(data.get("cmd"))
handle()
