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


#define DF_SAMPLE_RATE 96000
//20
//#define DF_BASE_FREQ   4800
//18
#define DF_BASE_FREQ   3600
#define DF_SAMPLES     (DF_SAMPLE_RATE/DF_BASE_FREQ/2)

#define SAMPLE1 DF_SAMPLES
#define SAMPLE0 DF_SAMPLES*2

//6888
//#define SAMPLE1 DF_SAMPLES-1
//#define SAMPLE0 DF_SAMPLES*2+1


#define VOLUME_MAX 15000


void dump(unsigned char *ptr,unsigned int aadr,int len)
{
    int start=aadr;
    int index=0;

    printf("len=%d\n",len);

    while (index<len)
    {
        printf("%04x ",start+index);
        for (int i=0; i<8;i++)
        {
            if (index<len)
            {   
                printf("%02x ",ptr[index]);
            } else
            {
                printf(".. ");
            }
            
            if (i==3)
            {
                printf(" ");
            }
            index++;
        }
        printf("\n");
    }
}


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
    writeLeInt32(f,DF_SAMPLE_RATE); // sample rate 
    writeLeInt32(f,DF_SAMPLE_RATE*CHANNELS*BYTE_PER_SAMPLE); //byte rate
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


int sampleDataOne[SAMPLE1];
int sampleDataNull[SAMPLE0];

#define ADDON 0+10000
//#define ADDON 1

void calculateWaveForm()
{
    //int steps=SAMPLE_RATE/FREQ_EINS_BIT/2;
    //intf("Freq: %d Rate: %d Steps:%d\n",FREQ_EINS_BIT,SAMPLE_RATE,steps);
    //sampleDataOne=malloc(steps*sizeof(int));
    for (int index=0;index<SAMPLE1;index++)
    {
        int val=18000-log(index+1)*6000;
        sampleDataOne[index]=val*ADDON;
        printf("%d %d %f\n", sampleDataOne[index],index,log(index+1));
    }

    printf("sample1 %d \n",SAMPLE1);
    //int steps*=2;
    //sampleDataNull=malloc(steps*sizeof(int));
    for (int index=0;index<SAMPLE0;index++)
    {
        int val=10000-log(index+1)*2000;
        sampleDataNull[index]=val*4/10*ADDON;
        printf("%d %d %f\n",sampleDataNull[index],index,log(index+1));
    }
}



void write_t1()
{
    for (int index=0;index<SAMPLE1;index++)
    {
        bufferWrite(sampleDataOne[index]*phase);
    }
    phase=-phase;
}

void write_t0()
{
    for (int index=0;index<SAMPLE0;index++)
    {
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

    printf("%02x ",value);
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


void writeWord(unsigned int value)
{
    writeByte(value & 0xff);
    writeByte((value/256) & 0xff);
}

void writeSyncFrame(int sync)
{
    //printf("writeSyncFrame()\n");
    for (int i=0;i<sync;i++)
    {
        write_t1();
    }
    write_t0();
    /*
    int steps=SAMPLE1;
    for (int index=0;index<steps;index++)
    {
        bufferWrite(sampleDataOne[index]*phase);
    }
    steps*=3;
    for (int index=0;index<steps;index++)
    {
        //int slope=VOLUME_MAX;
        //int val=(VOLUME_MAX*12/10-((slope*index)/steps))*phase;
        bufferWrite(1500);
      //  printf("sync: %d\n",val);
     //   bufferWrite(VOLUME_MAX*phase+VOLUME_MAX/index-(VOLUME_MAX*2)/10);
    }
    phase=-phase;
    write_t1();  
*/
}

unsigned char data[65536];
unsigned int dataPtr;
unsigned int dataLen;

void writeBlock(unsigned int block,unsigned char *data,int sync)
{
    //unsigned int checksum = 0;

    //writeSyncFrame(sync);
	//writeWord(block);
	//for (int i = 0; i < 32; i++) 
    //{
	//	char c = data[i];
	//	checksum += c;
	//}
    // printf("b %02x %02x\n",block,checksum);
	//writeWord(checksum);
}

#define BLOCK_LEN 32

void writeBlock32(unsigned int aadr,unsigned char *rawData)
{
    unsigned int checksum,i;

    checksum=0;
    writeWord(aadr);
    checksum+=aadr;
    for(i=0;i<BLOCK_LEN; i+=2)
    {
        unsigned int w=rawData[i+1]*256+rawData[i];
        writeWord(w);
        checksum+=w;
    }
    writeWord(checksum & 0xffff);
}  

void writeHeader(unsigned char *kccHeader)
{
    unsigned char block[BLOCK_LEN];        
    unsigned int eadr,sadr,i;

    writeSyncFrame(16);
    memset(block,0x00,BLOCK_LEN);
    block[0]=kccHeader[0x11] ;//aadr
    block[1]=kccHeader[0x12] ;//aadr
    eadr=kccHeader[0x14]*256+kccHeader[0x13];
    eadr-=1;
    block[2]=eadr & 0xff; 
    block[3]=(eadr/256) & 0xff;

    sadr=kccHeader[0x16]*256+kccHeader[0x15];
    if (sadr!=0 && kccHeader[0x10]<3)
    {
        printf("Warnung: Startaddresse im .KCC Header ist 0x%04x. Dieser wird aber nicht\n",sadr);
        printf("         zum Autostart verwendet. Der Wert wird nicht mit übertragen.\n");
    }

    if (kccHeader[0x10]==3)
    {
        block[4]=kccHeader[0x15];
        block[5]=kccHeader[0x16];
    }
    memcpy(block+16,data,11);

    for (i=0x17;i<0x80;i++)
    {
        if (kccHeader[i]!=0)
        {
            printf("Warnung: .KCC Header Position 0x%02x(=%02x) sollte gleich 0 sein. Der Wert \n",i,kccHeader[i]);
            printf("         wird nicht mit übertragen.\n");
            break;
        }
    }     

    writeBlock32(0x00e0,(unsigned char *)block);  

}

void createData(void(*p)(int))
{
    unsigned char *blockPtr=data;

    int aadr,eadr,sadr, len,i;
    buffer_initialize(p);   
    writeHeader(data);
    printf("\n");

    aadr=data[0x11]+data[0x12]*256;
    eadr=data[0x13]+data[0x14]*256;
    sadr=data[0x15]+data[0x16]*256;
    len=eadr-aadr; //beim KC85/4 ist EADR letzte Addresse+1 !

    printf("%04x %04x %04x ...",aadr,eadr,sadr);
    for (i=0;i<11;i++)
    {
        char c=data[i];
        if (c<0x20 || c>0x7e)
        {
            c='.';   
        }
        printf("%c",c);
    }
    printf("\n");
    blockPtr=data+0x80;

	while (len > 0) {
		writeBlock32(aadr,blockPtr);
        printf("\n");
		aadr+=BLOCK_LEN;
        blockPtr+=BLOCK_LEN;
        len-=BLOCK_LEN;
	} 
    for (int i=0;i<BLOCK_LEN+4;i++)
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
