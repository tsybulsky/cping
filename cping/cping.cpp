// cping.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//
#include <windef.h>
#include <iostream>
#include <winuser.h>
#include "ping.h"
#include "console.h"
#include "winsock.h"
#include <string.h>
#include <varargs.h>

using namespace std;

void ShowHelp()
{
    const char* usage[] = {
        "USAGE:",
        "  cping <Address[/CIDR] | address_file> [-o <output filename>] [-m] [-n <size>]",
        "     [-t <time>] [-l] [-rm[:number>]]  [-ra[:number]] [-th] [-hide] [-c] [-r]",
        "Address/CIDR",
        "    Host('s) IP address(es) in CIDR notation with network bits used. If CIDR is",
        "    ommited used value of 32  bits. CIDR  value must  be between  1 and 32. The",
        "    most commonly used values  are 24, 30 or  16. Specifying to small  value is",
        "    encreased entire time of execution.",
        "address_file",
        "    Name of the text file contained  list of IP  address  or networks  to ping.",
        "    Each line of this file must contain value of address/CIDR notation as desc-",
        "    ribed above",
        "-o output_file, --output output_file",
        "   Name of the  output file. In this  file utility  will output all information",
        "   about hosts",
        "-m, --mac",
        "   Set to resolve and to output MAC addresses of the hosts.Note, if the host is",
        "   outside of  the current  physical segment  of the network  hardware  address",
        "   (MAC) cannot be retrieved correctly",
        "-n <size>, --size <size>",
        "   Specified packet size in bytes.Default value is 56",
        "-to <time>, --timeout <time>",
        "   Sets the  timeout of the  host response  is ms.Default value is 500 ms. It's",
        "   necessary to specify big value because that inreased execution time.",
        "-l, --ttl",
        "   Outputs TTL of the packets",
        "-rm [number], --tries [number]",
        "   Output tries to ping host and maximum response time in ms. Default  value of",
        "   the number is 1",
        "-ra [number], --average [number]",
        "   Output  number  of  tries to  ping host  and averange  response time  in ms.",
        "   Default value of the number is 1",
        "-th, --notime",
        "   Don't output reponse time in the output table",
        "-a, -all",
        "   Display  unavailable host. This flag is always set when value of the mask is",
        "   32.",
        "-t, -c, --endless",
        "   Continiuos ping specified  host. Then specify  this flag  the -hide  and -th",
        "   options are ignored.This parameters can be used  only for node host(mask 32)",
        "-r, --resolve",
        "   Resolve host(s') name(s)",
        "-h, -?, --help",
        "   Show help",
        "-s, --statistics",
        "   Show statistics after ping",
        "-M, --manufacturer",
        "   Show manufacturer's name regardless MAC code. if this options is used -m is",
        "   set too for MAC resolution",
        "-f, --filter",
        "   Experimental options for output filtration",
        "NOTICE: if -th -rm and -ra options ommited -rm used  is set as default  option.",
        "  If specified only -th option host will be pinged one time for access cheking",
        NULL };
    int index = 0;
    while (usage[index] != NULL)
    {
        if (WhereY() == 24)
        {
            cout << "Press ANY key for continue...";            
            FlushInputBuffer();
            ReadKey();
            ClrScr();
        }
        cout << usage[index++] << endl;
    }
}

PingOptions options;
char* ErrorMsg;

#define PARAM_TIMEOUT       0x0001
#define PARAM_OUTPUTFILE    0x0002
#define PARAM_MAC           0x0004
#define PARAM_TIMEHIDE      0x0008
#define PARAM_SHOWALWAYS    0x0010
#define PARAM_SIZE          0x0020
#define PARAM_TTL           0x0040
#define PARAM_MINTIME       0x0080
#define PARAM_AVGTIME       0x0100
#define PARAM_ENDLESS       0x0200
#define PARAM_RESOLVE       0x0400
#define PARAM_MANUFACTURER  0x0800
#define PARAM_FILTER        0x1000
#define PARAM_MASK          0x1FFF

#define FLAG_IS_SET(Flags, Flag) ((Flags & Flag) != 0)

bool IsValidInt(char* str)
{
    if (str == NULL)
        return false;
    int i = 0;
    while ((i < 10) && (str[i] != '\0'))
    {
        if ((str[i] < '0') || (str[i] > '9'))
            return false;
        i++;
    }
    return i < 10;
}

