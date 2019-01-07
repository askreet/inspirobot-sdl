# Inspirobot-SDL

## What is this?

Inspirobot-SDL uses the SDL library to display rendered images generated by
[Inspirobot]'s API on a native, cross-platform application.

[Inspirobot]: https://inspirobot.me/

## ... why?

A friend sent me a link to Inspirobot, and I needed an excuse to do a 'real'
project in [D]. I've also been meaning to learn the SDL API for some time, though I
only make minor use of the window management APIs, and the SDL_Image
package.

[D]: https://dlang.org/

## How do I use it?

The project should compile natively on any platform that supports SDL by installing
a [D Compiler] and the [DUB] package manager. With those correctly configured,
just run:

    dub run

[D Compiler]: https://dlang.org/download.html#dmd
[DUB]: https://dub.pm/

I have only tested it on a Fedora Linux 29, however.

This project is released under the MIT license. Enjoy.
