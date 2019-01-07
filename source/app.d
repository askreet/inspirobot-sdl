import std.stdio;
import std.conv;

import derelict.sdl2.image;
import derelict.sdl2.sdl;

import requests;

import viewer;

void main()
{
    initializeLibraries();
    auto viewer = createInspirobotViewer();

    viewer.loadNewImage();
    viewer.draw();

    SDL_Event event;
    bool done = false;

    while ((!done) && SDL_WaitEvent(&event)) {
        switch (event.type) {
            case SDL_KEYDOWN:
                handleKeyDownEvent(event, viewer);
                break;

            case SDL_QUIT:
                done = true;
                break;

            default:
                break;
        }
    }

    SDL_Quit();
}

void initializeLibraries()
{
    DerelictSDL2.load();
    DerelictSDL2Image.load();

    if (SDL_Init(SDL_INIT_VIDEO) != 0) {
        writeln("SDL_Init: ", SDL_GetError());
        return;
    }

    int initFlags = IMG_INIT_JPG;
    if ((IMG_Init(initFlags) & initFlags) != initFlags) {
        writefln("IMG_Init failed: ", IMG_GetError());
        return;
    }
}

void handleKeyDownEvent(ref SDL_Event event, ref InspirobotViewer viewer)
{
    switch (event.key.keysym.sym) {
        case SDLK_q:
            SDL_Quit();
            break;

        case SDLK_n:
            viewer.next();
            break;

        case SDLK_p:
            viewer.prev();
            break;

        default:
            break;
    }
}



