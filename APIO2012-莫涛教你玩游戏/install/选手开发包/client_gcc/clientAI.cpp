#include "clientAI.h"
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <vector>
#include <string>
#include <cstring>
#include <cmath>
using namespace std;

class simplex {
private:
    static const int maxsize = 12;
    static const double inf = 1e70;
    static const double eps = 1e-13;
    double a[maxsize][maxsize], a2[maxsize][maxsize];
    double b[maxsize], b2[maxsize], q[maxsize], c[maxsize];
    int n, nn[maxsize], bb[maxsize];
    double u, min;

private:
    int getpos()
    {
        int ret = 0;
        double max = 0;
        for (int i = 1; i <= n; ++i)
            if (c[i] > max) {
                max = c[i];
                ret = i;
            }
        return ret;
    }

    void pivot(int e, int l)
    {
        for (int i = 1; i <= n; ++i)
            b2[i] = b[i];
        b2[l] = b[l] / a[l][e];
        for (int i = 1; i <= n; ++i)
            for (int j = 1; j <= n; ++j)
                a2[i][j] = a[i][j];
        for (int j = 1; j <= n; ++j)
            if (j != e)
                a2[l][j] = a[l][j] / a[l][e];
        a2[l][e] = 1 / a[l][e];
        for (int i = 1; i <= n; ++i)
            if (i != l) {
                b2[i] = b[i] - a[i][e] * b2[l];
                for (int j = 1; j <= n; ++j)
                    if (j != e)
                        a2[i][j] = a[i][j] - a[i][e] * a2[l][j];
                a2[i][e] = -a[i][e] / a[l][e];
            }
        u += c[e] * b2[l];
        swap(nn[e], bb[l]);
        for (int j = 1; j <= n; ++j)
            if (j != e)
                c[j] -= c[e] * a2[l][j];
        c[e] = -c[e] / a[l][e];
        for (int i = 1; i <= n; ++i) {
            b[i] = b2[i];
            for (int j = 1; j <= n; ++j)
                a[i][j] = a2[i][j];
        }
    }

public:
    simplex(vector< vector<double> > p)
    {
        memset(a, 0, sizeof(a));
        memset(a2, 0, sizeof(a2));
        memset(b, 0, sizeof(b));
        memset(b2, 0, sizeof(b2));
        memset(q, 0, sizeof(q));
        memset(c, 0, sizeof(c));
        memset(nn, 0, sizeof(nn));
        memset(bb, 0, sizeof(bb));
        u = min = 0;
        n = p.size();
        for (int i = 1; i <= n; ++i)
            for (int j = 1; j <= n; ++j)
                a[i][j] = -p[j - 1][i - 1];
    }

    vector<double> calc()
    {
        min = -1;
        for (int i = 1; i <= n; ++i)
            for (int j = 1; j <= n; ++j)
                if (a[i][j] - 1 < min)
                    min = a[i][j] - 1;
        for (int i = 1; i <= n; ++i)
            for (int j = 1; j <= n; ++j)
                a[i][j] -= min;
        for (int i = 1; i <= n; ++i) {
            bb[i] = n + i;
            b[i] = 1;
        }
        for (int i = 1; i <= n; ++i) {
            nn[i] = i;
            c[i] = 1;
        }
        int e = getpos();
        double k, t;
        while (e > 0) {
            k = inf;
            int l = 0;
            for (int i = 1; i <= n; ++i)
                if (a[i][e] > eps) {
                    t = b[i] / a[i][e];
                    if (t < k) {
                        k = t;
                        l = i;
                    }
                }
            //assert(l != 0);
            pivot(e, l);
            e = getpos();
        }
        vector<double> ret(n, 0);
        for (int i = 1; i <= n; ++i)
            if (bb[i] <= n)
                ret[bb[i] - 1] = b[i] / u;
        ret.push_back(-(min + 1 / u));
        return ret;
    }
};

const double f[100] = {
0.500000000,0.784513696,0.922261265,1.000000000,1.000000000,
0.690258965,0.927303957,1.000000000,1.000000000,1.000000000,
0.215486304,0.500000000,0.680185803,0.878388906,1.000000000,
0.351248523,0.690258965,0.905009816,1.000000000,1.000000000,
0.077738735,0.319814197,0.500000000,0.749260036,1.000000000,
0.165769701,0.543423024,0.800084722,1.000000000,1.000000000,
0.000000000,0.121611094,0.250739964,0.500000000,1.000000000,
0.000000000,0.313924586,0.597484603,1.000000000,1.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.500000000,
0.000000000,0.000000000,0.000000000,0.690258965,0.927303957,
0.309741035,0.648751477,0.834230299,1.000000000,1.000000000,
0.500000000,0.826943425,1.000000000,1.000000000,1.000000000,
0.072696043,0.309741035,0.456576976,0.686075414,1.000000000,
0.173056575,0.500000000,0.735341710,1.000000000,1.000000000,
0.000000000,0.094990184,0.199915278,0.402515397,1.000000000,
0.000000000,0.264658290,0.500000000,1.000000000,1.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.309741035,
0.000000000,0.000000000,0.000000000,0.500000000,0.826943425,
0.000000000,0.000000000,0.000000000,0.000000000,0.072696043,
0.000000000,0.000000000,0.000000000,0.173056575,0.500000000
};

