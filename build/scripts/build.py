#!/usr/bin/env python

import subprocess as sp
import sys
import os

class GodotExport:

    version = ''

    # check if the folder exits
    def check_if_folder_exists(self, destination):
        if (os.path.isdir(destination) and os.path.exists(destination)):
            return True
        else:
            return False
    
    # creates a linux build
    def create_linux_build(self):
        destination = os.path.abspath('../bin/linux')
        project_path = os.path.abspath('../../project folder')
        export_path  = '{path}/World Maker_{version}.x86_64'.format(path = destination, version = self.version)

        try:
            sp.call(['godot', '--no-window', '--path', project_path, '--export-debug', "Linux/X11", export_path])
            sp.call('clear')
            print("The export has been created at {des} 🤩".format(des = destination))
        except:
            print("bruh something went wrong 🤨")
            quit()

    # create windows build
    def create_windows_build(self):
        destination = os.path.abspath('../bin/windows')
        project_path = os.path.abspath('../../project folder')
        export_path  = '{path}/World Maker_{version}.exe'.format(path = destination, version = self.version)

        try:
            sp.call(['godot', '--no-window', '--path', project_path, '--export-debug', "Linux/X11", export_path])
            sp.call('clear')
            print("The export has been created at {des} 🤩".format(des = destination))
        except:
            print("bruh the folder doesn't exist 🤨")
            quit()


# asks the version for the export
def ask_version():
    version_name = input('version you are exporting => ')
    export = GodotExport()
    export.version = version_name

    export.create_linux_build()
    export.create_windows_build()


# creates the the exports
def create_export():
    ask_version()
    print('The export has been created')



if __name__ == "__main__":
    ask_version()