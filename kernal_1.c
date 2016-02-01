#define VIDEO_MEM 0xb8000


int kmain();

void entry() {
		kmain();	
}

void print(char * message)
{
	char * p_video_buffer = (char *) VIDEO_MEM;
	char * p_next_char = message;
	while(*p_next_char){
		*p_video_buffer = *p_next_char;
		p_next_char++;
		p_video_buffer += 2; 
	}
}

int kmain(){
	char * p_video_mem = (char *) 0xb8000;
	*p_video_mem = '!';
	
	print(" EXECUTING C KERNEL ");
	while(1)
	{

	}
	return 0 ; 
}