const int stateNum = 100;
const int actionNum = 8;

const int Dmp[2][actionNum] = {{-1, -2, -3, -4, 0, -1, -2, 1},
                               {-5, -1, -2, -3, -5, 0, -5, 1}};

int cntRand, randNum[100000];
int e[stateNum][actionNum][actionNum];
int win[stateNum][actionNum], lose[stateNum][actionNum];
vector< pair<int, int> > history;

int calc(int mymp, int mylv, int opmp, int oplv, ACTION myact, ACTION opact)
{
    bool myerr = mymp + Dmp[mylv][myact] < 0;
    bool operr = opmp + Dmp[oplv][opact] < 0;
    if (myerr && operr) return -3;
    if (myerr) return -4;
    if (operr) return -5;
    if (myact < 4 && opact < 4) {
        if (myact > opact) return -1;
        if (myact < opact) return -2;
    }else {
        if (myact < 2 && opact >= 6) return -1;
        if (myact == ATTACK_3 && opact != DEFEND_2) return -1;
        if (myact == ATTACK_4) return -1;
        if (opact < 2 && myact >= 6) return -2;
        if (opact == ATTACK_3 && myact != DEFEND_2) return -2;
        if (opact == ATTACK_4) return -2;
    }
    mymp += Dmp[mylv][myact];
    if (myact == RAMPAGE) ++mylv;
    opmp += Dmp[oplv][opact];
    if (opact == RAMPAGE) ++oplv;
    if (mymp > 4) mymp = 4;
    if (opmp > 4) opmp = 4;
    return mymp + mylv * 5 + opmp * 10 + oplv * 50;
}

void init(int totalSet) {
	srand(((time(NULL)) + 5) % 10000);
	cntRand = 0;
	for (int i = 0; i < 100000; i ++)
		randNum[i] = (rand() + rand() + rand() + rand()) % 10000;
    memset(win, 0, sizeof(win));
    memset(lose, 0, sizeof(lose));
    for (int i = 0; i < stateNum; ++i)
        for (int j = 0; j < actionNum; ++j)
            for (int k = 0; k < actionNum; ++k)
                e[i][j][k] = calc(i % 5, i % 10 / 5, i / 10 % 5, i / 50, (enum ACTION)j, (enum ACTION)k);
}

void beginSet(int cntSet) {
    history.clear();
}

void endSet(int result) {
    for (int i = 0; i < history.size(); ++i) {
        if (result == 0 || result == 1)
            ++win[history[i].first][history[i].second];
        if (result == 0 || result == 2)
            ++lose[history[i].first][history[i].second];
    }
}

ACTION getAction(int cntRound, int myMP, int myState, int opMP, int opState, ACTION opAction)
{
    if (myMP > 4) myMP = 4;
    if (opMP > 4) opMP = 4;
    int S = myMP + myState * 5 + opMP * 10 + opState * 50;
    vector< vector<double> > c(actionNum, vector<double>(actionNum, 0));
    for (int i = 0; i < actionNum; ++i)
        for (int j = 0; j < actionNum; ++j) {
            int k = e[S][i][j];
            if (k >= 0)
                c[i][j] = f[k];
            else
            if (k == -1 || k == -5)
                c[i][j] = 1;
            else
                c[i][j] = 0;
            if (i == 4)
                c[i][j] *= 2;
            /*
            if (win[S][i] > 5 && lose[S][i] > 5 && f[S] > 0.05)
                c[i][j] = c[i][j] * win[S][i] / (win[S][i] + lose[S][i]) / f[S];
            */
        }

    cout << fixed;
    cout.precision(7);
    for (int i = 0; i < actionNum; ++i) if (i == 0 || i == 4 || i == 7) {
        for (int j = 0; j < actionNum; ++j) if (j == 0 || j == 4 || j == 7)
            cout << c[i][j] << "\t";
        cout << endl;
    }
    vector<double> ret = simplex(c).calc();
    cout << ret[0] << " " << ret[4] << " " << ret[7] << endl;
    cout << ret[0] * c[0][0] + ret[4] * c[4][0] + ret[7] * c[7][0] << endl;
    cout << ret[0] * c[0][4] + ret[4] * c[4][4] + ret[7] * c[7][4] << endl;
    cout << ret[0] * c[0][7] + ret[4] * c[4][7] + ret[7] * c[7][7] << endl;
    system("pause");
    double P = randNum[cntRand++] * 10000 + randNum[cntRand++] + 1;
    for (int i = 0; i < actionNum; ++i) {
        P -= 1e8 * ret[i];
        if (P <= 0 && myMP + Dmp[myState][i] >= 0) {
            history.push_back(make_pair(S, i));
            return (enum ACTION)(i);
        }
    }
    history.push_back(make_pair(S, RESTORE));
    return RESTORE;
}

int main()
{
    init(0);
    win[11][DEFEND_1] = 100;
    lose[11][DEFEND_1] = 70;
    ACTION t = getAction(0, 1, 0, 1, 0, RESTORE);
    return 0;
}

