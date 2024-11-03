#!/bin/env python

from os import listdir
from subprocess import run, PIPE
import re

hypr_conf_dir = "/home/patrickpmueller/.config/hypr/conf/"
anims_dir = hypr_conf_dir + "animations/"

def get_attr(line):
    """Extract the animation attr from a line of text."""
    attr_match = re.search(r"\"[ a-zA-Z0-9,.-]*\"", line)
    if attr_match:
        return attr_match.group()[1:-1]
    return "Error while loading description"


def extract_animations(files):
    """Extract animation names and their paths from the given files."""
    animations = {}
    for filename in files:
        path = anims_dir + filename 
        with open(path, "r") as file:
            name = ""
            desc = "No description"
            for line in file:
                if re.match(r"# name \"[a-zA-Z-]*\"", line):
                    name = get_attr(line)
                elif re.match(r"# desc \"[ a-zA-Z0-9,.-]*\"", line):
                    desc = get_attr(line)
                    print(f"desc {desc}")
            animations[name] = {"desc": desc, "path": path}
    return animations

def run_rofi(animation_names):
    """Run Rofi and capture the selected animation name."""
    result = run(
        ["rofi", "-dmenu", "-i", "-markup", "-eh", "2", "-replace", "-p", "Animation", "-config", "~/.config/rofi/config-compact.rasi"],
        input=animation_names.encode(),
        stdout=PIPE,
        stderr=PIPE
    )
    return result.stdout.decode().strip()

def main():
    """Main function to orchestrate the script."""
    # Get a list of animation files in the specified directory
    files = listdir(anims_dir)
    animations = extract_animations(files)

    # Create a string of animation names to pass to Rofi
    animation_names = "\n".join([ f"{key} \r {val["desc"]}" for key, val in animations.items()])
    print(animations)
    print(animation_names)

    # Run Rofi and capture the selected element
    selected_animation = run_rofi(animation_names).split("\r")[0].strip()

    # Check if a selection was made
    if selected_animation:
        print(f"Selected animation: {selected_animation}")
        anim_path = animations[selected_animation]["path"]
        with open(hypr_conf_dir + "animation.conf", "w") as animations_config:
            animations_config.write(f"source = {anim_path}")
    else:
        print("No selection made.")

if __name__ == "__main__":
    main()

