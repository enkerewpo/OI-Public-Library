#ifndef __CONST_H__
#define __CONST_H__

enum TIME_LIMIT {
	INIT_TIME = 1000,
	BEGIN_TIME = 100,
	END_TIME = 100,
	ROUND_TIME = 50
};

enum ACTION {
	ATTACK_1 = 0,
    ATTACK_2 = 1,
    ATTACK_3 = 2,
    ATTACK_4 = 3,
	DEFEND_1 = 4,
    DEFEND_2 = 5,
    RAMPAGE = 6,
	RESTORE = 7,
	NONE = 8
};

#endif
