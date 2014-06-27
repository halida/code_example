import derelict.sdl.sdl;
pragma(lib, "/Users/halida/data/workspace/sources/Derelict2/lib/libDerelictSDL.a");
pragma(lib, "/Users/halida/data/workspace/sources/Derelict2/lib/libDerelictUtil.a");

int main()
{
    bool run = true;
    DerelictSDL.load();

    SDL_Init(SDL_INIT_VIDEO);
    SDL_SetVideoMode(400, 300, 32, SDL_HWSURFACE | SDL_RESIZABLE | SDL_DOUBLEBUF);
    // SDL_Event event;
    // while(run)
    //     {
    //         SDL_WaitEvent(&event);
    //         switch(event.type)
    //             {
    //             case SDL_QUIT:
    //                 run = false;
    //             default:
    //                 ;
    //             } 
    //     }
    return 0;
}
