#ifndef EVENTMANAGER_H_INCLUDED
#define EVENTMANAGER_H_INCLUDED
#include <SDL.h>

class EventManager{

    private:
        static EventManager* instance;
        EventManager();

    public:
        static EventManager* getInstance();
        ~EventManager();
        SDL_Point getEvent(SDL_Event*);

};



#endif // EVENTMANAGER_H_INCLUDED
