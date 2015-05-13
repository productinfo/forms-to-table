shinobiforms form to table (Objective-C)
=====================

A simple demo of using **shinobiforms** to input data into a table.

![Screenshot](screenshot.png?raw=true)

Building the project
------------------

In order to build this project you'll need a copy of **shinobiforms**. If you don't have it yet, you can download a free trial from the [**shinobicontrols** website](https://www.shinobicontrols.com/).

If you've used the installer to install **shinobiforms**, the project should just work. If you haven't, then once you've downloaded and unzipped **shinobiforms**, open up the project in Xcode, and drag **shinobiforms.framework from the finder into Xcode's 'frameworks' group, and Xcode will sort out all the header and linker paths for you.

If you're using the trial version you'll need to add your license key. To do so, open up **ViewController.m** and add the following line to the top of `viewDidLoad:`:

    [ShinobiForms setLicenseKey:@"<your-license-key>"];

Contributing
------------

We'd love to see your contributions to this project - please go ahead and fork it and send us a pull request when you're done! Or if you have a new project you think we should include here, email info@shinobicontrols.com to tell us about it.

License
-------

The [Apache License, Version 2.0](license.txt) applies to everything in this repository, and will apply to any user contributions.

