/*

PROB: prefix

LANG: C++

*/

#include <fstream>


using namespace std;


int main()

{

    ifstream fin("prefix.in");

    ofstream fout("prefix.out");

    string prim[201],str="",t;

    bool able[200001]={false};

    able[0]=true;

    int i,j,u,v,num=0;

    while(fin>>t&&t!=".") prim[num++]=t;

    while(fin>>t) str+=t;

    for(i=1;i<=str.size();i++)

    {

        for(j=0;j<num;j++)

        {

            if(prim[j].size()>i) continue;

            for(u=i-1,v=prim[j].size()-1;v>=0&&str[u]==prim[j][v];u--,v--);

            if(v<0&&able[i-prim[j].size()]) able[i]=true;

        }

    }

    for(i=str.size();!able[i];i--);

    fout<<i<<endl;

    return 0;

}
