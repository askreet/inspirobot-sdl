import std.stdio;
import std.conv;
import std.container.array;

import derelict.sdl2.sdl;
import derelict.sdl2.image;

import requests;

InspirobotViewer createInspirobotViewer()
{
    SDL_Window* window = SDL_CreateWindow(
        "Inspirobot UI",
        SDL_WINDOWPOS_UNDEFINED,
        SDL_WINDOWPOS_UNDEFINED,
        650,
        650,
        SDL_WINDOW_BORDERLESS | SDL_WINDOW_SKIP_TASKBAR
    );

    if (window is null) {
        writefln("SDL_CreateWindow failure: ", SDL_GetError());
        SDL_Quit();
    }

    auto viewer = new InspirobotViewer(window);

    return viewer;
}

class InspirobotViewer
{
    this(SDL_Window* window) {
        this.window = window;
    }

    ~this() {
        SDL_DestroyWindow(window);
    }

    void loadNewImage()
    {
        auto url = getContent("http://inspirobot.me/api?generate=true");
        ubyte[] imageData = getContent(url.to!string()).data();
        auto rwOps = SDL_RWFromConstMem(imageData.ptr, imageData.length.to!int());
        SDL_Surface* imageSurface = IMG_LoadJPG_RW(rwOps);
        if (imageSurface is null) {
            writeln("IMG_LoadJPG_RW failed: ", IMG_GetError());
            SDL_Quit();
        }

        history.insertBack(imageSurface);
        current = history.length - 1;
    }

    void draw()
    {
        auto surface = SDL_GetWindowSurface(window);

        SDL_Rect area = SDL_Rect(0, 0, 650, 650);
        SDL_BlitSurface(history[current], &area, surface, &area);
        SDL_UpdateWindowSurface(window);
    }

    void next()
    {
        if (current == history.length - 1) {
            loadNewImage();
        } else {
            current++;
        }

        draw();
    }

    void prev()
    {
        if (current > 0) {
            current--;
            draw();
        }
    }

    private:

    SDL_Window* window;
    Array!(SDL_Surface*) history;
    size_t current;
}