bool ParseParams(int argc, char** argv)
{
    memset(&options, 0, sizeof(options));
    options.Mask = 32;
    options.Mode = None;   
    options.Address = 0;
    options.AddressFilename = NULL;
    options.HideUnavailable = true;
    options.PingSize = 56;
    options.Retries = 1;
    options.Timeout = 500;
    options.ShowStatistics = false;
    options.ShowManufacturer = false;
    int OptionsFlags = 0;
    int index = 1;
    while (index < argc)
    {
        char* param = argv[index++];
        size_t len = strlen(param);
        if (len <= 0)
            continue;
        //PARAM_TIMEOUT - --timeout
        if ((strcmp(param, "-to") == 0) || (strcmp(param, "--timeout") == 0))
        {
            if (index < argc)
            {
                ErrorMsg = (char*)"Too small parameters specified";
                return false;
            }
            if (FLAG_IS_SET(OptionsFlags, PARAM_TIMEOUT))
            {
                ErrorMsg = (char*)"Option -t is already specified";
                return false;
            }
            options.Timeout = atoi(param);
            OptionsFlags |= PARAM_TIMEOUT;
            continue;
        }
        //PARAM_OUTPUTFILE - --outputfile
        if ((strcmp(param, "-o") == 0) || (strcmp(param, "--output") == 0))
        {
            if (FLAG_IS_SET(OptionsFlags, PARAM_OUTPUTFILE))
            {
                ErrorMsg = (char*)"Option -o is already specified";
                return false;
            }
            if (index >= argc)
            {
                ErrorMsg = (char*)"Too few parameters specified in the line";
                return false;
            }
            options.OutputFilename = argv[index++];
            OptionsFlags |= PARAM_OUTPUTFILE;
        }
        //PARAM_MAC - --mac
        if ((strcmp(param, "-m") == 0) || (strcmp(param, "--mac") == 0))
        {
            if (FLAG_IS_SET(OptionsFlags, PARAM_MAC))
            {
                ErrorMsg = (char*)"Options -m is olready specified";
                return false;
            }
            options.ShowMAC = true;
            OptionsFlags |= 0x0004;
            continue;
        }
        //PARAM_TTL
        if ((strcmp(param, "-l") == 0) || (strcmp(param, "--ttl") == 0))
        {
            if (FLAG_IS_SET(OptionsFlags, PARAM_TTL))
            {
                ErrorMsg = (char*)"Option -l is already specified";
                return false;
            }
            OptionsFlags |= PARAM_TTL;
            options.ShowTTL = true;
            continue;
        }
        //PARAM_TIMEHIDE - -th, --notime
        if ((strcmp(param, "-th") == 0) || (strcmp(param, "--notime") == 0))
        {
            if (FLAG_IS_SET(OptionsFlags, PARAM_TIMEHIDE))
            {
                ErrorMsg = (char*)"Option -th is already specified";
                return false;
            }
            OptionsFlags |= PARAM_TIMEHIDE;
            options.ShowTime = false;
            continue;
        }
        //PARAM_SHOWALWAYS
        if ((strcmp(param, "-all") == 0) || (strcmp(param, "-a") == 0))
        {
            if (FLAG_IS_SET(OptionsFlags, PARAM_SHOWALWAYS))
            {
                ErrorMsg = (char*)"Option -all is already specified";
                return false;
            }
            OptionsFlags |= PARAM_SHOWALWAYS;
            options.HideUnavailable = false;
            continue;
        }
        //PARAM_ENDLESS   
        if ((strcmp(param, "-c") == 0) || (strcmp(param, "-t") == 0) || (strcmp(param, "--endless") == 0))
        {
            if (FLAG_IS_SET(OptionsFlags, PARAM_ENDLESS))
            {
                ErrorMsg = (char*)"Option -c is already specified";
                return false;
            }
            OptionsFlags |= PARAM_ENDLESS;
            options.Continuos = true;
            continue;
        }
        //PARAM_RESOLVE    
        if ((strcmp(param, "-r") == 0) || (strcmp(param, "--resolve") == 0))
        {
            if (FLAG_IS_SET(OptionsFlags,PARAM_RESOLVE))
            {
                ErrorMsg = (char*)"Option -r is already specified";
                return false;
            }
            OptionsFlags |= PARAM_RESOLVE;
            options.Resolve = true;
            continue;
        }
        //PARAM_MINTIME
        if ((strcmp(param, "-rm") == 0) || (strcmp(param, "--mintime") == 0))
        {
            if (FLAG_IS_SET(OptionsFlags, PARAM_MINTIME))
            {
                ErrorMsg = (char*)"Option -tm already exists";
                return false;
            }
            OptionsFlags |= PARAM_MINTIME;
            if (index < argc)
            {
                char* value = argv[index];
                if (IsValidInt(value))
                {
                    options.Retries = atoi(value);
                    index++;
                }
            }
            continue;
        }
        //PARAM_AVGTIME
        if ((strcmp(param, "-ra") == 0) || (strcmp(param, "--avgtime") == 0))
        {
            if (FLAG_IS_SET(OptionsFlags, PARAM_AVGTIME))
            {
                ErrorMsg = (char*)"Option -tm already exists";
                return false;
            }
            OptionsFlags |= PARAM_AVGTIME;
            if (index < argc)
            {
                char* value = argv[index];
                if (IsValidInt(value))
                {
                    options.Retries = atoi(value);
                    index++;
                }
            }
            continue;
        }
        //PARAM_SIZE
        if ((strcmp(param, "-n") == 0) || (strcmp(param, "--size") == 0))
        {
            if (FLAG_IS_SET(OptionsFlags, PARAM_SIZE))
            {
                ErrorMsg = (char*)"Option -n already specified";
                return false;
            }
            if (index >= argc)
            {
                ErrorMsg = (char*)"Too few parameters specified";
                return false;
            }
            if (!IsValidInt(argv[index + 1]))
            {
                ErrorMsg = (char*)"Invalid number for option -n";
                return false;
            }
            options.PingSize = atoi(argv[index++]);
            OptionsFlags |= PARAM_SIZE;
            continue;
        }
        if ((strcmp(param, "-M") == 0) || (strcmp(param, "--manufacturer") == 0))
        {
            if (FLAG_IS_SET(OptionsFlags, PARAM_MANUFACTURER))
            {
                ErrorMsg = (char*)"Option -M already specified";
                return false;
            }
            options.ShowManufacturer = true;
            OptionsFlags |= PARAM_MANUFACTURER;
            continue;
        }
        if (options.Mode != None)
        {
            ErrorMsg = (char*)"Pinging host already specified";
            return false;
        }
        if (!StrToIp(param, &(options.Address), (int*) & (options.CIDR)))
        {
            options.Address = 0;
            options.Mask = 0;
            FILE* f;
            if (fopen_s(&f,param, "r") == 0)
            {
                fclose(f);
                options.AddressFilename = param;
                options.Mode = File;                
                continue;
            }
            else
            {
                ErrorMsg = (char*)"Specified file doesn't exist";
                return false;
            }
        }
        else
        {
            options.Mode = Address;
            options.Mask = CidrToMask(options.CIDR);
            continue;
        }
        len = strlen(param)+strlen("Unknown option ")+1;
        ErrorMsg = new char[len];
        sprintf_s(ErrorMsg, len, "Unknown option %s", param);
        return false;
    }
    return true;
}

