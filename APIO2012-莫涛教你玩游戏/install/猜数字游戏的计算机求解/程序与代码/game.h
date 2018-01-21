#include <iostream>
#include <string>
#include <vector>
using namespace std;

const int L = 4, S = 10, maxt = 9, Size = 5040;
//数字个数，数字范围[0,S)，最多猜测次数，不同的答案个数
const pair<int, int> error = make_pair(-1, -1);
//错误猜测时范围的信息
const pair<int, int> over = make_pair(-2, -2);
//猜测次数已达最多猜测次数且未猜出答案，当局游戏自动结束

string AIname = "Noname";

class game {
    int P, Ps, T[maxt + 1];
    //已猜局数，总局数，T[i]表示i次猜出的局数，T[0]表示未猜出的局数
    int a[L], t;
    //当前局的数字，当前局已猜次数
    int time;
    //记录时间
    public:
    game()
    //初始化
    {
        P = t = 0;
        Ps = 1;
        for (int i = 0; i < L; ++i)
            Ps *= S - i;
        memset(T, 0, sizeof(T));
        for (int i = 0; i < L; ++i)
            a[i] = i;
    }
    pair<int, int> guess(int* b)
    //猜数字，b数组为所猜的L个数字，以pair<A,B>返回猜测结果
    {
        if (!P && !t)
            freopen((AIname + "_log.txt").c_str(), "w", stdout);
        if (!t) {
            cout << "Game  " << P + 1 << " : ";
            for (int i = 0; i < L; ++i)
                cout << a[i] << " ";
            cout << endl;
        }
        ++t;
        int A = 0, B = 0;
        for (int i = 0; i < L; ++i)
            if (b[i] < 0 || b[i] > S) return error;
        for (int i = 0; i < L; ++i)
            for (int j = i + 1; j < L; ++j)
                if (b[i] == b[j]) return error;
        for (int i = 0; i < L; ++i)
            if (a[i] == b[i]) ++A;
        for (int i = 0; i < L; ++i)
            for (int j = 0; j < L; ++j)
                if (a[i] == b[j]) ++B;
        cout << "guess " << t << " : ";
        for (int i = 0; i < L; ++i)
            cout << b[i] << " ";
        cout << " " << A << "A" << B - A << "B" << endl;
        if (A == L || t == maxt) {
            if (A == L) {
                ++T[t];
                cout << "Seccessful game in " << t << " guesses" << endl << endl;
            }else {
                ++T[0];
                cout << "Failed game" << endl << endl;
            }
            if (++P == Ps) {
                freopen((AIname + "_summary.txt").c_str(), "w", stdout);
                //cout << P << " Games: " << P - T[0] << " Y / " << T[0] << " N" << endl;
                int max = 0, sum = 0;
                for (int i = 1; i <= maxt; ++i) {
                    if (T[i]) max = i;
                    sum += i * T[i];
                }
                cout << fixed;
                cout.precision(3);
                cout << "平均猜测次数 : " << double(sum) / (P - T[0]) << endl;
                cout << "最多猜测次数 : " << max << endl;
                cout << "总耗时       ：" << clock() / 1000.0  << " seconds" << endl;
                cout << "每种猜测次数完成游戏的局数如下：" << endl;
                cout << "次数" << "\t";
                for (int i = 1; i <= maxt; ++i)
                    cout << i << "\t";
                cout << endl;
                cout << "局数" << "\t";
                for (int i = 1; i <= maxt; ++i)
                    cout << T[i] << "\t";
                cout << endl;
                exit(0);
            }else {
                t = 0;
                bool u[S];
                memset(u, 0, sizeof(u));
                int x = P;
                for (int i = 0; i < L; ++i) {
                    int y = x;
                    for (int j = i + 1; j < L; ++j)
                        y /= S - j;
                    for (int j = 0; j < S; ++j)
                        if (!u[j]) {
                            --y;
                            if (y < 0) {
                                u[j] = true;
                                a[i] = j;
                                break;
                            }
                        }
                    y = 1;
                    for (int j = i + 1; j < L; ++j)
                        y *= S - j;
                    x %= y;
                }
            }
        }
        return make_pair(A, B - A);
    }
} G;

pair<int, int> guess(int* b)
{
    return G.guess(b);
}

pair<int, int> guess(vector<int> vb)
{
    int b[L];
    for (int i = 0; i < L; ++i)
        b[i] = vb[i];
    return G.guess(b);
}
