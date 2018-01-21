#ifndef __CLIENTAI_H__
#define __CLIENTAI_H__

#include "common.h"

#define DLL_EXPORT extern "C" __declspec(dllexport)

DLL_EXPORT void init(int totalSet);
DLL_EXPORT void beginSet(int cntSet);
DLL_EXPORT void endSet(int result);
DLL_EXPORT ACTION getAction(int cntRound, int myMP, int myState, int opMP, int opState, ACTION opAction);

#endif