FILE* fout;

bool _textOut(char* value)
{
    std::cout << value << "\n";
    if (fout != NULL)
    {
        fprintf(fout, value);
        fprintf(fout, "\n");
    }
    return !KeyPressed();
}

char* strcat(char* dest, size_t maxSize, ...)
{
    va_list p;
    va_start(p, maxSize);
    int len = 0;
    char* item, * end = dest + maxSize-1;
    char* index = dest;
    while (*(index++) != NULL);
    index--;
    while ((item = va_arg(p, char*)) != NULL)
    {
        while ((*(index++) = *(item++)) != 0)
        {            
            if (index >= end)
            {
                *(end-1) = 0;
                return dest;                
            }
        }
        index--;
    }    
    *index = 0;
    va_end(p);
    return dest;
}

bool _infoOut(uint32_t address, int size, int time,
    int ttl, char* mac, char* name, int recevied, int total, char* manufacturer)
{
    char outputString[81]{};
    char tempValue[41]{};
    char* ip = IpToStr(address);
    sprintf_s(outputString, 80, "%-15s ", ip);
    if (options.ShowMAC)
    {
        if (mac != NULL)
            sprintf_s(tempValue, 30, "\xB3 %-17s ", mac);
        else
            sprintf_s(tempValue, 30, "\xB3 %-17s ", "");
        strcat(outputString, 81, tempValue, NULL);
    }
    if (options.Retries > 1)
    {
        sprintf_s(tempValue, 30, "%d(%d)", recevied, total);        
        strcat(outputString, 81, "\xB3 ", tempValue, NULL);
    }
    if (options.ShowTime)
    {
        if (time == -1)
            strcat(outputString, 80, "\xB3   *   ", NULL);
        else
        {
            sprintf_s(tempValue, 30, "\xB3 %5d ", time);
            strcat(outputString, 80, tempValue, NULL);
        }
    }
    if (options.ShowTTL)
    {
        sprintf_s(tempValue, 30, "\xB3 %4d ", ttl);
        strcat(outputString, 80, tempValue, NULL);
    }
    if (options.Resolve)
    {
        if (name == NULL)
            name = (char*)"";
        strcat(outputString, 80, "\xB3 ", name, NULL);
    }
    if ((options.ShowManufacturer)&&(manufacturer != NULL))
    {
        _textOut(outputString);
        return _textOut(manufacturer);
    }
    else
        return _textOut(outputString);
}

