#include "clientAI.h"
#include <cstdlib>
#include <ctime>
using namespace std;

int randNum[100000];
int cntRand;

void init(int totalSet) {
	srand(time(0) % 12345);
	cntRand = 0;
	for (int i = 0; i < 100000; i ++)
		randNum[i] = rand();
}

void beginSet(int cntSet) {

}

void endSet(int result) {

}

ACTION getAction(int cntRound, int myMP, int myState, int opMP, int opState, ACTION opAction) {
	int t = randNum[cntRand ++] % 3;
	if (t == 0 && myMP > 0) return ATTACK_1;
	else if (t == 1) return DEFEND_1;
	else return RESTORE;
}
