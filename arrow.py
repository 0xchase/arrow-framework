#!/usr/bin/python3

from ast import Module
import os
import sys
from typing import *
from termcolor import colored

import importlib

name = os.getlogin()

plugins = []

def load_plugins():
    directory = "plugins/"
    for filename in os.listdir(directory):
        f = os.path.join(directory, filename)
        if os.path.isfile(f):
            name = filename.replace(".py", "")
            module = import_path("plugins/" + filename)

            try:
                module.initialize
                try:
                    module.run
                    plugins.append(Plugin(module))
                    success("Loaded plugin " + name)
                except:
                    warning("Couldn't load plugin " + filename + ". Failed to find run()")
            except:
                warning("Couldn't load plugin " + filename + ". Failed to find initialize()")

def main():
    load_plugins()

    if len(sys.argv) == 2:
        if sys.argv[1] == "--stdio":
            print("Entering stdio mode")
    else:
        while True:
            print("(arrow) ► ", end="")
            temp = input()

# ===== Ignore Below ===== #

def import_path(path) -> Module:
    module_name = os.path.basename(path).replace('-', '_')
    spec = importlib.util.spec_from_loader(
        module_name,
        importlib.machinery.SourceFileLoader(module_name, path)
    )
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    sys.modules[module_name] = module
    return module

class Plugin:
    def __init__(self, module: Module):
        self.module = module

class TestPlugin:
    def commands() -> str:
        return [
            "scan hosts",
        ]

    def initialize(state):
        print("Found the state here")

    def run(command, callback):
        print("Running a command here")

def success(s):
    print(colored("[+] ", "green") + s)

def warning(s):
    print(colored("[-] ", "yellow") + s)

main()
