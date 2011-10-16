#!/usr/bin/env python
#	-*- Mode: python -*-

#
# ($Id: package.py,v 1.1 2001/08/04 14:05:16 tc Exp $)
#


import os
import sys
import string
import posixpath

def user():
    user = "tc" # default
    if os.environ.has_key( "USER" ):
        user = os.environ[ "USER" ]

    return user


def home():
    userName = user()
    home = posixpath.join( "/home", userName )
    if os.environ.has_key('HOME'):
        home = os.environ['HOME']

    return home

def top():
    homeDir = home()
    top = posixpath.join( homeDir, "SamSix" )

    if os.environ.has_key( "TOP" ):
        top = os.environ[ "TOP" ]
    else:
        try:
            cmd = """
            pwd | sed -e 's^%s/.*^^' \
                            -e 's^/%s$^^' \
                            -e 's^/tmp_mnt^^' \
                            -e 's^/$^^' 
                            """ % (ii, ii)
            # print cmd
            cmd = string.replace( cmd, "\n", "" )
            pwd = os.getcwd()
            topdex = string.index( pwd, ii )
            top = pwd[:topdex - 1]
        except:
            pass

    return top


def package():
    pwd = os.getcwd()
    packageTops = ["com", "java", "javax", "mseries" ]
    package = ""

    for ii in packageTops:

        packageDir = ii + "/"
        packageHead = ii + "."
        # print "dir %s  head %s" % (packageDir, packageHead )

        try:
            # find out the package name
            package = string.split( pwd, packageDir )[1]
            package = packageHead + string.replace( package, "/", "." )

            break

        except:
            i = 1

    return package

if __name__ == '__main__':
    sys.stderr = sys.stdout
    package()
