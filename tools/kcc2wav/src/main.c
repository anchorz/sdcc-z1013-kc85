#include <math.h>
#include <stdio.h>
#include <string.h>

#define MONO 1 
#define STEREO 2 
#define BIT8 1 
#define BIT16 2 

#define CHANNELS MONO
#define BYTE_PER_SAMPLE BIT16
#define SAMPLE_RATE 48000

#define VOLUME_MAX 10000

#define FREQ_EINS_BIT  1000
#define FREQ_NULL_BIT  1846
#define FREQ_TRENNZEICHEN 545
#define FREQ_PAUSE 97

//#define FREQ_TRENNZEICHEN 700
//#define FREQ_PAUSE 2400
//#define FREQ_EINS_BIT  1170
//#define FREQ_NULL_BIT  2000


void writeLeInt32(FILE *f,int v)
{
    char c=v;
    fwrite(&c,1,1,f);    

    v/=256;
    c=v;
    fwrite(&c,1,1,f);    

    v/=256;
    c=v;
    fwrite(&c,1,1,f);    

    v/=256;
    c=v;
    fwrite(&c,1,1,f);    
}

void writeLeInt16(FILE *f,int v)
{
    char c=v;
    fwrite(&c,1,1,f);    

    v/=256;
    c=v;
    fwrite(&c,1,1,f);    

}


void wavWriteHeader(FILE *f,int length)
{  
    char riff[4]="RIFF";
    char wave[4]="WAVE";
    char fmt[4]="fmt ";
    char data[4]="data";

    int chunkSize=36+length*CHANNELS*BYTE_PER_SAMPLE;

    fwrite(riff,4,1,f);  
    writeLeInt32(f,chunkSize);
    fwrite(wave,4,1,f);  
    fwrite(fmt,4,1,f);  
    writeLeInt32(f,16); //pcm
    writeLeInt16(f,1); //pcm
    writeLeInt16(f,CHANNELS); //mono-1 stereo-2
    writeLeInt32(f,SAMPLE_RATE); // sample rate 
    writeLeInt32(f,SAMPLE_RATE*CHANNELS*BYTE_PER_SAMPLE); //byte rate
    writeLeInt16(f,CHANNELS*BYTE_PER_SAMPLE); //block alignment
    writeLeInt16(f,BYTE_PER_SAMPLE*8); //bits per sample
    fwrite(data,4,1,f);  
    writeLeInt32(f,length*CHANNELS*BYTE_PER_SAMPLE); //byte rate
}

#define SIZE 4096
signed int buffer[SIZE];
int bufferSize=0;
void (*callBack)(int);

void buffer_initialize(void(*p)(int))
{
    bufferSize=0;
    callBack=p;
}

void buffer_finalize()
{
    callBack(bufferSize);
    bufferSize=0;
}


void bufferWrite(signed int data)
{
    if (bufferSize<SIZE)
    {
        buffer[bufferSize]=data;
        bufferSize++;
        return;
    }
    callBack(bufferSize);
    bufferSize=0;
}

//4800HZ from 48K
int samples[]={3090,8090};

void writePeriod(int freq)
{
    int steps=SAMPLE_RATE/freq;
    //printf("steps=%d\n",steps);
    for (int index=0;index<steps;index++)
    {
        if (index<steps/4)
        {
            switch (index)
            {
                case 0: bufferWrite(samples[0]);break;
                case 1: bufferWrite(samples[1]);break;
                default: bufferWrite(10000);break;
            }
        } else if (index<steps/2)
        { 
            int left=steps/2-index-1;
            switch (left)
            {
                case 0: bufferWrite(samples[0]);break;
                case 1: bufferWrite(samples[1]);break;
                default: bufferWrite(10000);break;
            }
        } else if (index<(steps*3)/4)
        {
            int cnt=index-steps/2;
            switch (cnt)
            {
                case 0: bufferWrite(-samples[0]);break;
                case 1: bufferWrite(-samples[1]);break;
                default: bufferWrite(-10000);break;
            }
        } else
        {
            int left=steps-index-1;
            switch (left)
            {
                case 0: bufferWrite(-samples[0]);break;
                case 1: bufferWrite(-samples[1]);break;
                default: bufferWrite(-10000);break;
            }
        }
    }
}

