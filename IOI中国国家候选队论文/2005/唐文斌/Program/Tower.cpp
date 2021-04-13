#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <ctime>
#include <cmath>

const int MaxH = 100 + 1;
const int HashSize = 59997;
const double HashSave_LowerBound = 0;
const double HashSave_UpperBound = 1e15;

struct Tdat
{
	int N , H , M;
	double ret;
};

int N , H , M;
double power[MaxH];
Tdat data[HashSize];

int HashCount;			// 统计hash表中的元素数目
int RequestTime;		// hash查询次数
int FindTime;			// hash查找次数

inline int min_need(int H , int M)
{
	if(H <= M) return (M + M - H + 1) * H / 2;
	else return (M + 1) * M / 2 + (H - M) * 2 - (H - M) / 2;
}

inline int max_need(int H , int M)
{
	return (M + M + H - 1) * H / 2;
}

void init()
{
	int i;

	scanf("%d%d%d" , &N , &H , &M);
	if(max_need(H , M) < N) N = max_need(H , M);

	power[0] = 1;
	for(i=1; i<=H; i++)
		power[i] = power[i-1] * 2;
	for(i=0; i<HashSize; i++)
		data[i].ret = -1;
}

inline int hash(int N , int H , int M)
{
	return ((N * 127 + H) * 127 + M) % HashSize * 127 % HashSize;
}

bool find_hash(int N , int H , int M , double& ret)
{
	int h = hash(N , H , M);
	RequestTime++; FindTime ++;
	while(data[h].ret >= 0)
	{		
		if(data[h].N == N && data[h].H == H && data[h].M == M)
		{
			ret = data[h].ret;
			return 1;
		}
		h = (h + 1) % HashSize;
		FindTime ++;
	}
	return 0;
}

void insert_hash(int N , int H , int M , double ret)
{
	int h = hash(N , H , M);
	while(data[h].ret >= 0)
	{
		h = (h + 1) % HashSize;
	}
	data[h].N = N; data[h].H = H;
	data[h].M = M; data[h].ret = ret;
	HashCount++;
}

double dfs(int N , int H , int M)
{
	if(M <= 0) return 0;
	if(min_need(H , M) > N) return 0;
	if(max_need(H , M) <= N && H <= M) return power[H-1];	
	if(max_need(H , M) <= N) N = max_need(H , M);

	double ret;

	if(find_hash(N , H , M , ret)) return ret;

	double a = dfs(N - M , H - 1 , M - 1);
	double b = dfs(N - M , H - 1 , M + 1);
	ret = a + b;

	if(HashSave_LowerBound <= ret && ret <= HashSave_UpperBound)
		insert_hash(N , H , M , ret);

	return ret;
}

void print_way(double k)
{
	int curt = M;	printf("%d" , curt);
	int TN = N;
	double tmp;
	for(int i=1; i<H; i++)
	{
		TN -= curt;
		tmp = dfs(TN , H - i , curt - 1);
		if(tmp >= k) curt--;
		else
		{
			k -= tmp; curt++;
		}

		printf(" %d" , curt);
	}
	putchar('\n');
}

int main()
{
	freopen("Tower.in" , "r" , stdin);
	freopen("Tower.out", "w" , stdout);

	HashCount = 0;
	FindTime = 0;
	RequestTime = 0;

	init();
	printf("%.0lf\n" , dfs(N , H , M));
	

	double k;
	while(scanf("%lf" , &k) , k > 0)
	{
		print_way(k);
	}

	fprintf(stderr, "------------------- details -------------------\n");
	fprintf(stderr, "Program Running Time       :	%.4lfs\n" , clock()/(double)CLK_TCK);
	fprintf(stderr, "Hash Table Saved           :	%-8d\n" , HashCount);
	fprintf(stderr, "Hash Table Request Time    :	%-8d\n" , RequestTime);
	fprintf(stderr, "Hash Table findtime        :	%-8d\n" , FindTime);
	fprintf(stderr, "Average Find findtime      :	%.5lf\n" , (double)FindTime / RequestTime);

	return 0;
}
//对于极限数据，double可能存在精度问题，改成longdouble即可