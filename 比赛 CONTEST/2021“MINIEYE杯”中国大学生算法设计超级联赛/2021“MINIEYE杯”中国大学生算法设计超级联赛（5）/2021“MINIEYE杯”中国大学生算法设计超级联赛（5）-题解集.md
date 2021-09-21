# 1001

对 $link-cut-tree$ 有所了解的选手不难发现，操作 $1$ 是在模拟 $lct$ 的 $access$ 操作

于是操作 $1$ 可以在 $lct$ 虚实边切换的时候用一个线段树区间修改，同时维护操作 $4$ 的答案

操作 $2$ 相当于单点询问，操作 $3$ 相当于询问子树和然后再扣掉点 $u$ 的答案

复杂度 $O(nlog^2n)$

# 1002

可以通过枚举字符$a$,$b$在字符串出现的次数$x$,$y$得到:

 $$ans[i][j]  = \sum_{x=0}^L\sum_{y=0}^{L-x}[n\mid x-i][n\mid y-j]\tbinom{L}{x}\tbinom{L - x}{y}(k - 2)^{L-xy}$$

$$\quad \quad\quad \quad =\sum_{x=0}^L\sum_{y=0}^{L-x}\frac{1}{n}\sum_{p = 0}^{n - 1}w_n^{p\times(x-i)}\frac{1}{n}\sum_{q=0}^{n - 1}w_n^{q\times(y-j)}\tbinom{L}{x}\tbinom{L - x}{y}(k - 2)^{L-xy}$$

由单位根反演可得

$$\quad \quad\quad \quad =\frac{1}{n^2}\sum_{x=0}^L\sum_{y=0}^{L-x}\sum_{p = 0}^{n - 1}w_n^{p\times(x-i)}\sum_{q=0}^{n - 1}w_n^{q\times(y-j)}\tbinom{L}{x}\tbinom{L - x}{y}(k - 2)^{L-xy}$$

$$\quad \quad\quad \quad=\frac{1}{n^2}\sum_{p=0}^{n - 1}\sum_{q = 0}^{n - 1}\sum_{x=0}^L\sum_{y=0}^{L-x}w_n^{p\times(x-i)}w_n^{q\times(y-j)}\tbinom{L}{x}\tbinom{L - x}{y}(k - 2)^{L-xy}$$

$$\quad \quad\quad \quad =\frac{1}{n^2}\sum_{p=0}^{n - 1}\sum_{q = 0}^{n - 1}\sum_{x=0}^L\sum_{y=0}^{L-x}w_n^{px}w_n^{qy}\tbinom{L}{x}\tbinom{L - x}{y}(k - 2)^{L-xy}w_n^{-pi}w_n^{-qj}$$

$$\quad \quad\quad \quad =\frac{1}{n^2}\sum_{p=0}^{n - 1}\sum_{q = 0}^{n - 1}(w_n^{p} + w_n^{q} + k - 2) ^{ L}w_n^{-pi}w_n^{-qj}$$

我们令

​				$$A[i][p] = w_n^{-ip}$$​​           $$B[p][q]  = \frac{1}{n ^2} (w_n^{p} + w_n^{q} + k - 2) ^{ L}$$​​     $$C[q][j] = w_n^{-qj}$$​​

则$$ans  = A \times B \times C$$

总时间复杂度为$$O(n ^ 3 + n ^ 2 logL ) $$

# 1003

【等价题意】

$n$维空间中，求$m$的最大值，使得你可以找到$m$个点(自己给定坐标)，满足：

无论对这$m$个点如何二染色，也就是对于$2^m$种染色方案中的每一种，都总存在一个$n-1$维超平面，严格分开这两种颜色的点。



【结论】

$m_{max}=n+1$



【证明思路】

显然有单调性，可以分两步证明结论：

