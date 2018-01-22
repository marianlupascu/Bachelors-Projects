#include "EventManager.h"

EventManager* EventManager::instance = 0;

EventManager::EventManager(){}

SDL_Point EventManager::getEvent(SDL_Event* e){

    SDL_Point mouse_position = {-1,-1};

    if(e -> type == SDL_MOUSEBUTTONDOWN)
        SDL_GetMouseState(&mouse_position.x,&mouse_position.y);

    return mouse_position;
}

EventManager* EventManager::getInstance(){

    if(instance)
        instance = new EventManager();

    return instance;
}

EventManager::~EventManager(){

    delete instance;
}
