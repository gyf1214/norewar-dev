Norewar Development Tool
==========================
The development tool for [Norewar](https://github.com/gyf1214/norewar-rails).

Installation
-------------
Use Bundler to install the required gems.

	bundle install

Common Usage
------
The main CLI program is a small Norewar interpreter for development & debugging, enter the main directory & use the following command to start it.

	./run something.json

Configuration
--------------
Json is used for configuration. Details see etc/demo/test.json

Commands
--------
After entering the program(if there's nothing wrong), a match will be created & paused according to the json config, a '>' prompt will appear for you to enter commands.

Here's some useful commands:

	print
Print the current map of the match.

	next [times]
Run the next frame of the match, an optional integer argument can be used to run multiply frames.

	code x y [line]
Print the current memory code of the robot at (x, y). If the line number is not given, it will be set to the next command of the robot as default. The previous & next 10 commands will also be printed.

	quit
Leave the program.

Demonstration
--------------
The tool also provide some demonstration of Norewar script in etc/demo/.

Notice
-------
If you have any problem, please open an issue in [Norewar](https://github.com/gyf1214/norewar-rails).