bool _progress(char* value)
{
    GotoXY(1, WhereY());
    ClrEol();
    std::cout << value << std::endl;
    GotoXY(1, WhereY() - 1);
    return !KeyPressed();
}

void AddrToABCD(IPAddress address, unsigned char* a, unsigned char* b, unsigned char* c, unsigned char* d)
{
    *a = (address >> 24) & 0xFF;
    *b = (address >> 16) & 0xFF;
    *c = (address >> 8) & 0xFF;
    *d = address & 0xFF;
}

void FillIpList(IPAddress address, int cidr, IPAddress** list, int* count)
{
    *count = 0;
    *count = 1 << (32 - cidr);
    uint32_t mask = CidrToMask(cidr);
    *list = new IPAddress[*count];
    IPAddress* ptr = *list;
    unsigned char a1, b1, c1, d1;
    unsigned char a2, b2, c2, d2;
    AddrToABCD(address & mask,&a1,&b1,&c1,&d1);
    AddrToABCD(address | (~mask),&a2, &b2, &c2, &d2);
    for (int p1 = a1; p1 <= a2; p1++)
    {
        for (int p2 = b1; p2 <= b2; p2++)
        {
            for (int p3 = c1; p3 <= c2; p3++)
            {
                for (int p4 = d1; p4 <= d2; p4++)
                {
                    IPAddress address = (IPAddress)(((p1 << 24) | (p2 << 16) | (p3 << 8) | p4));
                    if (((address & (~mask)) != 0) && ((address | mask) != 0xFFFFFFFF))
                        *ptr++ = address;
                }
            }
        }
    }
}
WSADATA wsaData;

int main(int argc, char** argv)
{
    InitConsole();   
    IPAddress* list;
    int count;
    std::cout << "Extended ping utility\n(c)2023, Mikhail Tsybulski\n";
    if (!ParseParams(argc, argv))
    {
        std::cout << ErrorMsg << "\n";
        ShowHelp();
        
        return 0;
    }
    if (options.ShowHelp)
    {
        ShowHelp();
        
        return 0;
    }
    if (options.Mode == None)
    {
        std::cout << "Mode is undefined\n";
        ShowHelp();
        return 0;
    }
    if (options.OutputFilename != NULL)
    {
        try
        {
            fopen_s(&fout,options.OutputFilename, "wt+");
        }
        catch (...)
        {
            return -2;
        }
    }
    SetCallback(&_textOut, &_infoOut, &_progress);
    if (options.Mode == File)
    {
        if (options.Continuos)
        {
            std::cout << "Specifing file address list not allowed this --endless (-t) option\n";
            return -3;
        }
        else
            return 0;// ReadIpListFile(options.AddressFilename, &list, &count);
    }
    else
    {
        if ((options.Mask < 32) && (options.Continuos))
        {
            std::cout << "Options --endless (-t) allowed only for value of the mask parameter is 32\n";
            return -4;
        }
        else
            FillIpList(options.Address, options.CIDR, &list, &count);
    }
    WSAStartup(0x0202, &wsaData);
    if (options.ShowManufacturer)
        if (!OpenDb())
            options.ShowManufacturer = false;
    if ((options.Mask == -1) || (options.Mask == 32))   //указатель нормального режима пинга
    {
        PingNormalMode(options.Address, options, options.Continuos);
    }
    else
    {        
        char* line = new char[81];
        memset(line, '\xC4', 80);
        line[80] = '\0';
        std::cout << "IP Address      ";
        int index = 16;
        if (options.ShowMAC)
        {
            std::cout << "\xB3 MAC address       ";                        
            line[index] = '\xC5';
            index += 20;
        }
        if (options.Retries > 1)
        {
            std::cout << "\xB3 send(rec)";
            
            line[index] = '\xC5';
            index += 11;
        }
        if (options.ShowTime)
        {
            std::cout << "\xB3 Time  ";
            
            line[index] = '\xC5';
            index += 8;
        }
        if (options.ShowTTL)
        {
            std::cout << "\xB3  TTL ";
            
            line[index] = '\xC5';
            index += 7;
        }
        if (options.Resolve)
        {
            std::cout << "\xB3 HostName " << std::endl;
            line[index] = '\xC5';
        }
        std::cout << line << std::endl;
        PingByList(list, count, options);
    }
    if (options.ShowManufacturer)
        CloseDb();
    WSACleanup();
}