- 证明$m=n+1$可行
  - 即：可构造一组点的坐标($x_0,x_1,x_2,⋯,x_n\in R^n$)，证明其任意一组染色方案，都可以找到一个线性超平面将其染成这个方案
  - 这里染成这个方案指的是，超平面($>0$)一侧是黑，一侧($<0$)是白
- 证明$m\ge n+2$无解
  - 即：证明$n+2$个点无论如何放置(设计坐标)，都总存在一种染色方案，使得没有一个线性超平面可以将其染成这个方案



【完整证明】

**第一步证明：**

令$x_0=(0,0,0,⋯,0), x_i=$第$i$个下标是$1$其他是$0$的$01$向量，$x_0,x_i\in R^n, i\in [1,n]$；
令$f_w (x)=w_0+w_1⋅x_1+w_2⋅x_2+⋯+w_n⋅x_n=w^T [1\ x]^T$；

注意向量默认是列向量，这里$w$和$x$是向量；

我们的线性分类超平面就是：$f_w (x)\ge 0$

令染色方案$S=\{(x_i,y_i )\},  i\in [0,n],  y_i \in \{+1,−1\}$，我们直接构造一个$w$，使得$f_w(x_i)=y_i$
那么：$f(x_i )=y_i,i \in [0,n]$，可解方程组确定$w$

$w_0=y_0$

$w_0+w_i=y_i,i\in [1,n]$

**第二步证明：**

以$x_i=[1\ x_i]$代替原输入$x_i$；
现在输入$x_i$，我们构造$y_i\in \{−1,+1\}$，使得$w$不存在

考虑在$R^{n+1}$ 空间中(因为我们对输入加了一维$1$)，$n+2$个点一定是线性相关的；
存在一组不全为$0$的系数，使得它们的加权和为$0$，令那个不为$0$的系数对应的项为$x_0$，那么$x_0$ 可以由$x_i,i\in [1,n+1]$线性表示；

令：
$$
x_0=\sum_{i=1}^{n+1}a_ix_i
$$
我们先构造$y_i,i\in [1,n+1]$，再构造$y_0$，想办法使得$w$无解：

思路是：让$w^T a_i x_i\ge  0$，但是：
$$
w^Tx_0=\sum_{i=1}^{n+1}w^Ta_ix_i<0
$$
从而制造矛盾。

**构造方法：**

对于$i\in [1,n+1]$，如果$a_i\ge 0,y_i=1$，如果$a_i<0,y_i=−1$。且$y_0=−1$。

如果$y_i=−1$，则$f_w (x_i)=w^T x_i<0，w^T a_i x_i\ge 0$

如果$y_i=1$，则$f_w (x_i )=w^T x_i>0$，$w^T a_i x_i\ge 0$

这样的话：$w^T a_i x_i\ge  0$总是成立，
$$
w^Tx_0=\sum_{i=1}^{n+1}w^Ta_ix_i\ge 0
$$
但是由于$y_0=−1,f_w(x_0)=w^T x_0<0$矛盾！

所以这样的$y$构造，使得$w$无解，则不存在$n-1$维超平面$f$使得$f$可以严格分割这个染色方案$S$​



# 1004

定义$F[i,j]$表示字符串$S$中分别以$i,j$为左端点的两个子串满足k-匹配的最大长度。

换句话说，$F[i,j]$等于使得$S[i,i+L-1]$与$S[j,j+L-1]$满足k-匹配的最大$L$。

考虑如何计算所有的$F[i,j](1 \le i<j \le n)$

* 我们枚举两个子串的左端点之差$d$ $( d \in [1,n-1] )$
* 对于每一个$d$，利用k-匹配的单调性，通过双指针，我们可以在线性时间内计算出所有的$F[i,i+d](1 \le i \le n-d)$
* 因此，我们可以用$O(n^2)$的时间复杂度计算出所有的$F[i,j]$

考虑如何计算串S的所有分割情况下的答案

