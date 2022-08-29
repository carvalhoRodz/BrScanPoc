#!/bin/sh

for project in $(find Modules -name "project.yml"); do
    xcodegen -q -s $project
done

xcodegen -q -s PocDoc/project.yml

pod install