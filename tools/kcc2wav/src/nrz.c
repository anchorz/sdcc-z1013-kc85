#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MONO 1 
#define STEREO 2 
#define BIT8 1 
#define BIT16 2 

#define CHANNELS MONO
#define BYTE_PER_SAMPLE BIT16

#define SAMPLE_RATE 48000
//#define SAMPLE_RATE 96000

#define VOLUME_MAX 15000

#define FREQ_EINS_BIT  2400
//#define FREQ_EINS_BIT  9600

//#define SHOW_BIT 10

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
    writeLeInt32(f,2*SAMPLE_RATE); // sample rate 
    writeLeInt32(f,2*SAMPLE_RATE*CHANNELS*BYTE_PER_SAMPLE); //byte rate
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
    //printf("data=%d\n",data);
    if (bufferSize<SIZE)
    {
        buffer[bufferSize]=data;
        bufferSize++;
        return;
    }
    callBack(bufferSize);
    bufferSize=0;
}

int phase=1;

#define SAMPLE1 7
int sampleDataOne[7]={15,14,13,12, 11,10,9};
#define SAMPLE0 15
int sampleDataNull[SAMPLE0]={19,18,17,16,15,14,13,12,11,10,9,8,7,6,5};


void calculateWaveForm()
{
    //int steps=SAMPLE_RATE/FREQ_EINS_BIT/2;
    //printf("Freq: %d Rate: %d Steps:%d\n",FREQ_EINS_BIT,SAMPLE_RATE,steps);
    //sampleDataOne=malloc(steps*sizeof(int));
    for (int index=0;index<SAMPLE1;index++)
    {
        //double phi=(M_PI*index)/steps;
        //sampleDataOne[index]=sin(phi+M_PI/steps/2)*13400;
        //printf("%6d\n",sampleDataOne[index]);
        sampleDataOne[index]=1000*sampleDataOne[index];
        //printf("%d\n",sampleDataOne[index]);
    }

    //printf("\n");
    //int steps*=2;
    //sampleDataNull=malloc(steps*sizeof(int));
    for (int index=0;index<SAMPLE0;index++)
    {
        sampleDataNull[index]=1000*sampleDataNull[index];
        //double phi=(M_PI*index)/steps;
        //sampleDataNull[index]=sin(phi+M_PI/steps/2)*18750;
        //printf("%6d\n",sampleDataNull[index]);
//sampleDataNull[index]=VOLUME_MAX;
/*        if (index<steps/4) 
        {
            sampleDataNull[index]=sampleDataOne[index];
        } else if (index<(steps-steps/4)) 
        {
            sampleDataNull[index]=VOLUME_MAX;
        } else
        {
            int left=steps-index-1;
            sampleDataNull[index]=sampleDataOne[left];
        }        
        sampleDataNull[index]=VOLUME_MAX;
*/
        //printf("%d\n",sampleDataNull[index]);
    }
}



void write_t1()
{
    //int steps=SAMPLE_RATE/FREQ_EINS_BIT/2;
    //steps-=3;
    //printf("EINS steps(%d) pref=%d\n",steps,previousBit);
    for (int index=0;index<SAMPLE1;index++)
    {
        //bufferWrite(VOLUME_MAX*phase);
        bufferWrite(sampleDataOne[index]*phase);
    }
    phase=-phase;
}

void write_t0()
{
    int steps=SAMPLE_RATE/FREQ_EINS_BIT/2;
    steps*=2;
    steps-=5;
    for (int index=0;index<steps;index++)
    {
        //bufferWrite(VOLUME_MAX*phase);
        //printf("NULL: %d\n",sampleDataNull[index]);
        bufferWrite(sampleDataNull[index]*phase);
    }
    phase=-phase;
}


void write_1()
{
    write_t1();
}

void write_0()
{
    //write_t1();
    write_t0();
}

void write_1x(int count)
{
    for (int i=0;i<count;i++)
    {
        write_1();
    }
}

void writeByte(unsigned int value)
{
    value&=0xff;

    //printf("%02x ",value);
    for (int i = 0; i < 8; i++) 
    {
    	if ((value & 0x80) ) 
        {
            //printf("I");
    		write_1();
            //zeroCount=0;
		} else 
        {
            //printf("o");
			write_0();
            //zeroCount++;
            //if (zeroCount==2)
            //{
    		 //   //printf("/");
        	//	write_1();
                //zeroCount=0;
            //}
		}
		value *=2;
	}
   // write_0();
}

void writeSyncFrame(int sync)
{
    //printf("writeSyncFrame()\n");
    for (int i=0;i<sync;i++)
    {
        write_t1();
     //   write_t0();
    }
    int steps=SAMPLE_RATE/FREQ_EINS_BIT/2;
    steps*=4;
    for (int index=0;index<steps;index++)
    {
        //printf("NULL: %d\n",sampleDataNull[index]);
        bufferWrite(VOLUME_MAX*phase-index*300+2000);
    }
    phase=-phase;
}

unsigned char data[65536];
unsigned int dataPtr;
unsigned int dataLen;

void writeBlock(unsigned int block,unsigned char *data,int sync)
{
    int checksum = 0;

    writeSyncFrame(sync);
	writeByte(block);
	for (int i = 0; i < 128; i++) 
    {
		char c = data[i];
		checksum += c;
		writeByte(c);
      //  printf("%02x %02x\n",c,checksum);
	}
    // printf("b %02x %02x\n",block,checksum);
	writeByte(checksum);
}

void createData(void(*p)(int))
{
    unsigned char *blockPtr=data;
    unsigned int block=1;

    buffer_initialize(p);
    writeBlock(block,data,256);
    int blocksLeft = (dataLen - 1) / 128; //-128+127 modulu
	while (blocksLeft > 0) {
	    if (blocksLeft > 1) {
			block++;
		} else {
			block = 0xff;
		}
		printf("%02x> ", block);
        blockPtr+=0x80;
        writeBlock(block,blockPtr,block==2?256:64);
		blocksLeft--;
	} 
    for (int i=0;i<128;i++)
        writeByte(0xff); //extra bit for synchronization 
  
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
    //printf("len=%ld\n",len);
    fclose(in);
    return 0;
}


void dump(unsigned char *ptr,int len)
{
    int start=0x180;
    int index=0;

    while (index<len)
    {
        printf("%04x ",start+index);
        for (int i=0; i<8;i++)
        {
            printf("%02x ",ptr[index]);
            index++;
        }
        printf("\n");
    }
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

    calculateWaveForm();
    createData(count);
    printf("\n\nWRITE samples=%d:\n",length);

    f=fopen(output,"wb+");
    if (!f)
    {
        printf("can't write file \"%s\"\n",output);
        return -1;
    }
    wavWriteHeader(f,length);
    createData(write);
    calculateWaveForm();
   // dump(data,dataLen);
    fclose(f);
    return 0;
}
