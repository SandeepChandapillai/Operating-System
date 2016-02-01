

int fn1()
{
	int x = 12323; 
	return 0x1234abcd;
}


int fn2()
{
	int x = 12312 ; 
	int y = 213213; 
	int asdf = x + y ; 
	return 0x1231; 
}

int add(int a , int b)
{
	return a + b ; 
}
int addP(int *a , int *b)
{
	return *a + *b ; 
}


int sum(int a)
{
	int result  = 0 ; 
	int i = 0 ; 
	for(;i < a ; i++)
		result += i ;
	return result; 
}
