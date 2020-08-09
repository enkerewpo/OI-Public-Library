/*
PROG:milk3
ID:asiapea1
LANG:C
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <ctype.h>

#define MAX 20

typedef struct State	State;
struct State {
    int a[3];
};

int seen[MAX+1][MAX+1][MAX+1];
int canget[MAX+1];

State
state(int a, int b, int c)
{
    State s;

    s.a[0] = a;
    s.a[1] = b;
    s.a[2] = c;
    return s;
}

int cap[3];

/* pour from bucket "from" to bucket "to" */
State
pour(State s, int from, int to)
{
    int amt;

    amt = s.a[from];
    if(s.a[to]+amt > cap[to])
	amt = cap[to] - s.a[to];

    s.a[from] -= amt;
    s.a[to] += amt;
    return s;
}

void
search(State s)
{
    int i, j;

    if(seen[s.a[0]][s.a[1]][s.a[2]])
	return;

    seen[s.a[0]][s.a[1]][s.a[2]] = 1;

    if(s.a[0] == 0)	/* bucket A empty */
	canget[s.a[2]] = 1;

    for(i=0; i<3; i++)
    for(j=0; j<3; j++)
	search(pour(s, i, j));	
}

void
main(void)
{
    int i;
    FILE *fin, *fout;
    char *sep;

    fin = fopen("milk3.in", "r");
    fout = fopen("milk3.out", "w");
    assert(fin != NULL && fout != NULL);

    fscanf(fin, "%d %d %d", &cap[0], &cap[1], &cap[2]);

    search(state(0, 0, cap[2]));

    sep = "";
    for(i=0; i<=cap[2]; i++) {
	if(canget[i]) {
	    fprintf(fout, "%s%d", sep, i);
	    sep = " ";
	}
    }
    fprintf(fout, "\n");

    exit(0);
}
