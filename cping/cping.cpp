// cping.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//
#include <windows.h>
#include <iostream>
#include <winuser.h>
#include "ping.h"
#include "console.h"
#include "winsock.h"
//#include "winsock2.h"
#include <string.h>
#include <varargs.h>

using namespace std;

void ShowHelp()
{
    const char* usage[] = {
        "USAGE:",
        "  cping <Address[/CIDR] | address_file> [-o <output filename>] [-m] [-n <size>]",
        "     [-to <time>] [-l] [-rm <number>]  [-ra <number>] [-th] [-hide] [-c] [-r]",
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
        "  If specified only -th option host will be pinged one time for access checking",
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
#define PARAM_MAX_TTL       0x2000
#define PARAM_MASK          0x3FFF

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
    options.MaxTTL = 128;
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
            continue;
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
        //PARAM_MAX_TTL
        if ((strcmp(param, "-ml") == 0) || (strcmp(param, "--maxttl") == 0))
        {
            if (FLAG_IS_SET(OptionsFlags, PARAM_MAX_TTL))
            {
                ErrorMsg = (char*)"Option -ml is already specified";
                return false;
            }
            if (index >= argc)
            {
                ErrorMsg = (char*)"Too few parameters specified";
                return false;
            }
            char* value = argv[index];
            if (IsValidInt(value))
            {
                options.MaxTTL = atoi(value);
                OptionsFlags |= PARAM_MAX_TTL;
                index++;
            }
            else
            {
                ErrorMsg = (char*)"Invalid number of max TTL value";
                return false;
            }
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
            if (!IsValidInt(argv[index]))
            {
                ErrorMsg = (char*)"Invalid number for option -n";
                return false;
            }
            options.PingSize = atoi(argv[index++]);
            OptionsFlags |= PARAM_SIZE;
            continue;
        }
        //PARAM_MANUFACTURER
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
        //SHOW HELP
        if ((strcmp(param, "-h") == 0) || (strcmp(param, "-?") == 0) || (strcmp(param, "--help") == 0))
        {
            options.ShowHelp = true;
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
                options.HostName = param;
                options.Mode = Name;
                continue;
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

bool ReadIpListFile(char* filename, IPAddress** list, int* count)
{
    FILE* f = 0;
    char* buffer = new char[256];
    memset(buffer, 0, 256);
    try
    {        
        IPAddress address;
        int mask = 32;
        int i = 0;
        *count = 0;
        if (fopen_s(&f, (const char*)filename, "rt"))
            return false;
        while (fgets(buffer, 256, f) != NULL)
        {            
            if (StrToIp(buffer, &address, &mask))
            {
                (*count)++;
            }
            else
            {
                fclose(f);
                delete[] buffer;
                return false;
            }
        }
        fseek(f, 0, SEEK_SET);
        *list = new IPAddress[*count];
        IPAddress* ptr = *list;
        while (fgets(buffer, 256, f) != NULL)
        {
            if (!StrToIp(buffer, &address, &mask))
            {
                delete[] buffer;
                delete *list;
                fclose(f);
                return false;
            }
            *ptr++ = address;
        }
        fclose(f);
        delete[] buffer;
        return true;
    }
    catch (...)
    {
        if (f != NULL)
            fclose(f);
        return false;
    }
}

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
    WSAStartup(0x0202, &wsaData);
    if (options.Mode == File)
    {
        if (options.Continuos)
        {
            std::cout << "Specifing file address list not allowed this --endless (-t) option\n";
            WSACleanup();
            return -3;
        }
        else
            if (!ReadIpListFile(options.AddressFilename, &list, &count))
            {
                WSACleanup();
                return -4;
            }
    }
    else
    {
        if (options.Mode == Name)
        {
            hostent* host = gethostbyname((const char*)options.HostName);
            if (host == NULL)
            {
                int code = GetLastError();
                char error[10];
                _itoa_s(code, error, 10,10);
                std::cout << "Cannot resolve host name " << options.HostName << "\n";
                std::cout << "Error " << error << endl;                
                WSACleanup();
                return -5;
            }            
            std::cout << "Name resolved to " << IpToStr((IPAddress)htonl(*(u_long*)host->h_addr_list[0])) << endl;
            options.CIDR = 32;
            options.Mask = 32;
            options.Address = htonl(*(uint32_t*)host->h_addr_list[0]);
        }
        if ((options.Mask < 32) && (options.Continuos))
        {
            std::cout << "Options --endless (-t) allowed only for value of the mask parameter is 32\n";
            WSACleanup();
            return -4;
        }
        else
            FillIpList(options.Address, options.CIDR, &list, &count);
    }
    
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
        char* header = new char[81];
        memset(header, 0, 81);       
        strcpy_s(header, 80, "IP Address      ");
        strcpy_s(line, 80, "----------------");
        if (options.ShowMAC)
        {
            strcat(header, 81, "| MAC address       ", NULL);
            strcat(line, 80, "+-------------------", NULL);
        }
        if (options.Retries > 1)
        {
            strcat(header, 81, "| send(rec)",NULL);
            strcat(line, 81, "+----------", NULL);
        }
        if (options.ShowTime)
        {          
            strcat(header, 81, "| Time  ", NULL);
            strcat(line,81,    "+-------",NULL);
        }
        if (options.ShowTTL)
        {
            strcat(header, 81, "|  TTL ", NULL);
            strcat(line, 81, "+------", NULL);
        }
        if (options.Resolve)
        {
            strcat(header, 81, "| HostName ", NULL);
            strcat(line, 81, "+----------", NULL);
        }
        _textOut(header);
        _textOut(line);
        PingByList(list, count, options);
    }
    if (options.ShowManufacturer)
        CloseDb();
    WSACleanup();
}