void writePeriods(int count,int freq)
{
    for (int i=0;i<count;i++)
    {
        writePeriod(freq);
    }
}

void writeByte(unsigned int value)
{
    for (int i = 0; i < 8; i++) 
    {
    	if ((value & 1) == 1) 
        {
    		writePeriod(FREQ_EINS_BIT);
		} else 
        {
			writePeriod(FREQ_NULL_BIT);
		}
		value >>= 1;
	}
	writePeriod(FREQ_TRENNZEICHEN);
}

unsigned char data[65536];
unsigned int dataPtr;
unsigned int dataLen;

void createData(void(*p)(int))
{
    int block=0;
    dataPtr=0;
    
    buffer_initialize(p);

    writePeriods(1000,FREQ_EINS_BIT);
    writePeriod(FREQ_TRENNZEICHEN);
    printf("%02x> ", block);
	writeByte(block);
	int checksum = 0;
	for (int i = 0; i < 128; i++) 
    {
		char c = data[dataPtr++];
		checksum += c;
		writeByte(c);
	}
	writeByte(checksum);
	writePeriod(FREQ_PAUSE);

	int blocksLeft = (dataLen - 1) / 128; //-128+127 modulu
	while (blocksLeft > 0) {
        writePeriods(160, FREQ_EINS_BIT);
        writePeriod(FREQ_TRENNZEICHEN);
	    if (blocksLeft > 1) {
			block++;
		} else {
			block = 0xff;
		}
		printf("%02x> ", block);
		if (block % 15 == 0) {
			printf("\n");
		}
		writeByte(block);
		checksum = 0;
		for (int i = 0; i < 128; i++) {
			char c = data[dataPtr++];
			checksum += c;
			writeByte(c);
		}
		writeByte(checksum);
		writePeriod(FREQ_PAUSE);
		blocksLeft--;
		} // silence
		for (int i = 0; i < SAMPLE_RATE / 2; i++) {
			bufferWrite((short) 0x0);
		}
    buffer_finalize(p);
}


int length=0; // count in samples
void count(int i)
{
    length+=i;
    //printf("count=%d length=%d\n",i,length);
}

FILE *f;

void write(int len)
{
    int i;
    //printf("write %d\n",len);
    for (i=0; i<len;i++)
    {
       char c=buffer[i];
       fwrite(&c,1,1,f);         
       c=buffer[i]/256;
       fwrite(&c,1,1,f);         
    }
}


void usage(const char *pname)
{
    printf("konvertiert eine KCC-Datei nach .WAV\n");
    printf("%s <KCC File> <output.wav>\n",pname);
}

int load(const char *kcc)
{
    size_t len;

    printf("loading \"%s\"\n",kcc);
    FILE *in;
    in=fopen(kcc,"rb+");
    if (!in)
    {
        printf("can't write file\n");
        return -1;
    }
    memset(data,0xff,65536);
    len=fread(data,1,65536,in);
    dataLen=len;
    printf("len=%ld\n",len);
    fclose(in);
    return 0;
}

int main(int argc, char **argv)
{
    char *output;

    if (argc!=3)
    {
        usage(argv[0]);
        return -1;
    }
    if (load(argv[1]))
    {
        return -1;
    }

    output=argv[2];

    printf("Trenner=%d FREQ_PAUSE=%d EINS=%d\n",FREQ_TRENNZEICHEN,FREQ_PAUSE,FREQ_EINS_BIT);

    f=fopen(output,"wb+");
    if (!f)
    {
        printf("can't write file \"%s\"\n",output);
        return -1;
    }

    createData(count);

    wavWriteHeader(f,length);
    createData(write);

    fclose(f);
    return 0;
}