* 定义$t(2 \le t \le n)$分割是将$S$分为$A=S[1,t-1]$和$B=S[t,n]$
* 对于$t$分割，不难发现，我们要统计的答案为$\sum^{t-1}_{i=1}\sum^{n}_{j=t}G[i,j]$，其中$G[i,j]=min(F[i,j],t-i)$
* 不妨从大到小枚举$t$，过程中维护G对答案的贡献
* 注意到G[i,j]的值不超过$t-i$。因此可以对每个$i$维护一个$count_i$数组来对有贡献的$G[i,j]$计数。换句话说，$count_i[x]$表示$\{G[i,j]|2\le j \le n\}$中此时对答案有贡献且值为x的个数
* 同时我们对每个$i$再维护一个$max_i$表示此时$\{G[i,j]|2\le j \le n\}$中对答案有贡献的最大值。对于t的每次减小，我们通过维护$count_i$数组和$max_i$，来计算答案的变化。
* 注意到过程中$G[i,j] \le t-i$，因而$max_i$在单调减少。而每次新增产生贡献的G[i,j]的数量为$O(n)$且值也不超过$t-i$。因此整个过程的时间复杂度是$O(n^2)$

综上所述，整个算法的时间复杂度为$O(n^2)$



# 1005 

记$\displaystyle \lambda_i=W_{i,i},d_i=\sum_{j=1}^nW_{i,j}$​

则有转移方程

$\displaystyle A_{i,i}=\frac{\lambda_i}{\lambda_i+d_{i}}*1+\sum_{j=1,j\not=i}^n\frac{W_{i,j}}{\lambda_i+d_{i}}A_{j,i}$

$\displaystyle A_{i,j}=\sum_{k=1,k\not=i}^n\frac{W_{i,k}}{\lambda_i+d_{i}}A_{k,j}(i\not=j)$​

构造无自环矩阵$W$​​​，自环的对角矩阵$\Lambda$​​​，$W$度数​​矩阵$D$​​

$(I-(\Lambda +D)^{-1}W)A=(\Lambda+D)^{-1}\Lambda$​

 第一步列转移方程 

 第二步写出矩阵形式 

 第三步解矩阵方程，套板子 

算出$A^{-1}$矩阵，套个求逆板子即可



# 1006

按题意模拟即可，输出树的节点个数即可



# 1007

对于最大代价的情况，显然我们需要填充满$n \times n \times n$的空间，并且为了最大化代价，需要将每一砖块从最高处丢下，因此有最大代价：$\sum_{x=1}^{n}\sum_{y=1}^{n}\sum_{z=1}^{n}x \times y^2 \times n=n^2 \times \frac {(n+1)n}{2} \times \frac {n(n+1)(2n+1)}{6}$

对于最小代价的情况，由于重力作用，需将底面铺满。为满足另外两个视角，还需要立一面随着$x$递增,$y$递减的竖墙。因此有最小代价：$\sum_{x=1}^{n}\sum_{y=1}^{n}x \times y+\sum_{y=1}^{n}\sum_{z=2}^{n}(n+1-y) \times y^2 \times z=\frac {(n+1)^2n^2}{4} + \frac {(2+n)(n-1)}{2} \times (\frac{n(n+1)^2(2n+1)}{6} - \frac{n^2(n+1)^2}{4})$



# 1008

注意到题目是求条件概率

我们可以通过高维前缀和求出对于一个集合$T$有多少超集$U$，记为$cnt[T]$

显然答案为$\displaystyle \sum_{S\in[0,2^n)} \sum_{T\in[0,2^n)} \frac{cnt[T\or S]}{cnt[S]}$

$T\or S$又可以用高维前缀和再一次优化，记为$cnt0[T]$

显然答案为$\displaystyle \sum_{S\in[0,2^n)} \frac{cnt0[S] *2^{bit(S)}}{cnt[S]}$

$bit(S)$表示为$S$中$1$的个数

所以复杂度为$O(n2^n)$



# 1009

