#include <iostream>
#include <string>
#include <vector>
#include <cmath>
#include "game.h"
using namespace std;

vector<int> a;
bool u[S];
//临时变量
vector< vector<int> > f, g, h;
//所有可能的答案，当前可能的答案，临时变量
int t, ts, p;
//当前局猜测步数，总步数，已使用的最大数字
int ct[Size + 1][L + 1][L + 1];
//ct[i][j][k]表示猜测h[i]返回jAkB时可能集的大小

void dfs(int i)
//扩展f
{
    if (i == L) f.push_back(a);
    else
        for (int j = 0; j < S; ++j)
            if (!u[j]) {
                u[j] = true;
                a.push_back(j);
                dfs(i + 1);
                u[j] = false;
                a.erase(a.begin() + i);
            }
}

void dfs2(int i)
//扩展本质不同集合
{
    if (i == L) h.push_back(a);
    else
        for (int j = 0; j < S; ++j)
            if (!u[j] && (j <= p + 1 || u[j - 1])) {
                u[j] = true;
                a.push_back(j);
                dfs2(i + 1);
                u[j] = false;
                a.erase(a.begin() + i);
            }
}

pair<int, int> calc(const vector<int> &a, const vector<int> &b)
//计算答案为a，猜测为b时的返回值
{
    int A = 0, B = 0;
    memset(u, 0, sizeof(u));
    for (int i = 0; i < L; ++i)
        u[a[i]] = true;
    for (int i = 0; i < L; ++i)
        if (a[i] == b[i]) ++A;
        else
        if (u[b[i]]) ++B;
    return make_pair(A, B);
}

vector<int> find()
//从g中计算出当前应该猜测的数字
{
    if (t == 1) return f[0];
    if (g.size() == 1) return g[0];
    if (p >= S - 2) h = f;
    else {
        h.clear();
        a.clear();
        memset(u, 0, sizeof(u));
        dfs2(0);
    }
    //优化后的R值的计算，此时h为本质不同的X的集合
    memset(ct, 0, h.size() * (L + 1) * (L + 1) * sizeof(int));
    for (int i = 0; i < g.size(); ++i) {
        memset(u, 0, sizeof(u));
        for (int j = 0; j < L; ++j)
            u[g[i][j]] = true;
        for (int j = 0; j < h.size(); ++j) {
            int A = 0, B = 0;
            for (int k = 0; k < L; ++k)
                if (h[j][k] == g[i][k]) ++A;
                else
                if (u[h[j][k]]) ++B;
            ++ct[j][A][B];
        }
    }
    double bv = 1e9;
    vector<int> ret;
    for (int i = 0; i < h.size(); ++i) {
        double v = 0;
        //估价函数的计算
        for (int j = 0; j < L; ++j)
            for (int k = 0; j + k <= L; ++k)
                v += ct[i][j][k] * log(ct[i][j][k] + 1);
                //v += ct[i][j][k] * ct[i][j][k];//平均可能集大小
                //if (ct[i][j][k]) v += ct[i][j][k] * log(ct[i][j][k]);//预期步数
                //if (ct[i][j][k] > v) v = ct[i][j][k];//最坏可能集大小
                //if (ct[i][j][k]) --v;//反馈个数
        if (v < bv || (v == bv && binary_search(g.begin(), g.end(), h[i]))) {
            bv = v;
            ret = h[i];
        }
    }
    return ret;
}


int main()
{
    AIname = "game";
    dfs(0);
    for (int P = 0; P < f.size(); ++P) {
        g = f;
        t = 0;
        p = L - 1;
        memset(u, 0, sizeof(u));
        do {
            ++t;
            a = find();
            pair<int, int> ret = guess(a);
            if (ret.first == 4) break;
            for (int i = 0; i < L; ++i)
                if (a[i] > p) p = a[i];
            h.clear();
            for (int i = 0; i < g.size(); ++i)
                if (calc(g[i], a) == ret) h.push_back(g[i]);
            g = h;
        }while (1);
        ts += t;
        cerr << P << " " << t << " " << double(ts) / (P + 1) << endl;
    }

    return 0;
}