##  暴力做法时间复杂度$O(k*nlogn)$

### 做法1、2：权值线段树、树状数组

代码略

## 做法3：考虑k如果变大 考虑根据出现次数分成>=sqrt(n)和<sqrt(n)的部分

复杂度$n\sqrt n*logn$

使用桶/哈希表/集合计数x的出现次数 按从大到小排序

1.当出现次数大于等于$\sqrt n$时，有出现的类别最多$\sqrt n$种，按做法1和2的时间复杂度,该部分$k \leq \sqrt n$ ，所以该部分复杂度是$\sqrt n*nlogn$

2.当出现次数小于$\sqrt n$时，考虑每一个数每次出现的位置，假设一个数出现$t_i$次,记录出现的位置,对于每一个数考虑枚举$l_i,r_i,t_i$，考虑左边右边合法的位置，对于一个数可以$O(ti^2)$求得，有$f=t_1^2+t_2^2+...+t_n^2 \leq \sqrt n (t_1+t_2+..+t_n)=n\sqrt n$ 所以该部分复杂度最大$n\sqrt n$ 

## 做法4：考虑对两种算法均摊

令分块的界限为d 

1.当出现次数大于等于$d$时，有出现的类别最多$n/d$种，按做法1和2的时间复杂度,该部分$k \leq n/d$ ，所以该部分复杂度是$n/d*nlogn$

2.当出现次数小于$d$时，考虑每一个数每次出现的位置，假设一个数出现$t_i$次,记录出现的位置,对于每一个数考虑枚举$l_i,r_i,t_i$，考虑左边右边合法的位置，对于一个数可以$O(ti^2)$求得，有$f=t_1^2+t_2^2+...+t_n^2 \leq \sqrt n (t_1+t_2+..+t_n)=nd$ 所以该部分复杂度最大$nd$ 

解得$d= \sqrt {n logn}$

复杂度为$O(n^{3/2}\sqrt {log_2n})$

### 做法5：树状数组

复杂度为$O(n{log_2n})$

使用桶/哈希表/集合计数x的出现 依次遍历每一个数 考虑合并相邻两块同一个数的影响

答案是把每个位置前缀和得到的去数前面有几个比前缀和小的

原始数组是   1 1 2 1
变一下       1 1 -1 1
前缀和一下  0 1 2 1 2
贡献         1 2 1 3

证明如果前缀和比之前某个前缀和大意味着前缀和-前缀和的这个区间 是符合条件的
SUM[NOW]-SUM[LAST_I]>0=>LAST_I+1->NOW区间满足条件
然后需要处理就是 每一个1的地方处理前面有几个-1对答案的贡献 当前这个1对答案的贡献
假如有k种数，每个数出现t次，每一次的代价是logn，对于一种数的代价是t_ilogn，sum(t_i)=n，复杂度就是$O(n{log_2n})$。可以通过。

### 做法6：

复杂度为$O(n)$

考虑对做法5进行优化，设sum为当前前缀和，f1[sum]表示前缀和为sum的点有f1[sum]个，对于每个点的贡献now就是所有小于sum的f1[sum]的和，如果接下来有一堆-1，就一下跳到这堆-1的末尾，需要做一次差分数组f2,在起点做-1标记，终点做+1标记，走到i时若f2[sum]不为0，则用f2[sum]更新f1，同时更新f2[sum+1]。代码略。



#1010



$\displaystyle y_i=\frac{e^{\frac{x_i+g_i-(x_k+y_k)}{\tau}}}{\sum_{j=1}^ke^{\frac{x_j+g_j-(x_k+g_k)}{\tau}}}\  for \  i=1,...,k$​

$u_i=x_i+g_i-(x_k+g_k) \ for \ i=1,..,k-1$

其中$g_i$​是伪代码中的$z$，为随机变量，满足$g_i$服从$gumbel$​​分布.

$gumbel$​分布的概率密度函数$f(z,\mu)=e^{\mu-z-e^{\mu-z}}$​

$\displaystyle p(u_1,...,u_{k-1})=\int_{-\infty}^{\infty}dg_kp(u_1,...,u_k|g_k)p(g_k)$

$\displaystyle =\int_{-\infty}^{\infty} dg_kp(g_k) \Pi_{i=1}^{k-1}p(u_i|g_k)$

$\displaystyle =\int_{-\infty}^{\infty}dg_kf(g_k,0) \Pi_{i=1}^{k-1}f(x_k+g_k,x_i-u_i)$

$\displaystyle =\int_{-\infty}^{\infty}dg_ke^{-g_k-e^{-g_k}} \Pi_{i=1}^{k-1}e^{x_i-u_i-x_k-g_k-e^{x_i-u_i-x_k-g_k}}$

先求出$u$的联合概率密度函数

$\displaystyle p(u_1,...,u_{k-1}=\delta(u_k=0)\int_0^{\infty}dv\frac{1}{v}ve^{x_k-v}\Pi_{i=1}^{k-1}ve^{x_i-u_i-x_k-g_k-e^{x_i-u_i-x_k-g_k}}$​

$\displaystyle =e^{x_k+\sum_{i=1}^{k-1}(x_i-u_i)}(e^{x_k}+\sum_{i=1}^{k-1}e^{x_i-u_i})^{-k}\Gamma(k)$​​

$=\Gamma(k) (\prod_{i=1}^ke^{x_i-u_i})  (\sum_{i=1}^ke^{x_i-u_i})^{-k}$​



$y_{1：k-1}=h(u_{1:k-1}),h_i(u_{1:k-1})=\frac{e^{u_i}{\tau}}{1+\sum_{j=1}^{k-1}e^{\frac{u_j}{\tau}}},\forall i=1,...,k-1$

接下来要求的是$y$的联合概率密度函数

$\displaystyle \sum_{i=1}^ky_i=1$

$\displaystyle y_k=1-\sum_{j=1}^{k-1}y_j$

$p(y_{1:k})=p(h^{-1}(y_{1:k-1}))det(\frac{\partial h^{-1}(y_{1:k-1})}{\partial y_{1:k-1}})$

采用换元法，由概率论知识：需要变换系数：雅可比行列式

需要求$h^{-1}(...),p(.),Jacobian(h^{-1}),det\ Jacobian(h^{-1})$

$h^{-1}(y_{1:k-1})=\tau*(ln(y_i)-ln(1-\sum_{j=1}^{k-1}y_j))=\tau*(ln(y_i)-ln(y_k))$

$\frac{\partial h^{-1}(y_{1:k-1})}{\partial y_{1:k-1}}=\tau*(diag({1 \over y_{1:k-1}})+{1 \over y_k})=\left(\begin{matrix}{1\over y_1}+{1\over y_k}&{1\over y_k}&\cdots &{1\over y_k}\\{1\over y_k}&{1\over y_2}+{1\over y_k}&\cdots&{1\over y_k}\\\vdots&\vdots&\ldots&\vdots\\ {1\over y_k}&{1\over y_k}&\cdots&{1\over y_n}+{1\over y_k}\end{matrix}\right)$

$det(\frac{\partial h^{-1}(y_{1:k-1})}{\partial y_{1:k-1}})={\tau}^{k-1}\Pi_{j=1}^{k-1}y_j^{-1}$

$\displaystyle p(y_1,y_2,..,y_k)=\Gamma(k) (\prod_{i=1}^ke^{x_i}\frac{y_k^\tau}{y_i^\tau})  (\sum_{i=1}^ke^{x_i}\frac{y_k^{\tau}}{y_i^\tau})^{-k}{\tau}^{k-1}\prod_{i=1}^ky_i^{-1}$

$\displaystyle=\Gamma(k){\tau}^{k-1}( \sum_{i=1}^k\frac{e^{x_i}}{y_i^{\tau}} )^{-k} \prod_{i=1}^k\frac{e^{x_i}}{y_i^{\tau+1}}$



#1011

1.当$x=y$时

易证$sg_i= \lfloor \frac{i}{2x} \rfloor \times x +  i\mod x$ , 此时题目转为$nim$博弈, $\bigoplus_{i=1}^n sg_{a_i}\gt 0$则先手胜, 否则先手败



以下我们令$sg_i=i$, 也就是$nim$博弈的$sg$值

2.当$x<y$时

不妨设$a_1\le a_2 \le a_3 \le ...\le a_{n-1}\le a_n$​

如果$a_n\lt x$​​, 此时题目是$nim$​​博弈, 所以只讨论$a_n \ge x$​​的情况

当先手能通过一次操作使$\max_{i=1}^na_i\lt x$​, 此时胜负由$\bigoplus_{i=1}^n a_i$​决定, 若先手能找到一个正数$z$​, 且$\bigoplus_{i=1}^n a_i \bigoplus a_n \bigoplus (a_n-z) =0$​, 此时先手必胜, 否则先手会考虑其他策略

当先手不能通过一次操作使$max_{i=1}^na_i\lt x$​, 此时我们将先手操作后的石子分三种情况考虑

①$a_{n-1}\lt x$, $a_n \ge x$

若此时$\bigoplus_{i=1}^n a_i\neq 0$, 必定存在一堆石子$j$和正数$z$, 使得$\bigoplus_{i=1}^n a_i\bigoplus a_j\bigoplus (a_j-z) =0$, 若$z\neq y$, 此时后手应直接取$z$个石子让先手进入$\bigoplus_{i=1}^n a_i=0$的状态, 若$z=y$, 显然$j=n$, 此时后手应从$a_n$取$y-x$个石子, 让先手陷入不能从第$n$堆取$x$个石子的困境

若此时$\bigoplus_{i=1}^n a_i=0$, 假设此时后手从$a_n$中取$x$个石子, 根据$nim$博弈的性质以及$a_{n-1}\lt x \lt y$, 先手必定有应对方案, 此时后手应选择先手的应对方案, 让先手陷入不能从第n堆石子取$x$个石子的困境

综上先手所能得到的局面, 必定是$\bigoplus_{i=1}^n a_i=0$或者$\bigoplus_{i=1}^n a_i \bigoplus a_n \bigoplus (a_n-x) =0$, 后手必胜

②$a_{n-2}\lt x$, $a_{n-1}\ge x$, $a_n \ge x$

先手必然不会取石子使得$a_{n-1}\lt x$或$a_n\lt x$, 后手必然也不会取, 最后只剩下$a_{n-1}=x$和$a_n=x$两堆石子, 此时如果是先手行动, 后手进行对称操作, x后手必胜, 此时如果是后手行动, 后手直接取掉$x$个石子, 此时只剩下$a_n=x$ 一堆石子, 先手无法一次取完, 后手必胜

③$a_{n-2}\ge x$, $a_n-1\ge x$, $a_n \ge x$

后手只要保持取完石子之后还是情况③, 让先手自己进入情况②, 先手必然不会主动进入情况②, 最终会剩下三堆$a_i=x$​​的石子, 后手只需取掉其中某一堆, 之后进行对称操作即可, 后手必胜

综上当先手能通过一次操作使$\max_{i=1}^na_i\lt x$且先$\bigoplus_{i=1}^n a_i \bigoplus a_n \bigoplus (a_n-z) =0$手胜，否则先手败



3.当$x>y$时

如果$a_n\lt y$, 此时题目是$nim$博弈, 所以只讨论$a_n \ge y$的情况

此时情况对应$x<y$时讨论的①②③情况, 先手必胜



#1012

注意到有

$$ ans[i]=[\sum_{i=1}^n\sum_{j=1}^r S_{ij} == i] $$​​​

   $$\quad\quad=[\sum_{i=1}^n\sum_{j=1}^n\sum_{k=1}^rA_{ik}B_{kj}  == i]$$​​​

   $$\quad\quad=[\sum_{k=1}^r(\sum_{i=1}^n A_{ik})\cdot (\sum_{j=1}^nB_{kj}) == i] $$​​

记$$F[q] 为 (\sum_{i=1}^n A_{ik}) = q $$的方案数

记$$G[q] 为 (\sum_{j=1}^nB_{kj}) = q $$​的方案数

容易发现$$F[q] = G[q] $$​

考虑如何计算$$F[x]$$的方案数，我们有生成函数

$$\quad\quad\quad\quad\quad\quad\quad\quad\quad\quad g(x) = (1 + x + x^2 + ... + x^m)^n$$​​​

则 

$$\quad\quad\quad\quad\quad\quad\quad\quad\quad\quad F[q] =  [x^q]g(x)$$​

$g(x)$的计算方法有两种

- 发现$$ q = 0, 1, .. m$$​​​，并且生成函数的最高项也为$m$​​​,则$$g(x)$$​​​展开后的第$q$​​​项$(q = 0, 1, 2, .. , m)$​​​的系数等价于$x_1 + x_2 + ... + xn = q$​​​的非负整数解的个数，这是一个经典问题可以使用隔板法解决,最后的结果为$$[x^q]g(x) = \tbinom{n + q - 1}{n - 1} $$​​​

- 直接使用多项式快速幂即求$$ln$$后再求$$exp$$

记$$H[i] 为 (\sum_{i=1}^n A_{ik})\cdot (\sum_{j=1}^nB_{kj}) = i $$ 的方案数

则有$$H[x * y] += F[x] \times G[y]$$​​     可以通过枚举$x, y$​得到$H[i]$​, $i = 0, 1, 2, ... , m $​的值

注意到$$H[0] += F[0] \times G[y] ,y = m + 1, m + 2, ... , m * n$$​​​,   通过上式我们没有计算类似这样的值.

考虑到$$H[0] = F[0] \times \sum_{i = 0} ^ {n * m} G[i]  + G[0] * \sum_{i = 0} ^ {n * m} F[i] - F[0] * G[0]$$​​ 

又$$ \sum_{i = 0} ^ {n * m} G[i] =  \sum_{i = 0} ^ {n * m} F[i] = (m + 1) ^ n $$​​​. $$F[0] = G[0] = 1$$

故修正$$H[0] = (m + 1) ^ n - 1$$

记生成函数

​							$$h[x] = (h[0] + h[1] x + h[2] x ^ 2 + ... + h[m] x ^m) ^ r $$​

则$$ans[i] = [x^i]h(x)$$ 

我们可以使用多项式快速幂求出$h(x)$, 注意到$r$很大,我们可以用欧拉定理处理

时间复杂度为$$O(mlogm)$$



# 1013

题目的意思等价于我们对$n$​个点操作完之后使得树的直径最短。

考虑二分答案，我们每次把二分的答案作为一个阈值来限制树形DP的转移。

对于一个以 $u$​为根的子树，我们维护两个状态$dp[u][0]$​代表$u$​这个节点的power值给儿子的情况下,$u$​子树所有叶子节点到$u$​的最长链,$dp[u][1]$​代表$u$​这个节点的power值给父亲的情况下,$u$​子树所有叶子节点到$u$​的最长链,

对于$dp[u][1]$转移,我们只需要在满足经过$u$节点的任意两个儿子都满足链长不大于阈值的情况下记录最长链即可,对于$dp[u][0]$转移我们只需要枚举把$u$这个点的power贡献给最长链和次长链下所能得到的满足任意两个儿子的链长之和不大于阈值的情况下最短的最长链.最后只需要查看一下根节点的$dp$值是否合法即可

时间复杂度$O(nlog(n * max_w))$​



